#!/bin/bash

. extract-paths.sh


rm -rf $PMAPORTS/device/testing/linux-xiaomi-angelican
rm -rf $PMAPORTS/device/testing/device-xiaomi-angelican
ln -s $PWD/linux-xiaomi-angelican $PMAPORTS/device/testing
ln -s $PWD/device-xiaomi-angelican $PMAPORTS/device/testing
