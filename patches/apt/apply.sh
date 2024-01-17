#!/bin/sh

# http://bsdpower.com/apt-cache-sorted-output/
# Run as root: apt-get build-dep apt && apt-get install fakeroot

set -e

if test "$1" = -u; then
  if test `id -u` != 0; then
    exec sudo "$0" "$@"
  fi
  
  apt-get build-dep apt
  apt-get install fakeroot debhelper
fi

cwd="`pwd`"
tmpdir="`mktemp -d`"

if test "`dirname "$0"`" = . -a "`basename "$0"`" != "$0"; then
  src="`pwd`"
elif test "`dirname "$0"`" != .; then
  src="`dirname "$0"`"
else
  src=/home/me/apps/exp/pubfiles/patches/apt
fi

version=`dpkg-query -l apt |grep ^ii |awk '{print $3}' |sed -Ee s/'^([0-9]+\.[0-9]+).*/\1'/`
if test -z "$version"; then
  echo 'No apt installed?' 1>&2
  exit 10
fi

if test `expr "$version" '<' 1.0` = 1; then
  patch_version=0.9.9
elif test `expr "$version" '<' 1.3` = 1; then
  patch_version=1.0
elif test `expr "$version" '<' 1.4` = 1; then
  patch_version=1.3
else
  patch_version=1.4.3
fi

cd "$tmpdir"
#wget http://bsdpower.com/apt-cache-sorted-output/apt-cache-sorted-output-patch.diff

apt-get source apt
cd apt-*
patch -p1 <$src/apt-cache-sorted-output-$patch_version.diff

dpkg-buildpackage
cp ../apt_*.deb "$cwd"

cd "$cwd"
rm -rf "$tmpdir"
