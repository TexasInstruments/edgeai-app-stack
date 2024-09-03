#!/bin/bash

sudo apt update
apt install cmake ninja-build meson

if [ ! -d arm-gnu-toolchain-13.2.Rel1-x86_64-aarch64-none-linux-gnu ]; then
    wget https://developer.arm.com/-/media/Files/downloads/gnu/13.2.rel1/binrel/arm-gnu-toolchain-13.2.rel1-x86_64-aarch64-none-linux-gnu.tar.xz --no-check-certificate
    tar xf arm-gnu-toolchain-13.2.rel1-x86_64-aarch64-none-linux-gnu.tar.xz > /dev/null
    rm arm-gnu-toolchain-13.2.rel1-x86_64-aarch64-none-linux-gnu.tar.xz
fi

if [ ! -d targetfs ]; then
    if [ "$1" == "j721e" ]; then
        wget https://dr-download.ti.com/software-development/software-development-kit-sdk/MD-U6uMjOroyO/10.00.00.08/tisdk-adas-image-j721e-evm.tar.xz
        mv tisdk-adas-image-j721e-evm.tar.xz targetfs.tar.xz
    elif [ "$1" == "j721s2" ]; then
        wget https://dr-download.ti.com/software-development/software-development-kit-sdk/MD-Snl3iJzGTW/10.00.00.08/tisdk-adas-image-j721s2-evm.tar.xz
        mv tisdk-adas-image-j721s2-evm.tar.xz targetfs.tar.xz
    elif [ "$1" == "j784s4" ]; then
        wget https://dr-download.ti.com/software-development/software-development-kit-sdk/MD-lOshtRwR8P/10.00.00.08/tisdk-adas-image-j784s4-evm.tar.xz
        mv tisdk-adas-image-j784s4-evm.tar.xz targetfs.tar.xz
    elif [ "$1" == "j722s" ]; then
        wget https://dr-download.ti.com/software-development/software-development-kit-sdk/MD-R9W8pVWsOt/10.00.00.08/tisdk-adas-image-j722s-evm.tar.xz
        mv tisdk-adas-image-j722s-evm.tar.xz targetfs.tar.xz
    elif [ "$1" == "am62a" ]; then
        wget https://dr-download.ti.com/software-development/software-development-kit-sdk/MD-D37Ls3JjkT/10.00.00.08/tisdk-edgeai-image-am62axx-evm.wic.xz
        mv tisdk-edgeai-image-am62axx-evm.tar.xz targetfs.tar.xz
    else
        wget https://dr-download.ti.com/software-development/software-development-kit-sdk/MD-Snl3iJzGTW/10.00.00.08/tisdk-adas-image-j721s2-evm.tar.xz
        mv tisdk-adas-image-j721s2-evm.tar.xz targetfs.tar.xz
    fi
    mkdir targetfs
    cd targetfs
    tar xf ../targetfs.tar.xz > /dev/null
    cd -
    rm targetfs.tar.xz
fi
