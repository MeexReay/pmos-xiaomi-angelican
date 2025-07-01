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

#### Install dependencies (Windows)

Install usb drivers:
  
- [https://mtkdriver.com/](mtkdriver.com)
- [https://github.com/daynix/usbdk/releases](usbdk)

#### Install dependencies (Linux/MacOS)
 
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

#### Prepare mtkclient

```bash
git clone https://github.com/bkerler/mtkclient
cd mtkclient
python -m venv .venv
source .venv/bin/activate
pip install -r requirements.txt
git clone https://github.com/coloredmarble/redmi_9a_mtkclient
cp redmi_9a_mtkclient/* .
```

#### Prepare mtkclient (NixOS)

```bash
git clone https://github.com/bkerler/mtkclient
cd mtkclient
git clone https://github.com/MeexReay/mtkclient-angelican
cp mtkclient-angelican/* .
nix-shell
```

#### Unlock

- Run this command:

```bash
python mtk.py da seccfg unlock --preload preloader_k62v1_64_bsp.bin --loader n.bin
```

- Power off the phone, hold `Volume Up` and `Volume Down` buttons at the same time and connect usb cable

### Backup full flash

To backup:

```bash
python mtk.py rf backup.bin --preload preloader_k62v1_64_bsp.bin --loader n.bin
```

To restore:

```bash
python mtk.py wf backup.bin --preload preloader_k62v1_64_bsp.bin --loader n.bin
```

### Flash stock firmware (Windows, fastboot)

It is recommended to flash stock firmware before doing anything.

[Download Firmware](https://xmfirmwareupdater.com/miui/angelican/stable/V12.0.16.0.QCSMIXM/) (MIUI v12.0.16.0) and unpack it

1. Download [MiFlashTool](https://cdn.alsgp0.fds.api.mi-img.com/micomm/MiFlash2020-3-14-0.rar)
2. Unpack firmware.tgz to some folder and copy its path
3. Launch MiFlash.exe and paste the path of firmware folder to that lonely input entry
4. Connect the phone in fastboot mode (not fastbootd)
5. Click refresh, then flash button

### Flash stock firmware (Linux/MacOS, fastboot)

It is recommended to flash stock firmware before doing anything.

[Download Firmware](https://xmfirmwareupdater.com/miui/angelican/stable/V12.0.16.0.QCSMIXM/) (MIUI v12.0.16.0) and unpack it

1. Open the firmware directory in console
2. Remove flashing your vbmeta and recovery partitions (optional):

```bash
sed -i '/flash vbmeta/d;/flash recovery/d' flash_all.sh
```

3. Connect the phone in fastboot mode (not fastbootd)
4. Run `./flash_all.sh`

### Flash stock firmware (Linux, mtkclient)

This guide can be helpful to unbrick the phone.

[Download firmware](https://xmfirmwareupdater.com/miui/angelican/stable/V12.0.16.0.QCSMIXM/) (MIUI v12.0.16.0) and unpack it.

1. Open the firmware directory in console:
2. Clone mtkclient stuff:

```bash
git clone https://github.com/bkerler/mtkclient
cp -r mtkclient/* .
git clone https://github.com/MeexReay/mtkclient-angelican
cp mtkclient-angelican/* .
```

3. Run `./flash_all_mtkclient.sh`
4. Power off the phone, hold `Volume Up` and `Volume Down` buttons and connect usb cable

### Disable vbmeta

Got the image from here: [ubuntu touch installation](https://gist.github.com/sivinnguyen/a6f65c5af9198d40d396e11048512347)

```bash
fastboot flash vbmeta vbmeta_disabled.img
fastboot flash vbmeta_system vbmeta_disabled.img
fastboot flash vbmeta_vendor vbmeta_disabled.img
```

### Flash recovery

It is strongly recommended to flash the recovery.

[Orangefox recovery page](https://orangefox.download/device/61f1325a775bca54ef3bf25f)
[Download recovery](https://dl.orangefox.download/62bb16c36a44bc738419d9bb)

Here is a simple script to download and flash it automatically (for linux):

```bash
cd /tmp
curl -o recovery.zip https://dl.orangefox.download/62bb16c36a44bc738419d9bb
unzip recovery.zip recovery.img
fastboot flash recovery recovery.img
rm recovery.zip recovery.img
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
pmbootstrap flasher flash_rootfs # flash rootfs to system
# in some cases its good to flash rootfs to userdata partition too:
# pmbootstrap flasher flash_rootfs --partition userdata
```

3. Reboot

> [!IMPORTANT]
> Always leave from fastboot with `fastboot reboot`

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
