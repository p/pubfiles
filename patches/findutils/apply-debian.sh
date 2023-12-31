#!/bin/sh

set -e

if test "$1" = -u; then
  if test `id -u` != 0; then
    exec sudo "$0" "$@"
  fi

  apt-get build-dep findutils
fi

if test "`dirname "$0"`" = .; then
  src=`pwd`
else
  src="`dirname "$0"`"
fi

cwd="`pwd`"
tmpdir="`mktemp -d`"

cd "$tmpdir"

apt-get source findutils
cd findutils-*
patch -p0 <"$src"/sorted-output.diff

set -x
version=`head -n 1 debian/changelog |egrep -o '\(.*?\)' |tr -d '()'`
dch -v "$version"+o "Oleg's patches"

# http://askubuntu.com/questions/226495/how-to-solve-dpkg-source-source-problem-when-building-a-package
dpkg-buildpackage -b
cp ../findutils_*.deb "$cwd"

if test "$1" = -u; then
  dpkg -i ../findutils_*.deb
fi

cd "$cwd"
rm -rf "$tmpdir"
