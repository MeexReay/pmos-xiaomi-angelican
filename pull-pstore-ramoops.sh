#!/bin/bash

source extract-paths.sh

LOG_FILE=/sys/fs/pstore/console-ramoops-0

adb shell stat $LOG_FILE
adb pull $LOG_FILE /tmp/full-kernel-trouble.txt

source write-kernel-trouble.sh

sudo pkill adb
