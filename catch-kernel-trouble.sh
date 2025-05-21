#!/bin/bash

source extract-paths.sh

pmbootstrap chroot apk add android-tools

has_fastboot() {
  pmbootstrap chroot fastboot devices 2> /dev/null | grep -q "LBA"
  return $?
}

has_recovery() {
  pmbootstrap chroot adb devices 2> /dev/null | grep -q "recovery"
  return $?
}

wait_for() {
  until "$@"; do; sleep 1; done
}

if ! has_fastboot
then
  echo "Rebooting into Fastboot..."
  echo "Hold Volume Down button!"
  sleep 1

  pmbootstrap chroot adb reboot bootloader

  sleep 10
fi

wait_for pmbootstrap flasher flash_rootfs
wait_for pmbootstrap flasher boot

echo "Booting into System..."

sleep 15

echo "Rebooting into Recovery..."
echo "Hold Volume Up button!"

wait_for has_recovery
source pull-pstore-ramoops.sh
