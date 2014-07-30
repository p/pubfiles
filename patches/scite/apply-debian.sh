#!/bin/sh

# http://bsdpower.com/rebuild-scite-for-gtk2-on-debian-jessie/
# Run as root: apt-get build-dep scite && apt-get install fakeroot libgtk2.0-dev

set -e

cwd="`pwd`"
tmpdir="`mktemp -d`"

cd "$tmpdir"
wget https://raw.githubusercontent.com/p/freebsd-ports-changes/master/overlay/editors/scite/files/patch-tab-width
#wget http://bsdpower.com/rebuild-scite-for-gtk2-on-debian-jessie/scite-debian-gtk2-patch.diff
cp /home/me/apps/exp/pubfiles/patches/scite/scite-debian-gtk2-patch.diff .

apt-get source scite
cd scite-*
(cd scite &&
patch -p1 <../../patch-tab-width)
patch -p0 <../scite-debian-gtk2-patch.diff
sed -i -e s/libgtk-3-dev/libgtk2.0-dev/ debian/control

# http://askubuntu.com/questions/226495/how-to-solve-dpkg-source-source-problem-when-building-a-package
dpkg-buildpackage -b
cp ../scite_*.deb "$cwd"

cd "$cwd"
rm -rf "$tmpdir"
