# Copyright 2018 The Chromium Authors. All rights reserved.
# Use of this source code is governed by a BSD-style license that can be
# found in the LICENSE file.

import logging
import os

from autotest_lib.client.bin import utils
from autotest_lib.client.common_lib import error
from autotest_lib.client.cros import chrome_binary_test
from autotest_lib.client.cros.graphics import graphics_utils
from autotest_lib.client.common_lib.cros import chrome
from autotest_lib.client.cros import constants
from autotest_lib.client.cros.multimedia import local_facade_factory

EXTRA_BROWSER_ARGS = ['--enable-experimental-web-platform-features']

class graphics_HwOverlays(graphics_utils.GraphicsTest,
                          chrome_binary_test.ChromeBinaryTest):
    """Runs a given html and measures stuff."""
    version = 1

    # The tests are essentially composed of a preamble and an epilog, in between
    # which we count the amount of overlays. Each of those essentially waits
    # until either a total number of items is drawn, or there's a timeout.
    PREAMBLE_TOTAL_NUMBER_OF_DRAW_PASSES = 5
    PREAMBLE_TIMEOUT_SECONDS = 10
    EPILOG_TOTAL_NUMBER_OF_DRAW_PASSES = 10
    EPILOG_TIMEOUT_SECONDS = 10

    POLLING_INTERVAL_SECONDS = 1

    def initialize(self):
        super(graphics_HwOverlays, self).initialize()

    def cleanup(self):
        super(graphics_HwOverlays, self).cleanup()

    def set_rotation_to_zero(self, cr):
        # Set rotation to 0 (portrait) otherwise tablet platforms might not get
        # overlays.
        display_facade = local_facade_factory.LocalFacadeFactory(
            cr).create_display_facade()
        displays = []
        try:
            displays = display_facade.get_display_info()
        except KeyError as e:
            # Safe to ignore: some machines won't have all DisplayInfo keys.
            pass
        logging.info('Number of displays %i' % len(displays))
        for display in displays:
            logging.info('Setting rotation to 0 of display %s, name %s' %
               (display.display_id, display.name));
            display_facade.set_display_rotation(display.display_id, rotation=0)

    def run_once(self, html_file, data_file_url = None):
        if not graphics_utils.is_drm_atomic_supported():
            logging.info('Skipping test: platform does not support DRM atomic')
            return

        logging.info('Starting test, navigating to %s', html_file)

        with chrome.Chrome(extra_browser_args=EXTRA_BROWSER_ARGS,
                           extension_paths=[constants.DISPLAY_TEST_EXTENSION],
                           autotest_ext=True,
                           init_network_controller=True) as cr:
            self.set_rotation_to_zero(cr)

            cr.browser.platform.SetHTTPServerDirectories(self.bindir)

            tab = cr.browser.tabs[0]
            tab.Navigate(cr.browser.platform.http_server.UrlOf(
                    os.path.join(self.bindir, html_file)))
            tab.WaitForDocumentReadyStateToBeComplete()

            if data_file_url:
                tab.EvaluateJavaScript('load_data_url("%s")' % data_file_url)

            # Draw something; this also triggers JS parsing and execution.
            tab.EvaluateJavaScript('draw_pass()')

            # Wait until a few passes have been drawn, then read the amount of
            # overlays.
            utils.poll_for_condition(
                    lambda: tab.EvaluateJavaScript('get_draw_passes_count()') >
                            self.PREAMBLE_TOTAL_NUMBER_OF_DRAW_PASSES,
                    exception=error.TestFail('JS is not drawing (preamble)'),
                    timeout=self.PREAMBLE_TIMEOUT_SECONDS,
                    sleep_interval=self.POLLING_INTERVAL_SECONDS)

            num_overlays = 0;
            try:
                num_overlays = graphics_utils.get_num_hardware_overlays()
                logging.debug('Found %s overlays', num_overlays)
            except Exception as e:
                logging.error(e)
                raise error.TestFail('Error: %s' % str(e))

            utils.poll_for_condition(
                    lambda: tab.EvaluateJavaScript('get_draw_passes_count()') >
                            self.EPILOG_TOTAL_NUMBER_OF_DRAW_PASSES,
                    exception=error.TestFail('JS is not drawing (epilog)'),
                    timeout=self.EPILOG_TIMEOUT_SECONDS,
                    sleep_interval=self.POLLING_INTERVAL_SECONDS)

            if (num_overlays <= 1):
                raise error.TestFail('%s failed, number of overlays is %d' %
                        (html_file, num_overlays))
