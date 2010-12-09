# Copyright (c) 2010 The Chromium OS Authors. All rights reserved.
# Use of this source code is governed by a BSD-style license that can be
# found in the LICENSE file.

from autotest_lib.client.bin import site_cryptohome
from autotest_lib.client.common_lib import error
from autotest_lib.client.cros import ui_test

class login_CryptohomeUnmounted(ui_test.UITest):
    version = 1


    def run_once(self):
        if not site_cryptohome.is_mounted(allow_fail=False):
            raise error.TestFail('Expected cryptohome to be mounted')

        self.logout()

        # allow the command to fail, so we can handle the error here
        if site_cryptohome.is_mounted(allow_fail=True):
            raise error.TestFail('Expected cryptohome NOT to be mounted')
