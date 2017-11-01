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

have_user() {
  usermod "$1" >/dev/null 2>&1
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
    if ! dpkg -L "$pkg" >/dev/null 2>&1; then
      needed="$needed $pkg"
    fi
  done
  if test -n "$needed"; then
    echo "Installing packages: $needed"
    apt-get install $needed
  fi
}

# MACHINES

is_headful() {
  ! grep -q 'Intel.*Q9300' /proc/cpuinfo
}

install_mm() {
  ! grep -q 'Intel.*7700K' /proc/cpuinfo
}
