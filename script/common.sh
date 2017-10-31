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

is_headless() {
  grep -q 'Intel.*Q9300' /proc/cpuinfo
}

install_mm() {
  ! grep -q 'Intel.*7700K' /proc/cpuinfo
}

have_user() {
  usermod "$1" >/dev/null 2>&1
}
