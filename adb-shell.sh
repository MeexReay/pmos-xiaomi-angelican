#!/bin/sh

until pmbootstrap chroot adb devices 2> /dev/null | grep -q "recovery"
do
  echo "Waiting for a device in recovery mode..."
  sleep 1
done

pmbootstrap chroot adb shell
