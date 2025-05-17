#!/bin/sh

NUM_LINES=100

if [ $# -ge 1 ]; then
  NUM_LINES="$1"
fi

./extract-paths.sh

pmbootstrap chroot adb pull /proc/last_kmsg /home/pmos

tail -n $NUM_LINES $PMWORK/chroot_native/home/pmos/last_kmsg > kernel-trouble

echo
echo " --- Kernel log (last $NUM_LINES lines) --- " 
echo

cat kernel-trouble

echo
echo " --- Writed to \"$PWD/kernel-trouble\" --- "
echo
