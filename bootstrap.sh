#!/bin/sh

# Usage:
# curl https://github.com/p/pubfiles/blob/master/bootstrap.sh |sh
# curl https://github.com/p/pubfiles/blob/master/bootstrap.sh |sh -s headful

set -e

headful=false
arg=$1
case "$arg" in
headful)
  headful=true;;
"")
  ;;
*)
  echo "Usage: `basename $0` [headful]" 1>&2
  exit 2
esac

if $headful; then
  if ! test -f /etc/setup.conf; then
    echo headful=true |tee /etc/setup.conf
  fi
fi

if ! $headful; then
  curl https://github.com/p/pubfiles/blob/master/script/configure-apt-no-recommends |sh
fi

apt-get install git

mkdir -p $HOME/apps
cd $HOME/apps
git clone https://github.com/p/pubfiles
