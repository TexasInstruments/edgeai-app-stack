#!/bin/bash

sudo apt update
apt install cmake ninja-build
pip3 install meson

if [ ! -d gcc-arm-9.2-2019.12-x86_64-aarch64-none-linux-gnu ]; then
    wget https://developer.arm.com/-/media/Files/downloads/gnu-a/9.2-2019.12/binrel/gcc-arm-9.2-2019.12-x86_64-aarch64-none-linux-gnu.tar.xz --no-check-certificate
    tar xf gcc-arm-9.2-2019.12-x86_64-aarch64-none-linux-gnu.tar.xz > /dev/null
    rm gcc-arm-9.2-2019.12-x86_64-aarch64-none-linux-gnu.tar.xz
fi
