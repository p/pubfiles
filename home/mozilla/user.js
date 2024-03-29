// Disabling websites messing with pasting passwords:
// https://www.cyberciti.biz/linux-news/google-chrome-extension-to-removes-password-paste-blocking-on-website/

// Pale moon pref list:
// https://forum.palemoon.org/viewtopic.php?f=24&t=3357&p=19126

// Bogus pref detection:
// 1. Change a pref in about:config.
// 2. Quit browser.
// 3. Look for Invalidprefs.js file in profile directory.
// Or, run jslint on this file before using it.

// Uncomment for jslint:
// var user_pref = function () { 1; };

user_pref('devtools.selfxss.count', 10000);

// backspace goes back in history
user_pref('browser.backspace_action', 0);
// hide tab bar when only one tab is open
user_pref('browser.tabs.autoHide', true);
// fit more tabs on screen simultaneously
user_pref('browser.tabs.tabMinWidth', 30);
// updates are not handled by brower
user_pref('app.update.auto', false);
user_pref('app.update.enabled', false);
user_pref('app.update.doorhanger', false);
user_pref('browser.search.update', false);
user_pref('extensions.update.enabled', false);
user_pref('lightweightThemes.update.enabled', false);
user_pref('app.update.checkInstallTime', false);
// don't want even more google phoning
user_pref('browser.safebrowsing.enabled', false);
user_pref('browser.safebrowsing.malware.enabled', false);
user_pref('browser.safebrowsing.remoteLookups', false);
// start with blank page?
user_pref('browser.startup.page', 0);
// how many autocompletion results to show
user_pref('browser.urlbar.maxRichResults', 20);
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
user_pref('browser.aboutConfig.showWarning', false);
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
user_pref('plugins.hide_infobar_for_blocked_plugin', true);
user_pref('plugins.hide_infobar_for_outdated_plugin', true);
// not documented, and still does not do it
user_pref('plugin.default_plugin_disabled', false);
// stop stupid dns dumbness
user_pref('network.dnsCacheExpiration', 0);
// surely default of 400 is too small?
user_pref('network.dnsCacheEntries', 10000);
// disable smooth sliding (chrome?)
user_pref('alerts.disableSlidingEffect', true);
// disable smooth scrolling
user_pref('general.smoothScroll', false);
// disable smooth scrolling of tabs
user_pref('toolkit.scrollbox.smoothScroll', false);
user_pref('layout.css.scroll-behavior.enabled', false);
user_pref('layout.css.scroll-behavior.property-enabled', false);
// for good measure
user_pref('social.active', false);
user_pref('social.enabled', false);
// Blank page be blank
// https://support.mozilla.org/en-US/questions/926778
user_pref('browser.newtab.url', 'about:blank');
// same thing in newer foxes
user_pref('browser.newtabpage.enabled', false);
// Disable status bar delay - this is completely retarded
// a delay of 0 is not working?
// also: https://bugzilla.mozilla.org/show_bug.cgi?id=632365
user_pref('browser.overlink-delay', 1);
user_pref('status4evar.status.linkOver.delay.show', 0);
user_pref('status4evar.status.linkOver.delay.hide', 0);
user_pref('toolkit.cosmeticAnimations.enabled', false);
user_pref('browser.stopReloadAnimation.enabled', false);
user_pref('browser.suppress_first_window_animation', true);
// don't know what this does but probably don't want it
user_pref('status4evar.download.notify.animate', false);
// and these too
user_pref('layout.css.prefixes.animations', false);
user_pref('dom.animations-api.element-animate.enabled', false);
user_pref('browser.fullscreen.animateUp', 0);
user_pref('browser.fullscreen.animate', false);
user_pref('browser.panorama.animate_zoom', false);
user_pref('browser.preferences.animateFadeIn', false);
// what does this do that is useful
user_pref('browser.download.manager.scanWhenDone', false);
// is this the obnoxious download button explosion?
user_pref('browser.download.manager.showAlertOnComplete', false);
// do not track
user_pref('privacy.donottrackheader.enabled', true);
// reject third-party cookies
user_pref('network.cookie.cookieBehavior', 1);
// load all tabs when restoring session
// https://bugzilla.mozilla.org/show_bug.cgi?id=648683
user_pref('browser.sessionstore.restore_on_demand', false);

// experimental
user_pref('browser.download.manager.showWhenStarting', false);
user_pref('browser.tabs.animate', false);
user_pref('browser.download.animateNotifications', false);
user_pref('browser.zoom.updateBackgroundTabs', false);
user_pref('browser.fullscreen.autohide', false);
user_pref('browser.preferences.animateFadeIn', false);
// https://bugzilla.mozilla.org/show_bug.cgi?id=649671
user_pref('toolkit.scrollbox.smoothScroll', false);

user_pref('browser.xul.error_pages.enabled', false);
user_pref('browser.xul.error_pages.expert_bad_cert', true);

// totally cretinous behavior
// firefox 17 doorhanger idiocy is enough to never remember passwords
// give this another go?
//user_pref('signon.rememberSignons', false);

// firefox health report bs
user_pref('datareporting.healthreport.about.reportUrl', 'http://localhost');
user_pref('datareporting.healthreport.documentServerURI', 'http://localhost');
user_pref('datareporting.healthreport.uploadEnabled', false);
user_pref('datareporting.healthreport.service.enabled', false);
user_pref('datareporting.healthreport.logging.dumpEnabled', false);

user_pref('datareporting.policy.dataSubmissionPolicyAccepted', false);
user_pref('datareporting.policy.dataSubmissionEnabled', false);

// https://www.agwa.name/blog/post/verisigns_broken_name_servers_slow_down_https_for_google_and_others
user_pref('security.OCSP.enabled', 0);

// stop html5 videos from automatically playing
// https://support.mozilla.org/en-US/questions/961940
user_pref('plugins.click_to_play', true);

// Disable: On GTK, we now default to showing the menubar only when alt is pressed:
user_pref("ui.key.menuAccessKeyFocuses", false);

// useless
user_pref("browser.uitour.enabled", false);

// disable reader popup
// https://support.mozilla.org/en-US/questions/1065151
user_pref('reader.parse-on-load.enabled', false);

// disable url bar search suggestions prompt
user_pref('browser.urlbar.userMadeSearchSuggestionsChoice', true);
user_pref('browser.search.suggest.enabled', false);
// for good measure
user_pref('browser.urlbar.suggest.searches', false);
// more searrch suggestions: https://support.mozilla.org/en-US/questions/1099987
user_pref('browser.urlbar.unifiedcomplete', false);
// this seems to stop the browser offering to search when I edit the URL
// in the address bar
user_pref('browser.urlbar.oneOffSearches', false);
user_pref('browser.urlbar.timesBeforeHidingSuggestionsHint', 0);

user_pref('browser.search.defaultenginename', 'DuckDuckGo');

// do not fill top search result into url bar
// https://support.mozilla.org/en-US/questions/976885
// this seems to reduce usability overall because the list is shown with
// unacceptable lag for interactive use
//user_pref('browser.urlbar.autoFill', false);

// http://www.palemoon.org/faq.shtml#Preference:_I_prefer_the_old_Ctrl-Tab
user_pref('browser.ctrlTab.previews', false);

user_pref('extensions.pocket.enabled', false);

// disable switch to tab in pale moon
// https://forum.palemoon.org/viewtopic.php?t=10186
// all values:
// https://forum.palemoon.org/viewtopic.php?f=3&t=8757&p=58089&hilit=Browser.urlbar.default.behavior#p58089
user_pref('browser.urlbar.default.behavior', 128);

// https://superuser.com/questions/1539855/how-can-i-disable-address-bar-animation-in-mozilla-firefox-75

// https://support.mozilla.org/en-US/questions/1157121
user_pref("network.captive-portal-service.enabled", false);

// https://support.mozilla.org/en-US/questions/1285537
user_pref("media.videocontrols.picture-in-picture.video-toggle.enabled", false);

// Do not check whether browser is the default one because I have many browsers.
user_pref('browser.shell.checkDefaultBrowser', false);

user_pref('browser.urlbar.delay', 1);

user_pref('browser.sessionstore.restore_tabs_lazily', false);

// disable dns over https
// https://wiki.mozilla.org/Trusted_Recursive_Resolver
user_pref('network.trr.mode', 5);
// This is set to a cloudflare URL by default
user_pref('network.trr.default_provider_uri', '');
// oblivious version - should be fine to have on if DOH is on
user_pref('network.trr.use_ohttp', false);
// There are many other network.trr prefs, investigate one day

// https://www.maketecheasier.com/disable-video-autoplay-firefox-chrome/
user_pref('media.autoplay.enabled', false);

// assuming this would disable sites prompting to enable notifications
user_pref('dom.webnotifications.enabled', false);
// for good measure
user_pref('dom.webnotifications.serviceworker.enabled', false);
user_pref('notification.feature.enabled', false);

// https://bugzilla.mozilla.org/show_bug.cgi?id=959893
// https://www.purevpn.com/internet-privacy/disable-webrtc
user_pref('media.peerconnection.enabled', false);

user_pref("media.peerconnection.enabled", false); // VPN cannot bypassed anymore (https://www.reddit.com/r/VPN/comments/2tva1o/websites_can_now_use_webrtc_to_determine_your/)
user_pref("media.peerconnection.turn.disable", true); // makes sure WebRTC is really disabled
user_pref("media.peerconnection.use_document_iceservers", false); // makes sure WebRTC is really disabled
user_pref("media.peerconnection.video.enabled", false); // makes sure WebRTC is really disabled
user_pref("media.peerconnection.identity.timeout", 1); // makes sure WebRTC is really disabled

user_pref('pdfjs.disabled', true);

// https://medium.com/volosoft/how-to-disable-firefox-warning-potential-security-risk-ahead-f081fbf81a4f
user_pref('security.insecure_field_warning.contextual.enabled', false);
user_pref('security.certerrors.permanentOverride', false);
user_pref('network.stricttransportsecurity.preloadlist', false);
user_pref('security.enterprise_roots.enabled', true);

// Use DNS instead of search for single words
user_pref('browser.fixup.dns_first_for_single_words', true);

// Disable release notes in waterfox on first run of new profile
user_pref('startup.homepage_welcome_url', 'about:blank');

// Enable userChrome.css & userContent.css - https://github.com/MrOtherGuy/firefox-csshacks
user_pref('toolkit.legacyUserProfileCustomizations.stylesheets', 'true');

// TODO - investigate:
user_pref('dom.workers.enabled', false);
user_pref('dom.animations-api.core.enabled', false);
