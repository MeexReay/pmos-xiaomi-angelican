# PostmarketOS for Xiaomi Angelican (Redmi 9C NFC)

This port also might work on angelica (without NFC) and other phones on MT6765 processors.

## Roadmap

- [ ] Kernel loading
- [ ] SSH
- [ ] Screen

## How to add device to pmbootstrap

```bash
PMAPORTS=~/.local/var/pmbootstrap/cache_git/pmaports
git clone https://github.com/MeexReay/pmos-xiaomi-angelican.git /tmp/pmosxan
mv -r /tmp/pmosxan/linux-xiaomi-angelican $PMAPORTS/device/testing
mv -r /tmp/pmosxan/device-xiaomi-angelican $PMAPORTS/device/testing
rm -r /tmp/pmosxan
```

## How to flash

Firstly, you need to unlock bootloader (See section below).

Enter fastboot mode (hold vol- and pwr buttons while turned off), and run this commands:

```bash
pmbootstrap init # if you didnt init yet
pmbootstrap install # if you havent done that yet
pmbootstrap flasher flash_rootfs # connect usb cable AFTER running
pmbootstrap flasher flash_kernel # connect usb cable AFTER running
pmbootstrap chroot fastboot reboot # connect usb cable AFTER running
```

## How to unlock bootloader

### Drivers

#### Windows

Install usb drivers:

- [https://mtkdriver.com/](mtkdriver.com)
- [https://github.com/daynix/usbdk/releases](usbdk)

#### Linux

TODO: write about usb drivers, but they seem to be preinstalled

### Unlocking

```bash
git clone https://github.com/bkerler/mtkclient
cd mtkclient
pip -r install requirements.txt
git clone https://github.com/coloredmarble/redmi_9a_mtkclient
cp redmi_9a_mtkclient/* .
python mtk.py da seccfg unlock --preload preloader_k62v1_64_bsp.bin --loader n.bin
# power off phone, hold vol+ and vol- at same time and connect usb cable
# i did it with test point, but it isnt required
```

Found here: [coloredmarble/redmi_blossom](https://github.com/coloredmarble/redmi_blossom)

## See also

- [postmarketos wiki about xiaomi angelica](https://wiki.postmarketos.org/wiki/Xiaomi_Redmi_9C_(xiaomi-angelica))
- [postmarketos wiki about xiaomi dandelion](https://wiki.postmarketos.org/wiki/Xiaomi_Redmi_9A_(xiaomi-dandelion))

