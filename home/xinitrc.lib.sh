#!/bin/sh

have() {
  which "$@" >/dev/null 2>&1
}

merge_defaults() {
	userresources=$HOME/.Xresources
	usermodmap=$HOME/.Xmodmap
	sysresources=/usr/X11R6/lib/X11/xinit/.Xresources
	sysmodmap=/usr/X11R6/lib/X11/xinit/.Xmodmap

	# merge in defaults and keymaps

	[ -f $sysresources ] && /usr/X11R6/bin/xrdb -merge $sysresources
	[ -f $sysmodmap ] && /usr/X11R6/bin/xmodmap $sysmodmap
	[ -f $userresources ] && /usr/X11R6/bin/xrdb -merge $userresources
	[ -f $usermodmap ] && /usr/X11R6/bin/xmodmap $usermodmap
}

common_init() {
	#xset dpms 0 0 600
	if test "`hostname -s`" = athena; then
		layout=x41
	else
		layout=dvorak
	fi
	setxkbmap us $layout
	
	# This needs to be done for each br-* account
	#forward_xauth
}

have_screen() {
	screen="$1"
	DISPLAY=:0.$screen xdpyinfo >/dev/null 2>&1
}

init_triple_head() {
	if have_screen 2; then
		DISPLAY=:0.2 XDG_CONFIG_HOME=$HOME/.right-screen openbox-session &
	fi

	if have_screen 1; then
		DISPLAY=:0.1 XDG_CONFIG_HOME=$HOME/.left-screen openbox-session &
	fi

	DISPLAY=:0.0 XDG_CONFIG_HOME=$HOME/.center-screen exec openbox-session
}

init_dual_head() {
	if have_screen 1; then
		export DISPLAY=:0.1
		XDG_CONFIG_HOME=$HOME/.right-screen openbox-session &
	fi

	export DISPLAY=:0.0
	XDG_CONFIG_HOME=$HOME/.left-screen exec openbox-session
}

init_single_head() {
	exec openbox-session
	#XDG_CONFIG_HOME=$HOME/.center-screen exec openbox-session
}

init_as_configured() {
	case "$(cat $HOME/.info/max-screens)" in
	2)
		init_dual_head;;
	3)
		init_triple_head;;
	*)
		init_single_head;;
	esac
}

#have xscreensaver && xscreensaver -no-splash &

skip_lock=false
if test -e /etc/setup.conf && grep -q skip_lock=true /etc/setup.conf; then
  skip_lock=true
fi
if ! $skip_lock; then
  if have xss-lock && have xsecurelock; then
    xset s 600
    xss-lock env \
      XSECURELOCK_PASSWORD_PROMPT=asterisks \
      XSECURELOCK_SHOW_HOSTNAME=1 \
      XSECURELOCK_SHOW_USERNAME=1 \
      XSECURELOCK_AUTH_FOREGROUND_COLOR=rgb:aa/aa/aa \
      XSECURELOCK_DISCARD_FIRST_KEYPRESS=0 \
      xsecurelock &
  fi

  if have xautolock && have xsecurelock; then
    xautolock -time 15 -locker 'env XSECURELOCK_PASSWORD_PROMPT=asterisks XSECURELOCK_SHOW_HOSTNAME=1 XSECURELOCK_SHOW_USERNAME=1 xsecurelock' &
  fi
fi
