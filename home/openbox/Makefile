# Needs gnu make

FILTER := python lib/filter.py
laptopf := $(shell if test "`hostname -s`" = reactor; then echo yes; else echo no; fi)

ifdef single
screens=1
else
ifdef dual
screens=2
else
ifdef triple
screens=3
else
#screens := $(shell if test "`hostname -s`" = reactor; then echo 1; else echo 3; fi)
screens := 1
endif
endif
endif

#ifdef laptop
#laptopf=yes
#else
#laptopf=no
#endif

ifeq "$(screens)" '1'
makecenter=1
endif

ifeq "$(screens)" '2'
makeleft=1
makecenter=1
endif

ifeq "$(screens)" '3'
makeleft=1
makecenter=1
makeright=1
endif

all: left center right
	mkdir -p $$HOME/.info
	echo $(screens) > $$HOME/.info/max-screens

left:
ifdef makeleft
	mkdir -p $$HOME/.left-screen/openbox
	export LEFT=yes SCREENS=${screens} LAPTOP=${laptopf}; ${FILTER} rc.xml > $$HOME/.left-screen/openbox/rc.xml
	export LEFT=yes SCREENS=${screens} LAPTOP=${laptopf}; ${FILTER} menu.xml > $$HOME/.left-screen/openbox/menu.xml
	install -m 555 autostart.sh $$HOME/.left-screen/openbox/autostart.sh
endif

right:
ifdef makeright
	mkdir -p $$HOME/.right-screen/openbox
	export RIGHT=yes SCREENS=${screens} LAPTOP=${laptopf}; ${FILTER} rc.xml > $$HOME/.right-screen/openbox/rc.xml
	export RIGHT=yes SCREENS=${screens} LAPTOP=${laptopf}; ${FILTER} menu.xml > $$HOME/.right-screen/openbox/menu.xml
	install -m 555 autostart.sh $$HOME/.right-screen/openbox/autostart.sh
endif

center:
ifdef makecenter
	mkdir -p $$HOME/.center-screen/openbox
	export CENTER=yes SCREENS=${screens} LAPTOP=${laptopf}; ${FILTER} rc.xml > $$HOME/.center-screen/openbox/rc.xml
	export CENTER=yes SCREENS=${screens} LAPTOP=${laptopf}; ${FILTER} menu.xml > $$HOME/.center-screen/openbox/menu.xml
	install -m 555 autostart.sh $$HOME/.center-screen/openbox/autostart.sh
endif

common:
	mkdir -p $$HOME/.config/openbox
	install -m 555 autostart.sh $$HOME/.config/openbox/autostart.sh

.PHONY: all left right center common
