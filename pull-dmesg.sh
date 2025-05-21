#!/bin/bash

source extract-paths.sh

pmbootstrap -q chroot adb shell dmesg > full-kernel-trouble-temp.txt
sudo mv full-kernel-trouble-temp.txt /tmp/full-kernel-trouble.txt

source write-kernel-trouble.sh

sudo pkill adb
