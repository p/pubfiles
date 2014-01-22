// backspace goes back in history
user_pref('browser.backspace_action', 0);
// hide tab bar when only one tab is open
user_pref('browser.tabs.autoHide', true);
// fit more tabs on screen simultaneously
user_pref('browser.tabs.tabMinWidth', 30);
// updates are not handled by brower
user_pref('app.update.enabled', false);
user_pref('browser.search.update', false);
user_pref('extensions.update.enabled', false);
user_pref('lightweightThemes.update.enabled', false);
// don't want even more google phoning
user_pref('browser.safebrowsing.enabled', false);
user_pref('browser.safebrowsing.malware.enabled', false);
user_pref('browser.safebrowsing.remoteLookups', false);
// start with blank page?
user_pref('browser.startup.page', 0);
// how many autocompletion results to show
user_pref('browser.urlbar.maxRichResults', 100);
// search history only?
user_pref('browser.urlbar.default.behavior', 1);
// match only at word boundaries
user_pref('browser.urlbar.matchBehavior', 2);
// javascript cannot move/resize windows
user_pref('dom.disable_window_move_resize', true);
// javascsript cannot disable context menus
// this affects google maps
user_pref('dom.event.contextmenu.enabled', false);
// pre-set exclude urls in livehttpheaders
user_pref('extensions.livehttpheaders.excludeRegexp', '.gif$|.jpg$|.ico$|.css$|.js$|.png$|google');
// disable about:config scare warning
user_pref('general.warnOnAboutConfig', false);
// use more memory for caching pages in memory
// http://blog.pluron.com/2008/07/why-you-should.html
// http://kb.mozillazine.org/Browser.cache.memory.capacity
user_pref('browser.cache.memory.enable', true);
user_pref('browser.cache.memory.capacity', 10000);
// cache ssl pages to disk
// http://blog.pluron.com/2008/07/why-you-should.html
user_pref('browser.cache.disk_cache_ssl', true);
// kill animation in gifs
// http://www.glump.net/howto/disable_animation_in_your_web_browser#disable_animation_in_firefox_and_other_mozilla-based_browsers
user_pref('image.animation_mode', 'once');
// Disable blinking text
// http://www.mozilla.org/unix/customizing.html
user_pref("browser.blink_allowed", false);
// ship less data to google when searching,
// specifically entering stuff in url bar that is a word, not a url
user_pref('keyword.URL', 'http://www.google.com/search?ie=UTF-8&oe=UTF-8&q=');
// disable geo location reporting
user_pref('geo.enabled', false);
// http://kb.mozillazine.org/Disabling_yellow_plugin_bar_-_Firefox
user_pref('plugins.hide_infobar_for_missing_plugin', true);
// not documented, and still does not do it
user_pref('plugin.default_plugin_disabled', false);
// stop stupid dns dumbness
user_pref('network.dnsCacheExpiration', 0);
// disable smooth sliding (chrome?)
user_pref('alerts.disableSlidingEffect', true);
// disable smooth scrolling
user_pref('general.smoothScroll', false);
// disable smooth scrolling of tabs
user_pref('toolkit.scrollbox.smoothScroll', false);
// for good measure
user_pref('social.active', false);
user_pref('social.enabled', false);
// Blank page be blank
// https://support.mozilla.org/en-US/questions/926778
user_pref('browser.newtab.url', 'about:blank');
// Disable status bar delay - this is completely retarded
user_pref('browser.overlink-delay', 0);
user_pref('status4evar.status.linkOver.delay.show', 0);
user_pref('status4evar.status.linkOver.delay.hide', 0);
// do not track
user_pref'privacy.donottrackheader.enabled', true);
// reject third-party cookies
user_pref('network.cookie.cookieBehavior', 1);
// load all tabs when restoring session
// https://bugzilla.mozilla.org/show_bug.cgi?id=648683
user_pref('browser.sessionstore.restore_on_demand', false);

// experimental
user_pref('browser.download.manager.showWhenStarting', false);
user_pref('browser.tabs.animate', false);
user_pref('browser.zoom.updateBackgroundTabs', false);
user_pref('browser.fullscreen.animateUp', 0);
user_pref('browser.fullscreen.autohide', false);
user_pref('browser.panorama.animate_zoom', false);
user_pref('browser.preferences.animateFadeIn', false);

// totally cretinous behavior
// firefox 17 doorhanger idiocy is enough to never remember passwords
user_pref('signon.rememberSignons', false);

// firefox health report bs
user_pref('datareporting.healthreport.about.reportUrl', 'http://localhost');
user_pref('datareporting.healthreport.documentServerURI', 'http://localhost');
user_pref('datareporting.healthreport.uploadEnabled', false);
user_pref('datareporting.healthreport.service.enabled', false);
user_pref('datareporting.healthreport.logging.dumpEnabled', false);

user_pref('datareporting.policy.dataSubmissionPolicyAccepted', false);
user_pref('datareporting.policy.dataSubmissionEnabled', false);
