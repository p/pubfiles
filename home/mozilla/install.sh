#!/bin/sh

set -e

target=/home/browser

while getopts t: opt; do
	case $opt in
	t)
		target="$OPTARG"
		;;
	*)
		echo "Bogus option $opt" 1>&2
		exit 10
		;;
	esac
done
shift $((OPTIND-1))

if ! test -d "$target"; then
	echo "Trying to install to $target which does not exist" 1>&2
	exit 11
fi

MOZ_HOME="$target"

target_owner=$(stat -c "%u" "$target")
me=`id -u`
if test "$me" != "$target_owner"; then
	USE_SUDO=true
else
	USE_SUDO=false
fi

as_browser() {
	if $USE_SUDO; then
		sudo -Hiu "$target_owner" "$@"
	else
		"$@"
	fi
}

if $USE_SUDO; then
	as_browser chmod -R g+rwX ${MOZ_HOME}
fi

cwd=`pwd`
for dir in .mozilla/firefox; do
	cd ${MOZ_HOME}/$dir
	for profile in */; do
		(
			if $USE_SUDO; then
				as_browser chmod -R g+rwX "`pwd`"/"$profile"
			fi
			cd "$profile" &&
			as_browser mkdir -p "`pwd`/chrome" &&
			as_browser chmod g+rwX "`pwd`/chrome" &&
			for file in gm_scripts user.js chrome/userContent.css chrome/userChrome.css; do
				if test -L $file; then rm $file; fi &&
				ln -s $cwd/`basename $file` $file;
			done &&
			cat $cwd/user.js >>prefs.js
		)
	done
done
