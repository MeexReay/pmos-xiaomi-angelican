#!/bin/bash

source extract-paths.sh

pmbootstrap chroot apk add android-tools

has_fastboot_device() {
  if pmbootstrap chroot fastboot devices | grep -q "LBA"
  then
    return 
  else
    return 1
  fi
}

wait_fastboot_device() {
  until has_fastboot_device
  do
    sleep 1
  done
}

has_recovery_device() {
  if pmbootstrap chroot adb devices | grep -q "recovery"
  then
    return 0
  else
    return 1
  fi
}

wait_recovery_device() {
  until has_recovery_device
  do
    sleep 1
  done
}

if ! has_fastboot_device
then
  echo "Rebooting into Fastboot..."
  echo "Hold Volume Down button!"
  sleep 1

  pmbootstrap chroot adb reboot bootloader

  sleep 10
fi

until pmbootstrap flasher flash_rootfs
do
  sleep 1
done
until pmbootstrap flasher boot
do
  sleep 1
done

echo "Booting into System..."

sleep 15

echo "Rebooting into Recovery..."
echo "Hold Volume Up button!"

wait_recovery_device
./extract-kernel-trouble.sh
