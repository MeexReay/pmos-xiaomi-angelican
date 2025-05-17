#!/bin/sh

NUM_LINES=100

if [ $# -ge 1 ]; then
  NUM_LINES="$1"
fi

./extract-paths.sh

pmbootstrap chroot adb pull /proc/last_kmsg /home/pmos

if ! sudo mv $PMWORK/chroot_native/home/pmos/last_kmsg /tmp/full-kernel-trouble.txt
then
  echo "1. Enter to the recovery mode"
  echo "2. Run this script"
  echo "3. Connect the phone to usb cable"
  exit 1
fi

tail -n $NUM_LINES /tmp/full-kernel-trouble.txt > kernel-trouble.txt

less +G /tmp/full-kernel-trouble.txt

echo "Saved last $NUM_LINES to \"$PWD/kernel-trouble.txt\""
echo "Full log was saved to \"/tmp/full-kernel-trouble.txt\""
