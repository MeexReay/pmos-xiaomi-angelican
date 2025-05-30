#!/bin/bash

fastboot flash vbmeta vbmeta_disabled.img
fastboot flash vbmeta_system vbmeta_disabled.img
fastboot flash vbmeta_vendor vbmeta_disabled.img
fastboot flash dtbo dtbo.img
fastboot flash boot boot.img # kernel

fastboot reboot fastboot # fastbootd mode
# fastboot delete-logical-partition product
fastboot flash userdata system.img # rootfs
fastboot reboot
