#!/bin/bash

source extract-paths.sh

LOG_FILE=/sys/fs/pstore/console-ramoops-0

pmbootstrap chroot apk add android-tools

pmbootstrap chroot adb shell stat $LOG_FILE
pmbootstrap chroot adb pull $LOG_FILE /home/pmos/full-kernel-trouble.txt

sudo mv $PMWORK/chroot_native/home/pmos/full-kernel-trouble.txt /tmp

tail -n 100 /tmp/full-kernel-trouble.txt > kernel-trouble.txt

less +G /tmp/full-kernel-trouble.txt

echo "Saved last 100 lines to \"$PWD/kernel-trouble.txt\""
echo "Full log was saved to \"/tmp/full-kernel-trouble.txt\""

sudo pkill adb
