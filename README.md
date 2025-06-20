# PostmarketOS for Xiaomi Angelican (Redmi 9C NFC)

This port also might work on angelica (without NFC) and other phones on MT6765 processors (like Redmi 9A).
If you want to develop it together, or maybe you have a working port, please write me in discord/telegram: [@meexreay](https://meexreay.t.me). 
Also you can find more about me on my site: [meex.lol](https://meex.lol/about)

## Roadmap

- [x] Kernel compiling
- [x] Kernel booting
- [x] Debug shell
- [x] Loading logo
- [x] PMOS starting
- [x] SSH (use `ssh 172.16.42.1`)
- [x] Display + Toucscreen (i3wm works) 
- [ ] Framebuffer and UI
 
## How to install

Run these commands to add the device to pmaports:

```bash
git clone https://github.com/MeexReay/pmos-xiaomi-angelican.git
cd pmos-xiaomi-angelican
source extract-paths.sh
ln -s $PWD/linux-xiaomi-angelican $PMAPORTS/device/testing
ln -s $PWD/device-xiaomi-angelican $PMAPORTS/device/testing
```

## How to prepare a phone

### Unlock bootloader

Here is described the unofficial method with mtkclient

#### Drivers

- **For Windows:**

Install usb drivers:

- [https://mtkdriver.com/](mtkdriver.com)
- [https://github.com/daynix/usbdk/releases](usbdk)

- **For Linux/MacOS:**

TODO: write about usb drivers, but they seem to be preinstalled

#### Unlocking

```bash
git clone https://github.com/bkerler/mtkclient
cd mtkclient
pip -r install requirements.txt
git clone https://github.com/coloredmarble/redmi_9a_mtkclient
cp redmi_9a_mtkclient/* .
python mtk.py da seccfg unlock --preload preloader_k62v1_64_bsp.bin --loader n.bin
# power off the phone, hold vol+ and vol- at same time and connect usb cable
# i did it with test point, but it isnt required at all
```

### Flash stock firmware

It is recommended to flash stock firmware before doing anything.

[Download Firmware](https://xmfirmwareupdater.com/miui/angelican/stable/V12.0.16.0.QCSMIXM/) (MIUI v12.0.16.0) and unpack it

- **For Windows:**

1. Download [MiFlashTool](https://cdn.alsgp0.fds.api.mi-img.com/micomm/MiFlash2020-3-14-0.rar)
2. Unpack firmware.tgz to some folder and copy its path
3. Launch MiFlash.exe and paste the path of firmware folder to that lonely input entry
4. Click refresh, then flash button
5. That's all, close the window

- **For Linux/MacOS:**

Install Windows and follow the guide above

TODO: Write how to do that on linux

### Disable vbmeta

```bash
fastboot flash vbmeta vbmeta_disabled.img
fastboot flash vbmeta_system vbmeta_disabled.img
fastboot flash vbmeta_vendor vbmeta_disabled.img
```

## How to flash

1. Build images

```bash
pmbootstrap init
pmbootstrap install
```

2. Flash partitions

Enter fastboot mode (hold vol- and pwr buttons while turned off), and run these commands:

```bash
pmbootstrap flasher flash_kernel # flash kernel to boot
fastboot reboot fastboot # enter fastbootd mode
pmbootstrap flasher flash_rootfs # flash rootfs to userdata
# in some cases its good to flash rootfs to system partition too:
# pmbootstrap flasher flash_rootfs --partition system
```

3. Reboot

```bash
fastboot reboot
```

## See also

- [xiaomi angelican wiki](https://wiki.postmarketos.org/wiki/Xiaomi_Redmi_9C_NFC_(xiaomi-angelican))
- [orangefox recovery](https://orangefox.download/device/61f1325a775bca54ef3bf25f)
- [mtkclient](https://github.com/bkerler/mtkclient)
- [ubuntu touch installation](https://gist.github.com/sivinnguyen/a6f65c5af9198d40d396e11048512347)
- [ubports community redmi 9c](https://gitlab.com/ubports/porting/community-ports/android10/xiaomi-redmi-9c)
- [mt6765 wiki](https://wiki.postmarketos.org/wiki/MediaTek_Helio_P35_(MT6765))
- [mtkclient redmi loader](https://github.com/coloredmarble/redmi_blossom)
- [working mt6765 port (lg-mmh4x)](https://wiki.postmarketos.org/wiki/LG_K40_AT%26T_(lg-mmh4x))
- [xiaomi angelica wiki](https://wiki.postmarketos.org/wiki/Xiaomi_Redmi_9C_(xiaomi-angelica))
- [xiaomi dandelion wiki](https://wiki.postmarketos.org/wiki/Xiaomi_Redmi_9A_(xiaomi-dandelion))
- [postmarket redmi 9a](https://github.com/SheatNoisette/postmarket_redmi_9a)
- [linux on redmi 9c/9a in telegram](https://t.me/linux_garden)
- [4pda topic about redmi 9c nfc](https://4pda.to/forum/index.php?showtopic=1012866)

## Contributing

If you would like to contribute to the project, feel free to fork the repository and submit a pull request.
