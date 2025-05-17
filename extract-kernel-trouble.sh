#!/bin/sh

./extract-paths.sh

pmbootstrap chroot apk add android-tools

pmbootstrap chroot adb shell stat /proc/last_kmsg
pmbootstrap chroot adb pull /proc/last_kmsg /home/pmos

sudo mv $PMWORK/chroot_native/home/pmos/last_kmsg /tmp/full-kernel-trouble.txt

tail -n 100 /tmp/full-kernel-trouble.txt > kernel-trouble.txt

less +G /tmp/full-kernel-trouble.txt

echo "Saved last 100 lines to \"$PWD/kernel-trouble.txt\""
echo "Full log was saved to \"/tmp/full-kernel-trouble.txt\""

sudo pkill adb
