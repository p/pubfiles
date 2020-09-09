apt_updated=false

have() {
  which "$1" >/dev/null 2>&1
}

is_thinkpad() {
  grep -q LENOVO /sys/devices/virtual/dmi/id/chassis_vendor 2>/dev/null
}

is_laptop() {
  if have laptop-detect; then
    laptop-detect
  else
    is_thinkpad
  fi
}

is_devuan() {
  grep -qi devuan /etc/issue
}

# actual debian, not derivative
is_debian() {
  if have lsb_release; then
    test "`lsb_release -si`" = Debian
  else
    test -f /etc/debian_version
  fi
}

is_ubuntu() {
  # TODO is lsb_release always present on ubuntus?
  have lsb_release && test "`lsb_release -is`" = Ubuntu 2>/dev/null
}

have_user() {
  id "$1" >/dev/null 2>&1
}

yesno() {
  if test "$1" = 0; then
    echo Yes
  else
    echo No
  fi
}

install_if_needed() {
  needed=
  for pkg in "$@"; do
    if ! dpkg-query -l "$pkg" |sed -e '1,/^++/d' |grep -q ^i >/dev/null 2>&1; then
      needed="$needed $pkg"
    fi
  done
  if test -n "$needed"; then
    echo "Installing packages: $needed"
    if ! $apt_updated; then
      if test `id -u` = 0; then
        apt-get update
      else
        sudo apt-get update
      fi
      apt_updated=true
    fi
    if test `id -u` = 0; then
      apt-get install $needed
    else
      sudo apt-get install $needed
    fi
  fi
}

# MACHINES

is_headful() {
  laptop-detect
}

is_aws() {
  grep -q EPYC /proc/cpuinfo
}

install_mm() {
  ! hostname |grep -q special && ! is_aws
}
