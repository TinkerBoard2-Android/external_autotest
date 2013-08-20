# Copyright (c) 2013 The Chromium Authors. All rights reserved.
# Use of this source code is governed by a BSD-style license that can be
# found in the LICENSE file.

import os
import trendnet_ap_configurator


class Trendnet692grAPConfigurator(trendnet_ap_configurator.
                                  TrendnetAPConfigurator):
    """Derived class to control the Trendnet TEW-692GR."""


    def _alert_handler(self, alert):
        """Checks for any modal dialogs which popup to alert the user and
        either raises a RuntimeError or ignores the alert.

        @param alert: The modal dialog's contents.
        """
        text = alert.text
        if 'Please input 5 or 13 characters of WEP key1' in text:
            alert.accept()
            raise RuntimeError(text)


    def get_number_of_pages(self):
        return 2


    def save_page(self, page_number):
        xpath = ('//input[@class="button_submit" and @value="Apply"]')
        element = self.wait_for_object_by_xpath(xpath)
        if element and element.is_displayed():
            self.click_button_by_xpath(xpath, alert_handler=self._alert_handler)
            # Reboot the device.
            reboot_button = '//input[@value="Reboot the Device"]'
            if self.object_by_xpath_exist(reboot_button):
                self.click_button_by_xpath(reboot_button)
                self.wait_for_progress_bar()
        else:
            pass


    def get_supported_bands(self):
        return [{'band': self.band_2ghz, 'channels': range(1, 12)},
                {'band': self.band_5ghz, 'channels':[36, 40, 44, 48, 149, 153,
                                                     157, 161, 165]}]


    def get_supported_modes(self):
        return [{'band': self.band_2ghz,
                 'modes': [self.mode_n,
                           self.mode_b | self.mode_g,
                           self.mode_b | self.mode_g | self.mode_n]},
                {'band': self.band_5ghz,
                 'modes': [self.mode_a | self.mode_n, self.mode_a]}]


    def navigate_to_page(self, page_number):
        # All settings are on the same page, so we always open the config page
        if self.current_band == self.band_2ghz:
            if page_number == 1:
                page_url = os.path.join(self.admin_interface_url ,
                                        'wireless/basic.asp')
            elif page_number == 2:
                page_url = os.path.join(self.admin_interface_url ,
                                        'wireless/security.asp')
            else:
                raise RuntimeError('Invalid page number passed. Number of pages'
                                   '%d, page value sent was %d' %
                                   (self.get_number_of_pages(), page_number))
        elif self.current_band == self.band_5ghz:
            if page_number == 1:
                page_url = os.path.join(self.admin_interface_url ,
                                        'wireless2/basic.asp')
            elif page_number == 2:
                page_url = os.path.join(self.admin_interface_url ,
                                        'wireless2/security.asp')
            else:
                raise RuntimeError('Invalid page number passed. Number of pages'
                                   '%d, page value sent was %d' %
                                    (self.get_number_of_pages(), page_number))
        else:
            raise RuntimeError('Incorrect band band = %s' % self.current_band)
        self.get_url(page_url, page_title='TEW-692GR')


    def is_update_interval_supported(self):
        """
        Returns True if setting the PSK refresh interval is supported.

        @return True is supported; False otherwise
        """
        return True


    def _set_mode(self, mode, band=None):
        # Different bands are not supported so we ignore.
        # Create the mode to popup item mapping
        mode_mapping = {self.mode_b | self.mode_g | self.mode_n:
                        '2.4GHz 802.11 b/g/n mixed mode',
                        self.mode_n: '2.4GHz 802.11 n only',
                        self.mode_b | self.mode_g:
                        '2.4GHz 802.11 b/g mixed mode',
                        self.mode_a: '5GHz 802.11 a only',
                        self.mode_a | self.mode_n: '5GHz 802.11 a/n mixed mode'}
        mode_name = ''
        if mode in mode_mapping.keys():
            mode_name = mode_mapping[mode]
        else:
            raise RuntimeError('The mode selected %d is not supported by router'
                               ' %s.', hex(mode), self.get_router_name())
        self.select_item_from_popup_by_id(mode_name, 'wirelessmode',
                                          wait_for_xpath='id("wds_mode")')


    def set_band(self, band):
        if band == self.band_5ghz:
            self.current_band = self.band_5ghz
        elif band == self.band_2ghz:
            self.current_band = self.band_2ghz
        else:
            raise RuntimeError('Invalid band sent %s' % band)


    def set_radio(self, enabled=True):
        # TODO: Implement the RADIO button for this AP
        return None


    def _set_channel(self, channel):
        position = self._get_channel_popup_position(channel)
        channel_choices_2GHZ = ['2412MHz (Channel 1)', '2417MHz (Channel 2)',
                                '2422MHz (Channel 3)', '2427MHz (Channel 4)',
                                '2432MHz (Channel 5)', '2437MHz (Channel 6)',
                                '2442MHz (Channel 7)', '2447MHz (Channel 8)',
                                '2452MHz (Channel 9)', '2457MHz (Channel 10)',
                                '2462MHz (Channel 11)']
        channel_choices_5GHZ = ['AutoSelect', '5180MHz (Channel 36)',
                                '5200MHz (Channel 40)', '5220MHz (Channel 44)',
                                '5220MHz (Channel 44)', '5240MHz (Channel 48)',
                                '5745MHz (Channel 149)','5765MHz (Channel 153)',
                                '5785MHz (Channel 157)','5805MHz (Channel 161)',
                                '5825MHz (Channel 165)']
        if self.current_band == self.band_2ghz:
            self.select_item_from_popup_by_id(channel_choices_2GHZ[position],
                                              'sz11gChannel')
        else:
            self.select_item_from_popup_by_id(channel_choices_5GHZ[position],
                                              'sz11aChannel')


    def set_security_disabled(self):
        self.add_item_to_command_list(self._set_security_disabled, (), 2, 1000)


    def _set_security_disabled(self):
        self.wait_for_object_by_id('security_mode')
        self.select_item_from_popup_by_id('Disable', 'security_mode')


    def set_security_wep(self, key_value, authentication):
        self.add_item_to_command_list(self._set_security_wep,
                                      (key_value, authentication), 2, 900)


    def _set_security_wep(self, key_value, authentication):
        self.wait_for_object_by_id('security_mode')
        self.select_item_from_popup_by_id('WEP-OPEN', 'security_mode')
        self.select_item_from_popup_by_id('ASCII', 'WEP1Select')
        self.set_content_of_text_field_by_id(key_value, 'WEP1',
                                             abort_check=True)
