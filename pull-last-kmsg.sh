#!/bin/bash

source extract-paths.sh

LOG_FILE=/proc/last_kmsg

pmbootstrap chroot apk add android-tools

pmbootstrap chroot adb shell stat $LOG_FILE
pmbootstrap chroot adb pull $LOG_FILE /home/pmos/full-kernel-trouble.txt

sudo mv $PMWORK/chroot_native/home/pmos/full-kernel-trouble.txt /tmp

source write-kernel-trouble.sh

sudo pkill adb

