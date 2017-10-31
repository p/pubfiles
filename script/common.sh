have() {
  which "$1" >/dev/null 2>&1
}

is_laptop() {
  if have laptop-detect; then
    laptop-detect
  else
    grep LENOVO /sys/devices/virtual/dmi/id/chassis_vendor
  fi
}
