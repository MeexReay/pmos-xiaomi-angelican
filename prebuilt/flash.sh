#!/bin/bash

fastboot flash vbmeta vbmeta_disabled.img
fastboot flash vbmeta_system vbmeta_disabled.img
fastboot flash vbmeta_vendor vbmeta_disabled.img
fastboot flash boot boot.img
fastboot flash dtbo dtbo.img

fastboot reboot fastboot # fastbootd mode
fastboot delete-logical-partition product
fastboot flash system system.img
fastboot reboot
