# PostmarketOS for Xiaomi Angelican (Redmi 9C NFC)

This port also might work on angelica (without NFC) and other phones on MT6765 processors (like Redmi 9A).
If you want to develop it together, or maybe you have a working port, please write me in discord/telegram: @meexreay. Also you can find more about me on my site: [meex.lol](https://meex.lol/about)

## Roadmap

- [x] Kernel compiling
- [x] Kernel booting
- [x] Debug shell
- [x] Framebuffer + boot logo
- [x] PMOS booting
- [x] SSH (use `ssh 172.16.41.1`)
- [ ] UI loading
- [ ] ...
 
## How to install

```bash
git clone https://github.com/MeexReay/pmos-xiaomi-angelican.git
cd pmos-xiaomi-angelican
source extract-paths.sh
ln -s $PWD/linux-xiaomi-angelican $PMAPORTS/device/testing
ln -s $PWD/device-xiaomi-angelican $PMAPORTS/device/testing
```

## How to flash

Firstly, you need to unlock bootloader [(See section below)](https://github.com/MeexReay/pmos-xiaomi-angelican?tab=readme-ov-file#how-to-unlock-bootloader). \
If you have already manipulated partitions, it is recommended to [flash MIUI back](https://github.com/MeexReay/pmos-xiaomi-angelican?tab=readme-ov-file#how-to-flash-stock-firmware), and flash PMOS above it.

### Flash with prebuilt images

Enter fastboot mode (hold vol- and pwr buttons while turned off), and run this command:

```bash
cd prebuild && ./flash.sh
```

Password: 1234
UI: surprise

### Flash manually

1. Build images

```bash
pmbootstrap init
pmbootstrap install
```

2. Disable VerifiedBoot and flash boot partition

Enter fastboot mode (hold vol- and pwr buttons while turned off), and run this commands:

```bash
fastboot flash vbmeta prebuilt/vbmeta_disabled.img
fastboot flash vbmeta_system prebuilt/vbmeta_disabled.img
fastboot flash vbmeta_vendor prebuilt/vbmeta_disabled.img
pmbootstrap flasher flash_dtbo
pmbootstrap flasher flash_kernel
```

3. Flash system

```bash
fastboot reboot fastboot # enter fastbootd mode
pmbootstrap flasher flash_rootfs # flash system
```

4. Reboot

```bash
fastboot reboot
```

## How to flash stock firmware

It is recommended to flash stock firmware before doing anything.

[Download Firmware](https://xmfirmwareupdater.com/miui/angelican/stable/V12.0.16.0.QCSMIXM/) (MIUI v12.0.16.0) and unpack it

### Windows

1. Download [MiFlashTool](https://cdn.alsgp0.fds.api.mi-img.com/micomm/MiFlash2020-3-14-0.rar)
2. Unpack firmware.tgz to some folder and copy its path
3. Launch MiFlash.exe and paste the path of firmware folder to that lonely input entry
4. Click refresh, then flash button
5. That's all, close the window

### Linux/MacOS

Install Windows and follow the guide above

TODO: Write how to do that on linux

## How to unlock bootloader

### Drivers

#### Windows

Install usb drivers:

- [https://mtkdriver.com/](mtkdriver.com)
- [https://github.com/daynix/usbdk/releases](usbdk)

#### Linux/MacOS

TODO: write about usb drivers, but they seem to be preinstalled

### Unlocking

```bash
git clone https://github.com/bkerler/mtkclient
cd mtkclient
pip -r install requirements.txt
git clone https://github.com/coloredmarble/redmi_9a_mtkclient
cp redmi_9a_mtkclient/* .
python mtk.py da seccfg unlock --preload preloader_k62v1_64_bsp.bin --loader n.bin
# power off the phone, hold vol+ and vol- at same time and connect usb cable
# i did it with test point, but it isnt required
```

## See also

- [xiaomi angelican wiki](https://wiki.postmarketos.org/wiki/Xiaomi_Redmi_9C_NFC_(xiaomi-angelican))
- [mtkclient](https://github.com/bkerler/mtkclient)
- [ubuntu touch installation](https://gist.github.com/sivinnguyen/a6f65c5af9198d40d396e11048512347)
- [booting troubleshooting](https://wiki.postmarketos.org/wiki/Troubleshooting_on-device_issues/Booting_problems)
- [coloredmarble/redmi_blossom](https://github.com/coloredmarble/redmi_blossom)
- [xiaomi angelica wiki](https://wiki.postmarketos.org/wiki/Xiaomi_Redmi_9C_(xiaomi-angelica))
- [xiaomi dandelion wiki](https://wiki.postmarketos.org/wiki/Xiaomi_Redmi_9A_(xiaomi-dandelion))

## Contributing

If you would like to contribute to the project, feel free to fork the repository and submit a pull request.
