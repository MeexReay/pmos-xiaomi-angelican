# PostmarketOS для Xiaomi Angelican (Redmi 9C NFC)

[![en](https://img.shields.io/badge/lang-en-red.svg)](README.md)
[![ru](https://img.shields.io/badge/lang-ru-green.svg)](README.ru.md)

Этот порт также может работать на angelica (без NFC) и других телефонах на MT6765 процессорах.

## План

- [x] Компиляция кернеля
- [ ] Загрузка кернеля (см. issues)
- [ ] SSH
- [ ] Экран

## Как установить

```bash
git clone https://github.com/MeexReay/pmos-xiaomi-angelican.git
cd pmos-xiaomi-angelican
source extract-paths.sh
ln -s $PWD/linux-xiaomi-angelican $PMAPORTS/device/testing
ln -s $PWD/device-xiaomi-angelican $PMAPORTS/device/testing
```

## Как записать

Для начала, тебе нужно разблокировать бутлоадер (Смотреть секцию ниже).

Зайди в режим фастбута (зажми кнопку уменьшения громкости и кнопку выключения, пока телефон выключен), и введи эти команды:

```bash
pmbootstrap init # если ты еще не инициализировался
pmbootstrap install # если ты еще не сделал это
pmbootstrap flasher flash_rootfs # подключи кабель ПОСЛЕ ввода
pmbootstrap flasher flash_kernel # подключи кабель ПОСЛЕ ввода
pmbootstrap chroot fastboot reboot # подключи кабель ПОСЛЕ ввода
```

## Как разблокировать бутлоадер

### Драйвера

#### Windows

Установи usb драйвера:

- [https://mtkdriver.com/](mtkdriver.com)
- [https://github.com/daynix/usbdk/releases](usbdk)

#### Linux

TODO: написать о usb драйверах, но они походу преустановлены

### Разблокировка

```bash
git clone https://github.com/bkerler/mtkclient
cd mtkclient
pip -r install requirements.txt
git clone https://github.com/coloredmarble/redmi_9a_mtkclient
cp redmi_9a_mtkclient/* .
python mtk.py da seccfg unlock --preload preloader_k62v1_64_bsp.bin --loader n.bin
# выключи телефон, зажми обе кнопки громкости и подключи кабель usb
# я делал это через тест поинт, но это не обязательно
```

## Смотреть также

- [xiaomi angelican wiki](https://wiki.postmarketos.org/wiki/Xiaomi_Redmi_9C_NFC_(xiaomi-angelican))
- [mtkclient](https://github.com/bkerler/mtkclient)
- [ubuntu touch installation](https://gist.github.com/sivinnguyen/a6f65c5af9198d40d396e11048512347)
- [booting troubleshooting](https://wiki.postmarketos.org/wiki/Troubleshooting_on-device_issues/Booting_problems)
- [coloredmarble/redmi_blossom](https://github.com/coloredmarble/redmi_blossom)
- [xiaomi angelica wiki](https://wiki.postmarketos.org/wiki/Xiaomi_Redmi_9C_(xiaomi-angelica))
- [xiaomi dandelion wiki](https://wiki.postmarketos.org/wiki/Xiaomi_Redmi_9A_(xiaomi-dandelion))

## Контакты

Если вы хотите разрабатывать вместе, или у вас есть рабочий порт, пожалуйста, напишите мне в дискорд: @meexreay. Также вы можете найти больше обо мне на моем сайте: [meex.lol](https://meex.lol/about)

## Содействие

Если вы хотите помочь проекту, не стесняйтесь сделать форк репозитория и отправить пулл реквест.
