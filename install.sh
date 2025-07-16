#!/bin/bash

. extract-paths.sh

mkdir -p $PMAPORTS/device/testing/linux-xiaomi-angelican
mkdir -p $PMAPORTS/device/testing/device-xiaomi-angelican
sudo mount --bind $PWD/linux-xiaomi-angelican $PMAPORTS/device/testing/linux-xiaomi-angelican
sudo mount --bind $PWD/device-xiaomi-angelican $PMAPORTS/device/testing/device-xiaomi-angelican
