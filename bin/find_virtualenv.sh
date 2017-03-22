#!/bin/sh
# Copyright 2017 The Chromium OS Authors. All rights reserved.
# Use of this source code is governed by a BSD-style license that can be
# found in the LICENSE file.
#
# Find the virtualenv repo to use.
#
# This is meant to be sourced in scripts that need virtualenv.  The
# sourcing script should cd into the directory containing this script
# first.  This script defines functions for performing common tasks:
#
# exec_python -- Execute Python module inside of virtualenv
set -eu

if [ -d  ../../../../../infra_virtualenv ]; then
    readonly virtualenv_dir=../../../../../infra_virtualenv
elif [ -d ~chromeos-test/chromiumos/infra_virtualenv ]; then
    readonly virtualenv_dir=~chromeos-test/chromiumos/infra_virtualenv
elif [ -d  /opt/infra_virtualenv ]; then
    readonly virtualenv_dir=/opt/infra_virtualenv
else
    echo "$0: virtualenv repo not found" >&2
    exit 1
fi

readonly venv_dir=../venv/.venv
readonly reqs_file=../venv/requirements.txt

_create_venv() {
    "$virtualenv_dir/create_venv" "$venv_dir" "$reqs_file" >&2
}

exec_python_module() {
    _create_venv
    export PYTHONPATH='../venv'
    exec "$venv_dir/bin/python" -m "$@"
}