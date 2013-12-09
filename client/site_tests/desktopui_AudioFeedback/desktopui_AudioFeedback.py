# Copyright (c) 2012 The Chromium Authors. All rights reserved.
# Use of this source code is governed by a BSD-style license that can be
# found in the LICENSE file.

import logging
import os
import subprocess

from autotest_lib.client.bin import test, utils
from autotest_lib.client.common_lib import error
from autotest_lib.client.common_lib.cros import chrome
from autotest_lib.client.cros.audio import audio_helper
from autotest_lib.client.cros.audio import cmd_utils
from autotest_lib.client.cros.audio import cras_utils
from autotest_lib.client.cros.audio import sox_utils

TEST_DURATION = 15

PLAYER_READY_TIMEOUT = 45

class desktopui_AudioFeedback(test.test):
    """Verifies if youtube playback can be captured."""
    version = 1

    def play_video(self, tab, video_url):
        """Plays a Youtube video to record audio samples.

           Skipping initial 60 seconds so we can ignore initial silence
           in the video.

           @param tab: the tab to load page for testing.
        """
        tab.Navigate(video_url)
        tab.WaitForDocumentReadyStateToBeComplete()

        utils.poll_for_condition(
            condition=lambda: tab.EvaluateJavaScript('getPlayerStatus()') ==
                    'player ready',
            exception=error.TestError('Failed to load the Youtube player'),
            sleep_interval=1,
            timeout=PLAYER_READY_TIMEOUT)

        tab.ExecuteJavaScript('seekAndPlay()')

    @audio_helper.chrome_rms_test
    def run_once(self, chrome):
        """Entry point of this test."""
        chrome.browser.SetHTTPServerDirectories(self.bindir)

        video_url = chrome.browser.http_server.UrlOf(
                os.path.join(self.bindir, 'youtube.html'))
        logging.info('Playing back youtube media file %s.', video_url)
        noise_file = os.path.join(self.resultsdir, "noise.wav")
        recorded_file = os.path.join(self.resultsdir, "recorded.wav")
        loopback_file = os.path.join(self.resultsdir, "loopback.wav")

        # Record a sample of "silence" to use as a noise profile.
        cras_utils.capture(noise_file, duration=3)

        # Play a video and record the audio output
        self.play_video(chrome.browser.tabs[0], video_url)

        p1 = cmd_utils.popen(cras_utils.capture_cmd(
                recorded_file, duration=TEST_DURATION))
        p2 = cmd_utils.popen(cras_utils.loopback_cmd(
                loopback_file, duration=TEST_DURATION))

        cmd_utils.wait_and_check_returncode(p1, p2)

        # See if we recorded something
        loopback_stats = [audio_helper.get_channel_sox_stat(
                loopback_file, i) for i in (1, 2)]
        logging.info('loopback stats: %s', [str(s) for s in loopback_stats])
        audio_helper.reduce_noise_and_check_rms(recorded_file, noise_file)

        # Keep these files if the test failed
        os.unlink(noise_file)
        os.unlink(recorded_file)
        os.unlink(loopback_file)
