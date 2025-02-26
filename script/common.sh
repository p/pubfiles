apt_updated=false

have() {
  which "$1" >/dev/null 2>&1
}

is_thinkpad() {
  grep -q LENOVO /sys/devices/virtual/dmi/id/chassis_vendor 2>/dev/null &&
  grep -q ThinkPad /sys/devices/virtual/dmi/id/product_family 2>/dev/null
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

yesnoauto() {
  if test -z "$1"; then
    echo Auto
  elif $1; then
    echo Yes
  else
    echo No
  fi
}

install_if_needed() {
  local needed not_needed
  needed=
  not_needed=
  for pkg in "$@"; do
    if dpkg-query -l "$pkg" |sed -e '1,/^++/d' |grep -q ^.i >/dev/null 2>&1; then
      not_needed="$not_needed $pkg"
    else
      needed="$needed $pkg"
    fi
  done
  if test -n "$not_needed"; then
    apt-mark manual $not_needed
  fi
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
  if test -f /etc/setup.conf; then
    value=`egrep '^[[:space:]]*headful=' /etc/setup.conf |awk -F = '{print $2}' |sed -Ee 's/\s#.*//'`
    if test "$value" = true; then
      return 0
    elif test "$value" = false; then
      return 1
    elif test -n "$value"; then
      echo "Bogus \`headful' value in /etc/setup.conf: $value" 1>&2
      exit 4
    fi
  fi
  
  laptop-detect
}

is_aws() {
  grep -q EPYC /proc/cpuinfo
}

install_mm() {
  if test -f /etc/setup.conf; then
    value=`egrep '^[[:space:]]*mm=' /etc/setup.conf |awk -F = '{print $2}' |sed -Ee 's/[[:space:]]*#.*//'`
    if test "$value" = true; then
      return 0
    elif test "$value" = false; then
      return 1
    elif test -n "$value"; then
      echo "Bogus \`mm' value in /etc/setup.conf: $value" 1>&2
      exit 4
    fi
  fi
  
  is_headful
}

setup_encrypt() {
  echo "$1" |openssl aes-256-cbc -a -salt -pass pass:`cat /etc/setup.secret` -pbkdf2
}

setup_decrypt() {
  echo "$1" |openssl aes-256-cbc -d -a -pass pass:`cat /etc/setup.secret` -pbkdf2
}
