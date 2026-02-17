                                                              ▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄
                                                            ▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄
                                                           ▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄
                                                          ▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄
               ▄▄▄▄▄▄▄    ▄▄▄      ▄▄▄    ▄ ▄▄   ▄▄▄      ▄▄▄▄▄▀▀▀▀▀▀▀▀▀▀▀▄▄▄▄▀▀▄▄▄▄▄
               ▀▀▀▀▀▄▄▄ ▄▄▀▀▀▄▄  ▄▄▀▀▀▄▄  ▄▄▀▀▄▄▄▀▀▀▄▄    ▄▄▄▄▄            ▄▀   ▄▄▄▄▄
                  ▄▄▄  ▄▀     ▄▄▄▄     ▀▄ ▄    ▄▄   ▄▄    ▄▄▄▄▄            ▄    ▄▄▄▄▄
                ▄▄▄▀   ▄▄    ▄▄▀▀▄▄    ▄▄ ▄    ▄▄   ▄▄    ▄▄▄▄▄            ▄    ▄▄▄▄▄
               ▄▄▄▄▄▄▄▄▄▀▄▄▄▄▀▀  ▀▀▄▄▄▄▀  ▄    ▄▄   ▄▄    ▄▄▄▄▄▄           ▄▄▄  ▄▄▄▄▄
                                                          ▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄
                  Available Configuration Options         ▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄
                                                           ▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄
                                                            ▀▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▀
                                                               ▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀
              
### Zoom Available Configuration Options

Zoom on Linux is pretty terrible. There is a configuration file at `~/.config/zoomus.conf`, but it's contents are undocumented. There is a page for mass deploying pre-configured Zoom on Mac, which I've converted to .md format below.

| Key | Default State & Value | Value Type | Description | Category |
| --- | --- | --- | --- | --- |
| <sub>Account, your account ID</sub> | <sub>Disabled, (empty)</sub> | <sub>String</sub> | <sub>Restrict the client to only join meetings hosted by the specified account IDs. (B)</sub> | <sub>Authentication</sub> |
| <sub>AlwaysCheckLatestVersion</sub> | <sub>Disabled, 0</sub> | <sub>Boolean</sub> | <sub>Allow the desktop client to check for updates and, if user’s version is lower than the latest version released by Zoom, prompt the user to install the update. This option requires the AutoUpdate option to be enabled.</sub> | <sub>Install and Update</sub> |
| <sub>AlwaysShowVideoPreviewDialog</sub> | <sub>Enabled, 1</sub> | <sub>Boolean</sub> | <sub>Always show the video preview when joining a meeting.</sub> | <sub>Video</sub> |
| <sub>AudioAutoAdjust</sub> | <sub>Enabled, 1</sub> | <sub>Boolean</sub> | <sub>Enable Automatically adjust microphone volume audio setting.</sub> | <sub>Audio</sub> |
| <sub>BandwidthLimitDown</sub> | <sub>Disabled, (empty)</sub> | <sub>String (Kbps)</sub> | <sub>Set maximum receiving bandwidth for the desktop client.<br>Note: If bandwidth is restricted through web settings, the web restrictions override restrictions set in the client.</sub> | <sub>Network</sub> |
| <sub>BandwidthLimitUp</sub> | <sub>Disabled, (empty)</sub> | <sub>String (Kbps)</sub> | <sub>Set maximum sending bandwidth for the desktop client. <br>Note: If bandwidth is restricted through web settings, the web restrictions override restrictions set in the client.</sub> | <sub>Network</sub> |
| <sub>BlockUntrustedSSLCert</sub> | <sub>Enabled, 1</sub> | <sub>Boolean</sub> | <sub>Block connections to untrusted SSL certificates.</sub> | <sub>Network</sub> |
| <sub>ConfirmWhenLeave</sub> | <sub>Enabled, 1</sub> | <sub>Boolean</sub> | <sub>Confirm before leaving a meeting.</sub> | <sub>General meeting and client options</sub> |
| <sub>DefaultUsePortraitView</sub> | <sub>Disabled, 0</sub> | <sub>Boolean</sub> | <sub>Default to Portrait Mode upon opening Zoom.</sub> | <sub>General meeting and client options</sub> |
| <sub>DisableAudioOverProxy</sub> | <sub>Disabled, 0</sub> | <sub>Boolean</sub> | <sub>Prevent audio traffic over proxies.</sub> | <sub>Network</sub> |
| <sub>DisableAutoLaunchSSO</sub> | <sub>Disabled, 0</sub> | <sub>Boolean</sub> | <sub>Prevent Zoom from automatically launching the previously used SSO URL. This is useful for users with multiple accounts, each having their own SSO URL.</sub> | <sub>Authentication</sub> |
| <sub>DisableBroadcastBOMessage</sub> | <sub>Disabled, 0</sub> | <sub>Boolean</sub> | <sub>Disable the ability for the host to broadcast a message to all open breakout rooms.</sub> | <sub>General meeting and client options</sub> |
| <sub>DisableCertPin</sub> | <sub>Disabled, 0</sub> | <sub>Boolean</sub> | <sub>Disable Certificate Pinning.</sub> | <sub>Network</sub> |
| <sub>DisableClosedCaptioning</sub> | <sub>Disabled, 0</sub> | <sub>Boolean</sub> | <sub>Disable the use of all closed captioning.</sub> | <sub>General meeting and client options</sub> |
| <sub>DisableComputerAudio</sub> | <sub>Disabled, 0</sub> | <sub>Boolean</sub> | <sub>Disable and remove the Computer Audio from the meeting audio options.</sub> | <sub>Audio</sub> |
| <sub>DisableDaemonInstall</sub> | <sub>Disabled, 0</sub> | <sub>Boolean</sub> | <sub>Control if the desktop client can upgrade to the 64-bit version upon update, if the 32-bit version is installed on a 64-bit system.</sub> | <sub>Install and Update</sub> |
| <sub>DisableDesktopShare</sub> | <sub>Disabled, 0</sub> | <sub>Boolean</sub> | <sub>Disable the option to share your desktop when screen sharing.</sub> | <sub>Screen sharing</sub> |
| <sub>DisableDirectConnection2Web</sub> | <sub>Disabled, 0</sub> | <sub>Boolean</sub> | <sub>Disable all direct connections to Zoom web service.</sub> | <sub>Network</sub> |
| <sub>DisableDirectShare</sub> | <sub>Disabled, 0</sub> | <sub>Boolean</sub> | <sub>Disable direct share with Zoom Rooms option.</sub> | <sub>Zoom Room and Room System calling</sub> |
| <sub>DisableKeepSignedInWithFacebook</sub> | <sub>Disabled, 0</sub> | <sub>Boolean</sub> | <sub>Require fresh Facebook login upon client start.</sub> | <sub>Authentication</sub> |
| <sub>DisableKeepSignedInWithGoogle</sub> | <sub>Disabled, 0</sub> | <sub>Boolean</sub> | <sub>Require fresh Google login upon client start.</sub> | <sub>Authentication</sub> |
| <sub>DisableKeepSignedInWithSSO</sub> | <sub>Disabled, 0</sub> | <sub>Boolean</sub> | <sub>Require fresh SSO login upon client start.</sub> | <sub>Authentication</sub> |
| <sub>DisableLinkPreviewInChat</sub> | <sub>Disabled, 0</sub> | <sub>Boolean</sub> | <sub>Disable link previews.</sub> | <sub>Zoom Chat</sub> |
| <sub>DisableLoginWithEmail</sub> | <sub>Disabled, 0</sub> | <sub>Boolean</sub> | <sub>Remove Email login option.</sub> | <sub>Authentication</sub> |
| <sub>DisableManualClosedCaptioning</sub> | <sub>Disabled, 0</sub> | <sub>Boolean</sub> | <sub>Disable the use of manual, user-entered captioning.</sub> | <sub>General meeting and client options</sub> |
| <sub>DisableMeeting3rdPartyFileStorage</sub> | <sub>Disabled, 0</sub> | <sub>Boolean</sub> | <sub>Disable in-meeting 3rd party file transfer.</sub> | <sub>In-meeting Chat</sub> |
| <sub>DisableMeetingReactions</sub> | <sub>Disabled, 0</sub> | <sub>Boolean</sub> | <sub>Disable the use of Meeting reactions.</sub> | <sub>General meeting and client options</sub> |
| <sub>DisableNonVerbalFeedback</sub> | <sub>Disabled, 0</sub> | <sub>Boolean</sub> | <sub>Disable the use of Non-verbal feedback.</sub> | <sub>General meeting and client options</sub> |
| <sub>DisableQnA</sub> | <sub>Disabled, 0</sub> | <sub>Boolean</sub> | <sub>Disable the use of Q&A in webinars.</sub> | <sub>General meeting and client options</sub> |
| <sub>DisableRemoteControl</sub> | <sub>Disabled, 0</sub> | <sub>Boolean</sub> | <sub>Disable Remote Control feature.</sub> | <sub>Screen sharing</sub> |
| <sub>DisableRemoteSupport</sub> | <sub>Enabled, 1</sub> | <sub>Boolean</sub> | <sub>Disable Remote Support feature.</sub> | <sub>Screen sharing</sub> |
| <sub>DisableScreenShare</sub> | <sub>Disabled, 0</sub> | <sub>Boolean</sub> | <sub>Disable the ability to share your screen in meetings and webinars.<br>Note: This does not disable incoming screen sharing from other participants.</sub> | <sub>Screen sharing</sub> |
| <sub>DisableSharingOverProxy</sub> | <sub>Disabled, 0</sub> | <sub>Boolean</sub> | <sub>Prevent screen sharing traffic over proxies.</sub> | <sub>Network</sub> |
| <sub>DisableSlideControl</sub> | <sub>Disabled, 0</sub> | <sub>Boolean</sub> | <sub>Disable Slide Control feature.</sub> | <sub>Screen sharing</sub> |
| <sub>DisableVideoFilters</sub> | <sub>Disabled, 0</sub> | <sub>Boolean</sub> | <sub>Disable Video filters feature.</sub> | <sub>Background and Filters</sub> |
| <sub>DisableVideoOverProxy</sub> | <sub>Disabled, 0</sub> | <sub>Boolean</sub> | <sub>Prevent video traffic over proxies.</sub> | <sub>Network</sub> |
| <sub>DisableVirtualBkgnd</sub> | <sub>Disabled, 0</sub> | <sub>Boolean</sub> | <sub>Disable Virtual Background feature.</sub> | <sub>Background and Filters</sub> |
| <sub>DisableWebinarReactions</sub> | <sub>Disabled, 0</sub> | <sub>Boolean</sub> | <sub>Disable the use of Webinar Reactions.</sub> | <sub>General meeting and client options</sub> |
| <sub>DisableWhiteboard</sub> | <sub>Disabled, 0</sub> | <sub>Boolean</sub> | <sub>Disable Whiteboard feature.</sub> | <sub>Screen sharing</sub> |
| <sub>DisableZoomApps</sub> | <sub>Disabled, 0</sub> | <sub>Boolean</sub> | <sub>Hide the Zoom Apps button.</sub> | <sub>Zoom Apps</sub> |
| <sub>DisableZoomAppsGuestAccess</sub> | <sub>Disabled, 0</sub> | <sub>Boolean</sub> | <sub>Control the ability for users to utilize a Zoom App in Guest mode.</sub> | <sub>Zoom Apps</sub> |
| <sub>EmbedDeviceTag</sub> | <sub>Disabled, (empty)</sub> | <sub>String</sub> | <sub>Embed a specified device tag string for all HTTP requests from Zoom client application. This string will be appended to the head of the regular HTTP requests.</sub> | <sub>Miscellaneous</sub> |
| <sub>EmbedUserAgentString</sub> | <sub>Disabled, (empty)</sub> | <sub>String</sub> | <sub>Embed a specified user agent string for all HTTP requests from Zoom client.</sub> | <sub>Miscellaneous</sub> |
| <sub>Enable49Video</sub> | <sub>Disabled, 0</sub> | <sub>Boolean</sub> | <sub>Set max number of participants displayed in Gallery View to 49 participants per screen.</sub> | <sub>Video</sub> |
| <sub>EnableAlipayLogin</sub> | <sub>Disabled, 0</sub> | <sub>Boolean</sub> | <sub>Enables login with Alipay authentication. (A)</sub> | <sub>Authentication</sub> |
| <sub>EnableAppleLogin</sub> | <sub>Enabled, 1</sub> | <sub>Boolean</sub> | <sub>Allow access to Apple login option.</sub> | <sub>Authentication</sub> |
| <sub>EnableAutoLightAdaption</sub> | <sub>Auto, 1</sub> | <sub>Boolean</sub> | <sub>Set mode of adjusting low-light video feature. This is dependent on the EnableLightAdaption option.<br>1 - Auto<br>0 - Manual</sub> | <sub>Video</sub> |
| <sub>EnableAutoReverseVirtualBkgnd</sub> | <sub>Disabled, 0</sub> | <sub>Boolean</sub> | <sub>Require post-meeting virtual background auto-reversal.</sub> | <sub>Background and Filters</sub> |
| <sub>EnableCloudSwitch</sub> | <sub>Disabled, 0</sub> | <sub>Boolean</sub> | <sub>Enable the option to switch between Zoom commercial (default) and Zoom for Gov.</sub> | <sub>Authentication</sub> |
| <sub>EnableDoNotDisturbInSharing</sub> | <sub>Enabled, 1</sub> | <sub>Boolean</sub> | <sub>Silence system notifications when sharing desktop.</sub> | <sub>Screen sharing</sub> |
| <sub>EnableEmbedBrowserForSSO</sub> | <sub>Disabled, 0</sub> | <sub>Boolean</sub> | <sub>Use embedded browser in the client for SSO.</sub> | <sub>Authentication</sub> |
| <sub>EnableFaceBeauty</sub> | <sub>Disabled, 0</sub> | <sub>Boolean</sub> | <sub>Enable Touch up my appearance.</sub> | <sub>Video</sub> |
| <sub>EnableHardwareOptimizeVideoSharing</sub> | <sub>Enabled, 1</sub> | <sub>Boolean</sub> | <sub>Use hardware acceleration to optimize video sharing.</sub> | <sub>Screen sharing</sub> |
| <sub>EnableHIDControl</sub> | <sub>Enabled, 1</sub> | <sub>Boolean</sub> | <sub>Enables HID control of USB devices by the Zoom client.</sub> | <sub>Audio</sub> |
| <sub>EnableIndependentDataPort</sub> | <sub>Disabled, 0</sub> | <sub>Boolean</sub> | <sub>If enabled, the client will use the following ports for media transmission:<br>Audio: 8803<br>Screen share: 8802<br>Video: 8801</sub> | <sub>Network</sub> |
| <sub>EnableLaunchApp4IncomingCalls</sub> | <sub>Disabled, 0</sub> | <sub>Boolean</sub> | <sub>Control the Launch an external app or a URL for incoming calls option in the client.<br>This must be used in coordination with SetCommand4IncomingCalls, so that the URL can be configured as well.</sub> | <sub>Zoom Phone</sub> |
| <sub>EnableLightAdaption</sub> | <sub>Disabled, 0</sub> | <sub>Boolean</sub> | <sub>Enable Adjust for low-light video setting.</sub> | <sub>Video</sub> |
| <sub>EnableMirrorEffect</sub> | <sub>Enabled, 1</sub> | <sub>Boolean</sub> | <sub>Enable mirroring of your video. Mirror effect only affects your view of your video.</sub> | <sub>Video</sub> |
| <sub>EnablePhoneLogin</sub> | <sub>Disabled, 0</sub> | <sub>Boolean</sub> | <sub>Enables login with phone authentication. (A)</sub> | <sub>Authentication</sub> |
| <sub>EnableRemindMeetingTime</sub> | <sub>Disabled, 0</sub> | <sub>Boolean</sub> | <sub>Display reminder notifications for upcoming meetings.</sub> | <sub>General meeting and client options</sub> |
| <sub>EnableShareAudio</sub> | <sub>Enabled, 1</sub> | <sub>Boolean</sub> | <sub>Enable the Share computer audio option when sharing.</sub> | <sub>Screen sharing</sub> |
| <sub>EnableShareClipboardWhenRemoteControl</sub> | <sub>Disabled, 0</sub> | <sub>Boolean</sub> | <sub>Allow clipboard access during remote control.</sub> | <sub>Screen sharing</sub> |
| <sub>EnableShareVideo</sub> | <sub>Enabled, 1</sub> | <sub>Boolean</sub> | <sub>Enable the Optimize for video clip option when sharing.</sub> | <sub>Screen sharing</sub> |
| <sub>EnableSilentAutoUpdate</sub> | <sub>Enabled, 1</sub> | <sub>Boolean</sub> | <sub>Allow the desktop client to silently check for updates and, if user’s version is lower than the stable version set by Zoom, install upon launching the client. This option requires the AutoUpdate option to be enabled.</sub> | <sub>Install and Update</sub> |
| <sub>EnableSpotlightSelf</sub> | <sub>Disabled, 0</sub> | <sub>Boolean</sub> | <sub>Show self as the active speaker when speaking.</sub> | <sub>Video</sub> |
| <sub>EnableStartMeetingWithRoomSystem</sub> | <sub>Disabled, 0</sub> | <sub>Boolean</sub> | <sub>Display the Call Room System button on the home screen of the desktop client.</sub> | <sub>Zoom Room and Room System calling</sub> |
| <sub>EnableWeChatLogin</sub> | <sub>Disabled, 0</sub> | <sub>Boolean</sub> | <sub>Enables login with WeChat authentication. (A)</sub> | <sub>Authentication</sub> |
| <sub>EnablQQLogin</sub> | <sub>Disabled, 0</sub> | <sub>Boolean</sub> | <sub>Enables login with QQ authentication. (A)</sub> | <sub>Authentication</sub> |
| <sub>EnforceAppSignInToJoin</sub> | <sub>Disabled, 0</sub> | <sub>Boolean</sub> | <sub>Require authentication on the desktop client to join any meeting on the desktop client.</sub> | <sub>Authentication</sub> |
| <sub>EnforceAppSignInToJoinForWebinar</sub> | <sub>Disabled, 0</sub> | <sub>Boolean</sub> | <sub>Require authentication on the desktop client to join any webinar on the desktop client.</sub> | <sub>Authentication</sub> |
| <sub>EnforceSignInToJoin</sub> | <sub>Disabled, 0</sub> | <sub>Boolean</sub> | <sub>Require users to be authenticated before joining a meeting with the desktop client. Authentication can take place through the the web portal, if joining through join URL.</sub> | <sub>Authentication</sub> |
| <sub>EnforceSignInToJoinForWebinar</sub> | <sub>Disabled, 0</sub> | <sub>Boolean</sub> | <sub>Require users to be authenticated before joining a webinar with the desktop client. Authentication can take place through the the web portal, if joining through join URL.</sub> | <sub>Authentication</sub> |
| <sub>ForceSSOURL</sub> | <sub>Disabled, (empty)</sub> | <sub>String</sub> | <sub>Set and lock the default SSO URL for SSO login.<br>For example, hooli.zoom.us would be set as "ForceSSOUrl=hooli".</sub> | <sub>Authentication</sub> |
| <sub>FullScreenWhenJoin</sub> | <sub>Disabled, 0</sub> | <sub>Boolean</sub> | <sub>When starting or joining a meeting, the meeting window will enter full-screen.</sub> | <sub>General meeting and client options</sub> |
| <sub>HidePhoneInComingCallWhileInMeeting</sub> | <sub>Disabled, 0</sub> | <sub>Boolean</sub> | <sub>Prevent incoming call notifications while in a meeting.</sub> | <sub>Zoom Phone</sub> |
| <sub>IgnoreBandwidthLimits</sub> | <sub>Disabled, 0</sub> | <sub>Boolean</sub> | <sub>Ignore bandwidth limit set on web settings. (Useful for exceptions to bandwidth restrictions)</sub> | <sub>Network</sub> |
| <sub>Intercloud_DisableAllFeatures</sub> | <sub>Disabled, 0</sub> | <sub>Boolean</sub> | <sub>Disables all features except for audio and video for meetings hosted on the ZfG cloud.</sub> | <sub>Intercloud Policies</sub> |
| <sub>Intercloud_DisableAnnotation</sub> | <sub>Disabled, 0</sub> | <sub>Boolean</sub> | <sub>Disables the local ability to annotate on shared content in meetings hosted on the ZfG Cloud.<br>This does not affect others' ability to annotate.</sub> | <sub>Intercloud Policies</sub> |
| <sub>Intercloud_DisableClosedCaptioning</sub> | <sub>Disabled, 0</sub> | <sub>Boolean</sub> | <sub>Disabled by default, this option disables the use of captioning features on meetings hosted on the ZfG Cloud.</sub> | <sub>Intercloud Policies</sub> |
| <sub>Intercloud_DisableComputerAudio</sub> | <sub>Disabled, 0</sub> | <sub>Boolean</sub> | <sub>Disabled by default, this option disables the use of computer audio for connecting to meetings hosted on the ZfG Cloud.</sub> | <sub>Intercloud Policies</sub> |
| <sub>Intercloud_DisableLocalRecording</sub> | <sub>Disabled, 0</sub> | <sub>Boolean</sub> | <sub>Disabled by default, this option disables the ability to locally record meetings hosted on the ZfG Cloud.</sub> | <sub>Intercloud Policies</sub> |
| <sub>Intercloud_DisableMeetingChat</sub> | <sub>Disabled, 0</sub> | <sub>Boolean</sub> | <sub>Disables the use of in-meeting chat on meetings hosted on the ZfG Cloud.</sub> | <sub>Intercloud Policies</sub> |
| <sub>Intercloud_DisableMeetingFileTransfer</sub> | <sub>Disabled, 0</sub> | <sub>Boolean</sub> | <sub>Disables the use of file transfers through in-meeting chat on meetings hosted on the ZfG Cloud.</sub> | <sub>Intercloud Policies</sub> |
| <sub>Intercloud_DisableMeetingPolls</sub> | <sub>Disabled, 0</sub> | <sub>Boolean</sub> | <sub>Disabled by default, this option disables the use of polling in meetings hosted on the ZfG Cloud.</sub> | <sub>Intercloud Policies</sub> |
| <sub>Intercloud_DisableMeetingReactions</sub> | <sub>Disabled, 0</sub> | <sub>Boolean</sub> | <sub>Disables the use of meeting reactions on meetings hosted on the ZfG Cloud.</sub> | <sub>Intercloud Policies</sub> |
| <sub>Intercloud_DisableRemoteControl</sub> | <sub>Disabled, 0</sub> | <sub>Boolean</sub> | <sub>Disabled by default, this option disables the remote control of shared screens in meetings hosted on the ZfG Cloud.</sub> | <sub>Intercloud Policies</sub> |
| <sub>Intercloud_DisableShareScreen</sub> | <sub>Disabled, 0</sub> | <sub>Boolean</sub> | <sub>Disables the local ability to share screen on meetings hosted on the ZfG Cloud.<br>This does not affect others' ability to shared content.</sub> | <sub>Intercloud Policies</sub> |
| <sub>Intercloud_DisableWhiteBoard</sub> | <sub>Disabled, 0</sub> | <sub>Boolean</sub> | <sub>Disables the use of in-meeting whiteboarding on meetings hosted on the ZfG Cloud.</sub> | <sub>Intercloud Policies</sub> |
| <sub>KeepSignedIn</sub> | <sub>Disabled, 0</sub> | <sub>Boolean</sub> | <sub>Keep the user signed in to the client when relaunched.<br>(Email login only)</sub> | <sub>Authentication</sub> |
| <sub>LegacyCaptureMode</sub> | <sub>Disabled, 0</sub> | <sub>Boolean</sub> | <sub>Disable GPU acceleration.</sub> | <sub>Screen sharing</sub> |
| <sub>Login_Domain</sub> | <sub>Disabled, (empty)</sub> | <sub>String</sub> | <sub>Set the email address domain that users can login with, each separated by "&". <br>Example: zoom.us & hooli.com</sub> | <sub>Authentication</sub> |
| <sub>MuteIMNotificationWhenInMeeting</sub> | <sub>Enabled, 1</sub> | <sub>Boolean</sub> | <sub>Mute chat system notifications when in a meeting.</sub> | <sub>Zoom Chat</sub> |
| <sub>MuteVoipWhenJoin</sub> | <sub>Disabled, 0</sub> | <sub>Boolean</sub> | <sub>Mute computer audio microphone when joining a meeting.</sub> | <sub>Audio</sub> |
| <sub>MuteWhenLockScreen</sub> | <sub>Enabled, 1</sub> | <sub>Boolean</sub> | <sub>Automatically mute the microphone, when the screen is locked during a meeting.</sub> | <sub>General meeting and client options</sub> |
| <sub>NoFacebook</sub> | <sub>Disabled, 0</sub> | <sub>Boolean</sub> | <sub>Remove Facebook login option.</sub> | <sub>Authentication</sub> |
| <sub>NoGoogle</sub> | <sub>Disabled, 0</sub> | <sub>Boolean</sub> | <sub>Remove Google login option.</sub> | <sub>Authentication</sub> |
| <sub>NoSSO</sub> | <sub>Disabled, 0</sub> | <sub>Boolean</sub> | <sub>Remove SSO login option.</sub> | <sub>Authentication</sub> |
| <sub>OverrideEnforceSigninIntercloud</sub> | <sub>Disabled, 0</sub> | <sub>Boolean</sub> | <sub>Override the EnforceSignInToJoin policy and allows a user to join a Zoom meeting hosted on the ZfG Cloud, without the need to authenticate.</sub> | <sub>Intercloud Policies</sub> |
| <sub>PlaySoundForIMMessage</sub> | <sub>Enabled, 1</sub> | <sub>Boolean</sub> | <sub>Play audio notifications when an IM message is received.</sub> | <sub>Zoom Chat</sub> |
| <sub>PresentInMeetingOption</sub> | <sub>Show all sharing options, 0</sub> | <sub>Boolean</sub> | <sub>Set sharing option when sharing directly to a Zoom Room within a meeting: <br>0 - Show all sharing options<br>1 - Automatically share desktop</sub> | <sub>Screen sharing</sub> |
| <sub>PresentToRoomOptimizeVideo</sub> | <sub>Enabled, 1</sub> | <sub>Boolean</sub> | <sub>Optimize screen sharing for video clip when sharing to a Zoom Room.</sub> | <sub>Zoom Room and Room System calling</sub> |
| <sub>PresentToRoomOption</sub> | <sub>Automatically share desktop, 1</sub> | <sub>Boolean</sub> | <sub>Set sharing option when sharing to a Zoom Room:<br>0 - Show all sharing options<br>1 - Automatically share desktop</sub> | <sub>Zoom Room and Room System calling</sub> |
| <sub>PresentToRoomWithAudio</sub> | <sub>Enabled, 1</sub> | <sub>Boolean</sub> | <sub>Share sound when screen sharing to a Zoom Room.</sub> | <sub>Zoom Room and Room System calling</sub> |
| <sub>ProxyBypass, bypass_rule</sub> | <sub>Disabled, (empty)</sub> | <sub>String</sub> | <sub>Set proxy bypass rule for the desktop client.</sub> | <sub>Network</sub> |
| <sub>ProxyPAC, your_pac_url</sub> | <sub>Disabled, (empty)</sub> | <sub>String</sub> | <sub>Set proxy server for desktop client with PAC URL.</sub> | <sub>Network</sub> |
| <sub>ProxyServer, proxy_address</sub> | <sub>Disabled, (empty)</sub> | <sub>String</sub> | <sub>Set a proxy server for desktop client as named proxy.<br>Example: server: port</sub> | <sub>Network</sub> |
| <sub>RecordPath, your_recording_path</sub> | <sub>/Users/User Name/Documents/Zoom</sub> | <sub>String</sub> | <sub>Set the default recording location for local recordings.</sub> | <sub>Recording</sub> |
| <sub>SetCommand4IncomingCalls</sub> | <sub>Disabled, (empty)</sub> | <sub>String</sub> | <sub>Set the URL used when the client receives an incoming call.<br>This must be used in coordination with EnableLaunchApp4IncomingCalls.</sub> | <sub>Zoom Phone</sub> |
| <sub>SetDevicePolicyToken, device_token</sub> | <sub>Disabled, (empty)</sub> | <sub>String</sub> | <sub>Require internal meeting authentication. (C)</sub> | <sub>Authentication</sub> |
| <sub>SetEnrollToken4CloudMDM, token</sub> | <sub>Disabled, (empty)</sub> | <sub>String</sub> | <sub>Enroll your device into Zoom Device Management with a token provided from the web portal.</sub> | <sub>Install and Update</sub> |
| <sub>SetMessengerDoNotDropThread</sub> | <sub>Disabled, 0</sub> | <sub>Boolean</sub> | <sub>Move messages with new replies to the bottom of the chat/channel.</sub> | <sub>Zoom Chat</sub> |
| <sub>SetScreenCaptureMode</sub> | <sub>Auto, 0</sub> | <sub>String</sub> | <sub>Set the screen capture mode:<br>0 - Auto<br>1 - Legacy operating systems<br>2 - Share with window filtering<br>3 - Advanced share with window filtering<br>4 - Advanced share without window filtering</sub> | <sub>Screen sharing</sub> |
| <sub>SetSuppressBackgroundNoiseLevel</sub> | <sub>Auto (0)</sub> | <sub>String</sub> | <sub>Set level of background noise suppression:<br>0 - Auto<br>1- Low<br>2 - Medium<br>3 - High</sub> | <sub>Audio</sub> |
| <sub>SetUpdatingChannel</sub> | <sub>Slow, 0</sub> | <sub>Boolean</sub> | <sub>Control the cadence of updates applied to the desktop client (version 5.6.8 or higher):<br>Slow (0): fewer updates and better stability.<br>Fast (1): newest features and updates.</sub> | <sub>Install and Update</sub> |
| <sub>SetUseSystemDefaultMicForVOIP</sub> | <sub>Disabled, 0</sub> | <sub>Boolean</sub> | <sub>Use the default system speakers.</sub> | <sub>Audio</sub> |
| <sub>SetUseSystemDefaultSpeakerForVOIP</sub> | <sub>Disabled, 0</sub> | <sub>Boolean</sub> | <sub>Use the default system microphone.</sub> | <sub>Audio</sub> |
| <sub>SetWebDomain</sub> | <sub>Disabled, (empty)</sub> | <sub>String</sub> | <sub>Sets the web domain for logging in or joining a meeting.<br>By default, the value is https://zoom.us or https://zoom.com.</sub> | <sub>Authentication</sub> |
| <sub>ShowConnectedTime</sub> | <sub>Disabled, 0</sub> | <sub>Boolean</sub> | <sub>Display the length of time that the user has been in the current meeting.</sub> | <sub>General meeting and client options</sub> |
| <sub>ShowIMMessagePreview</sub> | <sub>Enabled, 1</sub> | <sub>Boolean</sub> | <sub>Allow message previews in system notifications when a chat message is received.</sub> | <sub>Zoom Chat</sub> |
| <sub>ShowProfilePhotosInChat</sub> | <sub>Disabled, 0</sub> | <sub>Boolean</sub> | <sub>Controls if user profile pictures are shown in Zoom Chat.</sub> | <sub>Zoom Chat</sub> |
| <sub>ShowVideoMessageButton</sub> | <sub>Enabled, 1</sub> | <sub>Boolean</sub> | <sub>Allow use of the Send video message option.</sub> | <sub>Zoom Chat</sub> |
| <sub>ShowVoiceMessageButton</sub> | <sub>Enabled, 1</sub> | <sub>Boolean</sub> | <sub>Allow use of the Send audio message option.</sub> | <sub>Zoom Chat</sub> |
| <sub>VideoRenderMethod</sub> | <sub>Auto, 0</sub> | <sub>String</sub> | <sub>Set the video rendering method:<br>0 - Auto<br>1 - Direct3D11 Flip Mode<br>2 - Direct3D11<br>3 - Direct3D9<br>4 - GDI</sub> | <sub>Video</sub> |
| <sub>zAutoFitWhenViewShare</sub> | <sub>Enabled, 1</sub> | <sub>Boolean</sub> | <sub>When viewing shared content, the content window automatically adjusts to fit the viewer's screen.</sub> | <sub>Screen sharing</sub> |
| <sub>zAutoFullScreenWhenViewShare</sub> | <sub>Enabled, 1</sub> | <sub>Boolean</sub> | <sub>When viewing shared content, the content window automatically goes fullscreen.</sub> | <sub>Screen sharing</sub> |
| <sub>zAutoJoinVoip</sub> | <sub>Disabled, 0</sub> | <sub>Boolean</sub> | <sub>Automatically connect audio with computer audio when joining a meeting.</sub> | <sub>Audio</sub> |
| <sub>zAutoSSOLogin</sub> | <sub>Disabled, 0</sub> | <sub>Boolean</sub> | <sub>Defaults login to SSO.</sub> | <sub>Authentication</sub> |
| <sub>zAutoUpdate</sub> | <sub>Disabled, 0</sub> | <sub>Boolean</sub> | <sub>Enable updates through the client by users. When disabled, the Check for Updates button is also hidden.</sub> | <sub>Install and Update</sub> |
| <sub>zDisableAnnotation</sub> | <sub>Disabled, 0</sub> | <sub>Boolean</sub> | <sub>Disable and remove the ability to annotate over shared screen.</sub> | <sub>Screen sharing</sub> |
| <sub>zDisableChat</sub> | <sub>Disabled, 0</sub> | <sub>Boolean</sub> | <sub>Disable in-meeting chat.</sub> | <sub>In-meeting Chat</sub> |
| <sub>zDisableCMR</sub> | <sub>Disabled, 0</sub> | <sub>Boolean</sub> | <sub>Disable recording to the cloud.</sub> | <sub>Recording</sub> |
| <sub>zDisableFT</sub> | <sub>Disabled, 0</sub> | <sub>Boolean</sub> | <sub>Disable in-meeting file transfer. (sending or receiving)</sub> | <sub>In-meeting Chat</sub> |
| <sub>zDisableLocalRecord</sub> | <sub>Disabled, 0</sub> | <sub>Boolean</sub> | <sub>Disable recording locally on the device.</sub> | <sub>Recording</sub> |
| <sub>zDisableRecvVideo</sub> | <sub>Disabled, 0</sub> | <sub>Boolean</sub> | <sub>Disable receiving video.</sub> | <sub>Video</sub> |
| <sub>zDisableSendVideo</sub> | <sub>Disabled, 0</sub> | <sub>Boolean</sub> | <sub>Disable sending video.</sub> | <sub>Video</sub> |
| <sub>zDisableVideo</sub> | <sub>Disabled, 0</sub> | <sub>Boolean</sub> | <sub>Automatically turn off camera when joining a meeting.</sub> | <sub>Video</sub> |
| <sub>zDualMonitorOn</sub> | <sub>Disabled, 0</sub> | <sub>Boolean</sub> | <sub>Enable dual monitor mode.</sub> | <sub>General meeting and client options</sub> |
| <sub>zHideNoVideoUser</sub> | <sub>Disabled, 0</sub> | <sub>Boolean</sub> | <sub>Hide non-video participants by default.</sub> | <sub>Video</sub> |
| <sub>zRemoteControllAllApp</sub> | <sub>Enabled, 1</sub> | <sub>Boolean</sub> | <sub>Allow remote control of all applications.</sub> | <sub>Screen sharing</sub> |
| <sub>zSSOHost</sub> | <sub>Disabled, (empty)</sub> | <sub>String</sub> | <sub>Set the default SSO URL for SSO login.<br>For example, hooli.zoom.us would be set as "ForceSSOUrl=hooli".</sub> | <sub>Authentication</sub> |
| <sub>zUse720PByDefault</sub> | <sub>Disabled, 0</sub> | <sub>Boolean</sub> | <sub>Use HD video in meetings.</sub> | <sub>Video</sub> |
