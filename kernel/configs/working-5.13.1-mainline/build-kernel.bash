#!/bin/bash
#
if [[ ! -e ./.config ]]; then
  echo -n "No .config found... "
  if [[ -e /proc/config.gz ]]; then
    echo "but I found a /proc/config.gz."
    echo "About to copy /proc/config.gz and make a .config..."
    echo "You have three (3) seconds to abort this."
    sleep 3 
    cp /proc/config.gz .
    gunzip config.gz
    mv config .config
  else
    echo "Please create a .config"
    exit 1
  fi
fi

[[ ! -e "../firefly-rk3399-dts/rk3399-firefly.dts" ]] && echo "../firefly-rk3399-dts/rk3399-firefly.dts must exist." && exit 2
[[ ! -e "../newresourceimg/logo.bmp" ]] && echo "Missing logo.bmp from ../newresourceimg/. Aborting." && exit 5

echo "Got segfault likely due to no RAM on the make -j2 when doing final linking of vmlinux"
echo "Attempting to turn on swap for file /data/swap.fs"
sudo swapon /data/swap.fs
sleep 2

make oldconfig
[[ ! -d build-modules ]] && mkdir build-modules
cp -vLf "../firefly-rk3399-dts/rk3399-firefly.dts" ./arch/arm64/boot/dts/rockchip/
fast make -j2 all && make INSTALL_MOD_PATH=build-modules INSTALL_MOD_STRIP=1 modules_install
if [[ $? -eq 0 ]]; then
  echo Copying build-modules/lib/modules/* to /lib/modules. SUDO required.
  sudo rsync -av build-modules/lib/modules/* /lib/modules/
fi
echo "Attempting to make rockchip kernel image..."
[[ ! -e "arch/arm64/boot/Image" ]] && echo "Missing kernel image from arch/arm64/boot/Image. Aborting." && exit 3
qemu-x86_64 -L /usr/local/lib/x86_64-libs /home/msaun/git/rkbin/tools/mkkrnlimg arch/arm64/boot/Image kernel-$(date +%F).img

echo "Attempting to make rockchip resource image..."
[[ ! -e "arch/arm64/boot/dts/rockchip/rk3399-firefly.dtb" ]] && echo "Missing DTB arch/arm64/boot/dts/rockchip/rk3399-firefly.dtb. Aborting." && exit 4
mkdir resource
cp arch/arm64/boot/dts/rockchip/rk3399-firefly.dtb resource/rk-kernel.dtb
cp ../newresourceimg/logo.bmp resource/
qemu-i386 -L /usr/local/lib/x86_64-libs /home/msaun/git/rkbin/tools/resource_tool --pack --image=./resource-$(date +%F).img resource/*
echo "If all was built successfully you can try:"
echo "RESOURCE_IMG=resource-$(date +%F).img KERNEL_IMG=kernel-$(date +%F).img ../flash-kernel-and-resource.bash"
