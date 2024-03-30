#!/bin/bash
clear
export ARCH=arm64
export PLATFORM_VERSION=12
export ANDROID_MAJOR_VERSION=s
ln -s /usr/bin/python2.7 $HOME/python
export PATH=$HOME/:$PATH

ARGS='
CC=/workspace/gitpod/M317F_KSU/clang/bin/clang
CROSS_COMPILE=aarch64-linux-android-4.9/bin/aarch64-linux-android-
CLANG_TRIPLE=aarch64-linux-gnu-
ARCH=arm64
'

make ${ARGS} clean && make ${ARGS} mrproper #to clean the source
make ${ARGS} exynos9610-m31snsxx_defconfig #making your current kernel config
make ${ARGS} menuconfig #editing the kernel config via gui
make ${ARGS} -j$(nproc) #to compile the kernel

#to copy all the kernel modules (.ko) to "modules" folder.
mkdir -p modules
find . -type f -name "*.ko" -exec cp -n {} modules \;
echo "Module files copied to the 'modules' folder."