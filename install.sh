#!/bin/bash

source extract-paths.sh
source uninstall.sh

ln -s $PWD/linux-xiaomi-angelican $PMAPORTS/device/testing
ln -s $PWD/device-xiaomi-angelican $PMAPORTS/device/testing
