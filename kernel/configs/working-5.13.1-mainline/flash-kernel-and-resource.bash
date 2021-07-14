#!/bin/bash
#
[[ -z "${RESOURCE_IMG}" ]] && echo "Please set environment variable RESOURCE_IMG to be the filename of the image to flash" && exit 1
[[ -z "${KERNEL_IMG}" ]] && echo "Please set environment variable KERNEL to be the filename of the image to flash" && exit 2

FLASH_DEST="${FLASH_DEST:-}"
[[ -e /dev/mmcblk0 && -e /dev/mmcblk0p6 ]] && echo "Detected SDCard at /dev/mmcblk0" && FLASH_DEST=/dev/mmcblk0

[[ -z "${FLASH_DEST}" ]] && echo "Unsure what target device to flash. Please set FLASH_DEST to be the SDCard to flash" && exit 3

echo "resource: ${RESOURCE_IMG}"
echo "kernel: ${KERNEL_IMG}"
echo "target sdcard: ${FLASH_DEST}"
echo "Waiting 20 seconds... You can CTRL+C if we got something wrong. After that we flash"
sleep 20

echo For safety I am changing these to echo commands - you will need to run them yourself if you trust them.
echo sudo dd if="${RESOURCE_IMG}" of="${FLASH_DEST}" seek=32768 conv=notrunc,fsync
echo sudo dd if="${KERNEL_IMG}" of="${FLASH_DEST}" seek=65536 conv=notrunc,fsync
