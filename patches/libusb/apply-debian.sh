#!/bin/sh

set -e

if test "$1" = -u; then
  if test `id -u` != 0; then
    exec sudo "$0" "$@"
  fi

  apt-get build-dep libusb-1.0
  #apt-get install fakeroot libgtk2.0-dev debhelper liblua5.3-dev
fi

if test "`dirname "$0"`" = .; then
  src=`pwd`
else
  src="`dirname "$0"`"
fi

cwd="`pwd`"
tmpdir="`mktemp -d`"

cd "$tmpdir"

apt-get source libusb-1.0
cd libusb-*
(patch -p0 <"$src"/sorted-device-list-1.0.26.diff)

set -x
version=`head -n 1 debian/changelog |egrep -o '\(.*?\)' |tr -d '()'`
dch -v "$version"+o "Oleg's patches"

# http://askubuntu.com/questions/226495/how-to-solve-dpkg-source-source-problem-when-building-a-package
dpkg-buildpackage -b
cp ../libusb-1.0-0_*.deb "$cwd"

if test "$1" = -u; then
  dpkg -i ../libusb-1.0-0_*.deb
fi

cd "$cwd"
rm -rf "$tmpdir"
