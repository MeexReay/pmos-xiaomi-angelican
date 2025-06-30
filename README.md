# PostmarketOS for Xiaomi Angelican (Redmi 9C NFC)

This port also might work on angelica (without NFC) and other phones on MT6765 processors (like Redmi 9A).

## Roadmap

- [x] Kernel compiling
- [x] Kernel booting
- [x] Debug shell
- [x] Framebuffer + boot logo
- [x] PMOS booting
- [x] SSH (use `ssh 172.16.42.1`)
- [x] Display + Toucscreen (i3wm works) 
- [ ] Built-in llvmpipe
 
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

#### Dependencies

- **For Windows:**

Install usb drivers:

- [https://mtkdriver.com/](mtkdriver.com)
- [https://github.com/daynix/usbdk/releases](usbdk)

- **For Linux/MacOS:**

Install libraries:

- libusb / libusb1
- fuse2 / libfuse2

Install rules:

```bash
git clone https://github.com/bkerler/mtkclient
cd mtkclient
sudo usermod -a -G plugdev $USER
sudo usermod -a -G dialout $USER
sudo cp mtkclient/Setup/Linux/*.rules /etc/udev/rules.d
sudo udevadm control -R
sudo udevadm trigger
```

Then reboot.

#### Unlocking

- Run these commands:

```bash
git clone https://github.com/bkerler/mtkclient
cd mtkclient
python -m venv .venv
source .venv/bin/activate
pip install -r requirements.txt
git clone https://github.com/coloredmarble/redmi_9a_mtkclient
cp redmi_9a_mtkclient/* .
python mtk.py da seccfg unlock --preload preloader_k62v1_64_bsp.bin --loader n.bin
```

**For NixOS:**

```bash
git clone https://github.com/bkerler/mtkclient; cd mtkclient
git clone https://github.com/MeexReay/mtkclient-angelican; cp mtkclient-angelican/* .
nix-shell --command "python mtk.py da seccfg unlock --preload preloader_k62v1_64_bsp.bin --loader n.bin"
```

- Power off the phone, hold vol+ and vol- at same time and connect usb cable

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

### Flash the recovery

[Orangefox recovery page](https://orangefox.download/device/61f1325a775bca54ef3bf25f)

```bash
curl -o recovery.zip https://dl.orangefox.download/62bb16c36a44bc738419d9bb
unzip recovery.zip recovery.img
fastboot flash recovery recovery.img
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
- [booting troubleshooting](https://wiki.postmarketos.org/wiki/Troubleshooting_on-device_issues/Booting_problems)
- [coloredmarble/redmi_blossom](https://github.com/coloredmarble/redmi_blossom)
- [xiaomi angelica wiki](https://wiki.postmarketos.org/wiki/Xiaomi_Redmi_9C_(xiaomi-angelica))
- [xiaomi dandelion wiki](https://wiki.postmarketos.org/wiki/Xiaomi_Redmi_9A_(xiaomi-dandelion))

## Contributing

If you would like to contribute to the project, feel free to fork the repository and submit a pull request.
