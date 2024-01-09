#!/bin/bash

sudo apt update
apt install cmake ninja-build
pip3 install meson

if [ ! -d arm-gnu-toolchain-11.3.rel1-x86_64-aarch64-none-linux-gnu ]; then
    wget https://developer.arm.com/-/media/Files/downloads/gnu/11.3.rel1/binrel/arm-gnu-toolchain-11.3.rel1-x86_64-aarch64-none-linux-gnu.tar.xz --no-check-certificate
    tar xf arm-gnu-toolchain-11.3.rel1-x86_64-aarch64-none-linux-gnu.tar.xz > /dev/null
    rm arm-gnu-toolchain-11.3.rel1-x86_64-aarch64-none-linux-gnu.tar.xz
fi

if [ ! -d targetfs ]; then
    wget https://dr-download.ti.com/software-development/software-development-kit-sdk/MD-Snl3iJzGTW/09.01.00.06/tisdk-adas-image-j721s2-evm.tar.xz
    mkdir targetfs
    cd targetfs
    tar xf ../tisdk-adas-image-j721s2-evm.tar.xz > /dev/null
    cd -
    rm tisdk-adas-image-j721s2-evm.tar.xz
fi
