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

tail -n $NUM_LINES /tmp/full-kernel-trouble > kernel-trouble.txt

echo
echo "Last $NUM_LINES log lines" 
echo

cat kernel-trouble.txt

echo
echo "Saved to \"$PWD/kernel-trouble.txt\""
echo "Full log was saved to \"/tmp/full-kernel-trouble.txt\""
echo
