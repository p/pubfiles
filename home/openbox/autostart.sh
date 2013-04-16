#!/bin/sh

have_screen() {
	screen="$1"
	DISPLAY=:0.$screen xdpyinfo >/dev/null 2>&1
}

if have_screen 1; then
	setlayout 1 1 3 0
else
	setlayout 0 1 3 0
fi

xsetroot -solid '#102030'
xsetroot -cursor_name left_ptr
