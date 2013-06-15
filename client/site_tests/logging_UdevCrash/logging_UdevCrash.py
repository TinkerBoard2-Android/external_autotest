# Copyright (c) 2013 The Chromium OS Authors. All rights reserved.
# Use of this source code is governed by a BSD-style license that can be
# found in the LICENSE file.

import gzip, os, utils
from autotest_lib.client.bin import utils
from autotest_lib.client.common_lib import error
from autotest_lib.client.cros import crash_test


class logging_UdevCrash(crash_test.CrashTest):
    version = 1


    def CheckAtmelCrashes(self):
        """Check proper Atmel trackpad crash reports are created."""
        if not os.path.exists(self._SYSTEM_CRASH_DIR):
              return False

        for filename in os.listdir(self._SYSTEM_CRASH_DIR):
            if not filename.startswith('change__i2c_atmel_mxt_ts'):
                raise error.TestFail('Crash report %s has wrong name' %
                                     filename)
            if filename.endswith('meta'):
                continue

            filepath = os.path.join(self._SYSTEM_CRASH_DIR, filename)
            if filename.endswith('.log.gz'):
                f = gzip.open(filepath, 'r')
            elif filename.endswith('.log'):
                f = open(filepath)
            else:
                raise error.TestFail('Crash report %s has wrong extension' %
                                     filename)

            for line in f:
                if 'END-OF-LOG' in line:
                    return True
                if not 'atmel_mxt_ts' in line:
                    raise error.TestFail('Crash report contains invalid '
                                         'content %s' % line)
        return False

    def _test_udev_report_atmel(self):
        """Test that atmel trackpad failure can trigger udev crash report."""
        self._set_consent(True)

        # Use udevadm to trigger a fake udev event representing atmel driver
        # failure. The uevent match rule in 99-crash-reporter.rules is
        # ACTION=="change", SUBSYSTEM=="i2c", DRIVER=="atmel_mxt_ts",
        # ENV{ERROR}=="1" RUN+="/sbin/crash_reporter
        # --udev=SUBSYSTEM=i2c-atmel_mxt_ts:ACTION=change"
        utils.system('/sbin/udevadm control --property=ERROR=1',
                     ignore_status=True)
        utils.system('/sbin/udevadm trigger '
                     '--action=change '
                     '--subsystem-match=i2c '
                     '--attr-match=driver=atmel_mxt_ts',
                     ignore_status=True)
        utils.system('/sbin/udevadm control --property=ERROR=0',
                     ignore_status=True)

        utils.poll_for_condition(
            self.CheckAtmelCrashes,
            timeout=10,
            exception=error.TestFail('No valid Atmel crash reports'))

    def run_once(self):
        self._automatic_consent_saving = True
        self.run_crash_tests(['udev_report_atmel'], True)
