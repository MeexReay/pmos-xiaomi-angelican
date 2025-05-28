#!/bin/bash

source extract-paths.sh

adb shell dmesg > /tmp/full-kernel-trouble.txt

source write-kernel-trouble.sh

sudo pkill adb
