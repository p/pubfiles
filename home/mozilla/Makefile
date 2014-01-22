all: install

MOZ_HOME=/home/browser

install:
	sudo -Hiu browser chmod -R g+rwX ${MOZ_HOME} && \
	cwd=`pwd` && \
	for dir in .mozilla/firefox; do \
		cd ${MOZ_HOME}/$$dir && \
		for profile in */; do \
			( \
				sudo -Hiu browser chmod -R g+rwX "`pwd`"/"$$profile"; \
				cd "$$profile" && \
				sudo -Hiu browser mkdir -p "`pwd`/chrome" && \
				sudo -Hiu browser chmod g+rwX "`pwd`/chrome" && \
				for file in gm_scripts user.js chrome/userContent.css chrome/userChrome.css; do \
					if test -L $$file; then rm $$file; fi && \
					ln -s $$cwd/`basename $$file` $$file; \
				done && \
				cat $$cwd/user.js >>prefs.js \
			) \
		done \
	done
