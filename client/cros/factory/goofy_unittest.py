#!/usr/bin/python -u
#
# -*- coding: utf-8 -*-
#
# Copyright (c) 2012 The Chromium OS Authors. All rights reserved.
# Use of this source code is governed by a BSD-style license that can be
# found in the LICENSE file.

import factory_common

import logging
import mox
import pickle
import re
import subprocess
import tempfile
import threading
import time
import unittest

from mox import IgnoreArg

from autotest_lib.client.cros import factory
from autotest_lib.client.cros.factory import goofy
from autotest_lib.client.cros.factory import state
from autotest_lib.client.cros.factory import TestState
from autotest_lib.client.cros.factory.event import Event
from autotest_lib.client.cros.factory.goofy import Environment
from autotest_lib.client.cros.factory.goofy import Goofy


def init_goofy(env=None, test_list=None, options='', restart=True):
    '''Initializes and returns a Goofy.'''
    goofy = Goofy()
    # Make a copy (since we'll be modifying it.
    args = ['--noui']
    if restart:
        args.append('--restart')
    if test_list:
        out = tempfile.NamedTemporaryFile(prefix='test_list', delete=False)

        # Remove whitespace at the beginning of each line of options.
        options = re.sub('(?m)^\s+', '', options)
        out.write('TEST_LIST = [' + test_list + ']\n' + options)
        out.close()
        args.extend(['--test_list', out.name])
    logging.info('Running goofy with args %r', args)
    goofy.init(args, env or Environment())
    return goofy


def mock_autotest(env, name, passed, error_msg):
    '''Adds a side effect that a mock autotest will be executed.

    Args:
        name: The name of the autotest to be mocked.
        passed: Whether the test should pass.
        error_msg: The error message.
    '''
    def side_effect(name, args, env_additions, result_file):
        with open(result_file, 'w') as out:
            pickle.dump((passed, error_msg), out)
            return subprocess.Popen(['true'])

    env.spawn_autotest(
        name, IgnoreArg(), IgnoreArg(), IgnoreArg()).WithSideEffects(
        side_effect)


class GoofyTest(unittest.TestCase):
    '''Base class for Goofy test cases.'''
    options = ''

    def setUp(self):
        self.mocker = mox.Mox()
        self.env = self.mocker.CreateMock(Environment)
        self.state = state.get_instance()
        self.goofy = init_goofy(self.env, self.test_list, self.options)

    def tearDown(self):
        self.goofy.destroy()

        # Make sure we're not leaving any extra threads hanging around
        # after a second.
        for _ in range(10):
            extra_threads = [t for t in threading.enumerate()
                             if t != threading.current_thread()]
            if not extra_threads:
                break
            logging.info('Waiting for threads to die: %r', extra_threads)

            # Wait another 100 ms
            time.sleep(.1)

        self.assertEqual([], extra_threads)

    def _wait(self):
        '''Waits for any pending invocations in Goofy to complete,
        and verifies and resets all mocks.'''
        self.goofy.wait()
        self.mocker.VerifyAll()
        self.mocker.ResetAll()

    def check_one_test(self, id, name, passed, error_msg, trigger=None):
        '''Runs a single autotest, waiting for it to complete.

        Args:
            id: The ID of the test expected to run.
            name: The autotest name of the test expected to run.
            passed: Whether the test should pass.
            error_msg: The error message, if any.
            trigger: An optional callable that will be executed after mocks are
                set up to trigger the autotest.  If None, then the test is
                expected to start itself.
        '''

        mock_autotest(self.env, name, passed, error_msg)
        self.mocker.ReplayAll()
        if trigger:
            trigger()
        self.assertTrue(self.goofy.run_once())
        self.assertEqual([id],
                         [test.path for test in self.goofy.invocations])
        self._wait()
        state = self.state.get_test_state(id)
        self.assertEqual(TestState.PASSED if passed else TestState.FAILED,
                         state['status'])
        self.assertEqual(1, state['count'])
        self.assertEqual(error_msg, state['error_msg'])


# A simple test list with three tests.
ABC_TEST_LIST = '''
    OperatorTest(id='a', autotest_name='a_A'),
    OperatorTest(id='b', autotest_name='b_B'),
    OperatorTest(id='c', autotest_name='c_C'),
'''


class BasicTest(GoofyTest):
    '''A simple test case that checks that tests are run in the correct
    order.'''
    test_list = ABC_TEST_LIST
    def runTest(self):
        self.check_one_test('a', 'a_A', True, '')
        self.check_one_test('b', 'b_B', False, 'Uh-oh')
        self.check_one_test('c', 'c_C', False, 'Uh-oh')


class ShutdownTest(GoofyTest):
    test_list = '''
        RebootStep(id='shutdown', iterations=3),
        OperatorTest(id='a', autotest_name='a_A')
    '''
    def runTest(self):
        # Expect a reboot request
        self.env.shutdown('reboot').AndReturn(True)
        self.mocker.ReplayAll()
        self.assertTrue(self.goofy.run_once())
        self._wait()

        # That should have enqueued a task that will cause Goofy
        # to shut down.
        self.mocker.ReplayAll()
        self.assertFalse(self.goofy.run_once())
        # There should be a list of tests to run on wake-up.
        self.assertEqual(
            ['a'], self.state.get_shared_data('tests_after_shutdown'))
        self._wait()

        # Kill and restart Goofy to simulate a shutdown.
        # Goofy should call for another shutdown.
        for _ in range(2):
            self.env.shutdown('reboot').AndReturn(True)
            self.mocker.ReplayAll()
            self.goofy.destroy()
            self.goofy = init_goofy(self.env, self.test_list, restart=False)
            self._wait()

        # No more shutdowns - now 'a' should run.
        self.check_one_test('a', 'a_A', True, '')


class NoAutoRunTest(GoofyTest):
    test_list = ABC_TEST_LIST
    options = 'options.auto_run_on_start = False'

    def _runTestB(self):
        # There shouldn't be anything to do at startup, since auto_run_on_start
        # is unset.
        self.mocker.ReplayAll()
        self.goofy.run_once()
        self.assertEqual({}, self.goofy.invocations)
        self._wait()

        # Tell Goofy to run 'b'.
        self.check_one_test(
            'b', 'b_B', True, '',
            trigger=lambda: self.goofy.handle_switch_test(
                Event(Event.Type.SWITCH_TEST, path='b')))

    def runTest(self):
        self._runTestB()
        # No more tests to run now.
        self.mocker.ReplayAll()
        self.goofy.run_once()
        self.assertEqual({}, self.goofy.invocations)


class AutoRunKeypressTest(NoAutoRunTest):
    test_list = ABC_TEST_LIST
    options = '''
        options.auto_run_on_start = False
        options.auto_run_on_keypress = True
    '''

    def runTest(self):
        self._runTestB()
        # Unlike in NoAutoRunTest, C should now be run.
        self.check_one_test('c', 'c_C', True, '')


if __name__ == "__main__":
    factory.init_logging('goofy_unittest')
    goofy._inited_logging = True
    goofy.suppress_chroot_warning = True

    unittest.main()
    # To run a single test (e.g., while developing), use a line like this:
    #
    #   unittest.TextTestRunner().run(AutoRunTest())

