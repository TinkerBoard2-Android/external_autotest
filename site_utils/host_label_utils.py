#!/usr/bin/env python

# Copyright (c) 2014 The Chromium OS Authors. All rights reserved.
# Use of this source code is governed by a BSD-style license that can be
# found in the LICENSE file.

"""
This script provides functions to:
1. collect: Collect all hosts and their labels to metaDB, can be scheduled
            run daily, e.g.,
            ./site_utils/host_label_utils.py collect
2. query: Query for hosts and their labels information at a given day, e.g.,
          ./site_utils/host_label_utils.py query -n 172.27.213.193 -l peppy
"""

import argparse
import logging
import pprint
import time

import common
from autotest_lib.client.common_lib import time_utils
from autotest_lib.client.common_lib.cros.graphite import es_utils
from autotest_lib.frontend import setup_django_environment
from autotest_lib.frontend.afe import models


# _type used for ES
_HOST_LABEL_TYPE = 'host_labels'
_HOST_LABEL_TIME_INDEX_TYPE = 'host_labels_time_index'


def get_host_labels(days_back=0, hostname=None, labels=None):
    """Get the labels for a given host or all hosts.

    @param days_back: Get the label info around that number of days back. The
                      default is 0, i.e., the latest label information.
    @param hostname: Name of the host, if set to None, return labels for all
                     hosts. Default is None.
    @param labels: A list of labels to filter hosts.
    @return: A dictionary of host labels, key is the hostname, and value is a
             list of labels, e.g.,
             {'host1': ['board:daisy', 'pool:bvt']}
    """
    # Search for the latest logged labels before the given days_back.
    # Default is 0, which means the last time host labels were logged.
    t_end = time.time() - days_back*24*3600
    query_time_index = es_utils.create_range_eq_query_multiple(
            fields_returned=['time_index'],
            equality_constraints=[('_type', _HOST_LABEL_TIME_INDEX_TYPE),],
            range_constraints=[('time_index', None, t_end)],
            size=1,
            sort_specs=[{'time_index': 'desc'}])
    results = es_utils.execute_query(query_time_index)
    count = int(results['hits']['total'])
    t_end_str = time_utils.epoch_time_to_date_string(t_end)
    if count == 0:
        logging.error('No label information was logged before %s.', t_end_str)
        return
    time_index = results['hits']['hits'][0]['fields']['time_index'][0]
    logging.info('Host labels were recorded at %s',
                 time_utils.epoch_time_to_date_string(time_index))

    # Search for labels for a given host or all hosts, at time_index.
    equality_constraints=[('_type', _HOST_LABEL_TYPE),
                          ('time_index', time_index),]
    if hostname:
        equality_constraints.append(('hostname', hostname))
    if labels:
        for label in labels:
            equality_constraints.append(('labels', label))
    query_labels =  es_utils.create_range_eq_query_multiple(
            fields_returned=['hostname', 'labels'],
            equality_constraints=equality_constraints)
    results = es_utils.execute_query(query_labels)

    host_labels = {}
    for hit in results['hits']['hits']:
        hit = es_utils.convert_hit(hit['fields'])
        host_labels[hit['hostname']] = hit['labels']

    return host_labels


def collect_info():
    """Collect label info and report to metaDB.
    """
    # time_index is to index all host labels collected together. It's
    # converted to int to make search faster.
    time_index = int(time.time())
    hosts = models.Host.objects.filter(invalid=False)
    for host in hosts:
        info = {'hostname': host.hostname,
                'labels': [label.name for label in host.labels.all()],
                'time_index': time_index}
        es_utils.ESMetadata().post(type_str=_HOST_LABEL_TYPE, metadata=info,
                                   log_time_recorded=False)

    # After all host label information is logged, save the time stamp.
    es_utils.ESMetadata().post(type_str=_HOST_LABEL_TIME_INDEX_TYPE,
                               metadata={'time_index': time_index},
                               log_time_recorded=False)
    logging.info('Finished collecting host labels for %d hosts.', len(hosts))


def main():
    """Main script.
    """
    parser = argparse.ArgumentParser()
    parser.add_argument('action',
                        help=('collect or query. Action collect will collect '
                              'all hosts and their labels to metaDB. Action '
                              'query will query for hosts and their labels '
                              'information at a given day'))
    parser.add_argument('-d', '--days_back', type=int, dest='days_back',
                        help=('Number of days before current time. Query will '
                              'get host label information collected before that'
                              ' time. The option is applicable to query only. '
                              'Default to 0, i.e., get the latest label info.'),
                        default=0)
    parser.add_argument('-n', '--hostname', type=str, dest='hostname',
                        help=('Name of the host to query label information for.'
                              'The option is applicable to query only. '
                              'Default to None, i.e., return label info for all'
                              ' hosts.'),
                        default=None)
    parser.add_argument('-l', '--labels', nargs='+', dest='labels',
                        help=('A list of labels to filter hosts. The option is '
                              'applicable to query only. Default to None.'),
                        default=None)
    parser.add_argument('-v', '--verbose', action="store_true", dest='verbose',
                        help='Allow more detail information to be shown.')
    options = parser.parse_args()

    logging.getLogger().setLevel(logging.INFO if options.verbose
                                 else logging.WARN)
    if options.action == 'collect':
        collect_info()
    elif options.action == 'query':
        host_labels = get_host_labels(options.days_back, options.hostname,
                                      options.labels)
        pprint.pprint(host_labels)
    else:
        logging.error('action %s is not supported, can only be collect or '
                      'query!', options.action)


if __name__ == '__main__':
    main()
