#!/bin/bash
#
[[ -e /dev/mmcblk0 ]] && echo using mmcblk0 || echo using sdb
[[ -e /dev/mmcblk0 ]] && DEV=/dev/mmcblk0 || DEV=/dev/sdb

[[ -z "$DEV" ]] && echo no device found && exit 1
[[ ! -e "kill-params-force-rockusb" ]] && echo no param file found && exit 2

sleep 3

sudo dd if=kill-params-force-rockusb of=$DEV seek=8192 conv=notrunc,fsync

sudo sync
sudo blockdev --flushbufs $DEV
sudo sync

sudo eject $DEV

echo done. $DEV ready to eject
