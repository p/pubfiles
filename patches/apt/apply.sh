#!/bin/sh

# http://bsdpower.com/apt-cache-sorted-output/
# Run as root: apt-get build-dep apt && apt-get install fakeroot

set -e

cwd="`pwd`"
tmpdir="`mktemp -d`"

cd "$tmpdir"
#wget http://bsdpower.com/apt-cache-sorted-output/apt-cache-sorted-output-patch.diff
cp /home/me/apps/exp/apt-cache-sorted-output/apt-cache-sorted-output-patch.diff .

apt-get source apt
cd apt-*
patch -p1 <../apt-cache-sorted-output-patch.diff

dpkg-buildpackage
cp ../apt_*.deb "$cwd"

cd "$cwd"
rm -rf "$tmpdir"
