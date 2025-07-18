all:
	sed -e '/diktor/,$$d' <`if test -e /usr/local/share/X11/xkb; then echo /usr/local/share/X11/xkb; else echo /usr/share/X11/xkb; fi`/symbols/ru >ru
	cat diktor >>ru
	echo >>ru
	cat dp >>ru

	sed -e '/kinesis/,$$d' <`if test -e /usr/local/share/X11/xkb; then echo /usr/local/share/X11/xkb; else echo /usr/share/X11/xkb; fi`/symbols/us >us
	cat kinesis >>us
	echo >>us
	cat x41 >>us
