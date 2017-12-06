#!/bin/sh

# http://bsdpower.com/rebuild-scite-for-gtk2-on-debian-jessie/
# Run as root: apt-get build-dep scite && apt-get install fakeroot libgtk2.0-dev

set -e

if test "$1" = -u; then
  if test `id -u` != 0; then
    exec sudo "$0" "$@"
  fi

  apt-get build-dep scite
  apt-get install fakeroot libgtk2.0-dev debhelper
fi

if test "`dirname "$0"`" = .; then
  src=`pwd`
else
  src="`dirname "$0"`"
fi

cwd="`pwd`"
tmpdir="`mktemp -d`"

cd "$tmpdir"

apt-get source scite
cd scite-*
(cd scite &&
patch -p1 <"$src"/patch-tab-width-4.0.0.diff)
patch -p0 <"$src"/patch-debian-gtk2.diff
sed -i -e s/libgtk-3-dev/libgtk2.0-dev/ debian/control

# http://askubuntu.com/questions/226495/how-to-solve-dpkg-source-source-problem-when-building-a-package
dpkg-buildpackage -b
cp ../scite_*.deb "$cwd"

if test "$1" = -u; then
  dpkg -i ../scite_*.deb
fi

cd "$cwd"
rm -rf "$tmpdir"
