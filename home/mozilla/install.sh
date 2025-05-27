#!/bin/sh

set -e

base="`dirname $0`"

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
  echo "Trying to install to $target which does not exist." 1>&2
  if test -f ~/.mozilla/firefox/profiles.ini ||
    test -f ~/.moonchild\ productions/pale\ moon/profiles.ini ||
    test -f ~/.waterfox/profiles.ini;
  then
    read -p "Found Mozilla profiles in ~, install to ~ ? [Yn] " yn
    case $yn in
    [yY])
      ok=true
      ;;
    ?)
      ok=false
      ;;
    *)
      ok=true
      ;;
    esac
    if $ok; then
      target=~
    else
      exit 11
    fi
  fi
fi

MOZ_HOME="$target"

do_stat() {
  if test "`uname -s`" = Linux; then
    stat -c %u "$@"
  else
    # freebsd
    stat -f %u "$@"
  fi
}

target_owner=$(do_stat "$target")
me=`id -u`
if test "$me" != "$target_owner"; then
  USE_SUDO=true
else
  USE_SUDO=false
fi

as_browser() {
  if $USE_SUDO; then
    sudo -Hiu $(id -nu "$target_owner") "$@"
  else
    "$@"
  fi
}

if $USE_SUDO; then
  as_browser chmod -R g+rwX ${MOZ_HOME} || true
fi

for dir in .mozilla/firefox ".moonchild productions/pale moon" .waterfox; do
  if ! test -d "${MOZ_HOME}/$dir"; then
    continue
  fi
  cd "${MOZ_HOME}/$dir"
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
        base_path="$base"/`basename $file` &&
        if test -f "$base_path".erb; then
          erb <"$base"/`basename $file` >$file
        else
          ln -s $base_path $file
        fi
      done &&
      cat "$base"/user.js >>prefs.js
    )
  done
done
