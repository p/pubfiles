all: install

install:
	cwd=`pwd` && \
	for dir in .mplayer; do \
		cd $$HOME/$$dir && \
		for file in config input.conf; do \
			if test -L $$file; then rm $$file; fi && \
			ln -s $$cwd/`basename $$file` $$file; \
		done \
	done
