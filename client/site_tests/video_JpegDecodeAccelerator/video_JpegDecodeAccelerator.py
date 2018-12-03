# Copyright 2016 The Chromium Authors. All rights reserved.
# Use of this source code is governed by a BSD-style license that can be
# found in the LICENSE file.

"""A test which verifies the function of hardware JPEG decode accelerator."""

import logging
from autotest_lib.client.cros import chrome_binary_test
from autotest_lib.client.cros.video import device_capability
from autotest_lib.client.cros.video import helper_logger

class video_JpegDecodeAccelerator(chrome_binary_test.ChromeBinaryTest):
    """
    This test is a wrapper of the chrome unittest binary:
    jpeg_decode_accelerator_unittest.

    The jpeg_decode_accelerator_unittest uses the built-in default JPEG image:
    peach_pi-1280x720.jpg during test.  The image is bundled as part of the
    chromeos-chrome package if USE=build_test is set.  ChromeBinaryTest will
    automatically locate the image for us when the test is run.
    """

    version = 1
    binary = 'jpeg_decode_accelerator_unittest'


    @helper_logger.video_log_wrapper
    @chrome_binary_test.nuke_chrome
    def run_once(self, capability):
        """
        Runs jpeg_decode_accelerator_unittest on the device.

        @param capability: Capability required for executing this test.
        @param gtest_filter: test case filter.

        @raises: error.TestFail for jpeg_decode_accelerator_unittest failures.
        """
        device_capability.DeviceCapability().ensure_capability(capability)
        logging.debug('Starting video_JpegDecodeAccelerator')

        cmd_line = helper_logger.chrome_vmodule_flag()
        self.run_chrome_test_binary(self.binary, cmd_line)
