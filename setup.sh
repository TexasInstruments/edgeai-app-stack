#!/bin/bash

sudo apt update
apt install cmake ninja-build
pip3 install meson

if [ ! -d arm-gnu-toolchain-11.3.rel1-x86_64-aarch64-none-linux-gnu ]; then
    wget https://developer.arm.com/-/media/Files/downloads/gnu/11.3.rel1/binrel/arm-gnu-toolchain-11.3.rel1-x86_64-aarch64-none-linux-gnu.tar.xz --no-check-certificate
    tar xf arm-gnu-toolchain-11.3.rel1-x86_64-aarch64-none-linux-gnu.tar.xz > /dev/null
    rm arm-gnu-toolchain-11.3.rel1-x86_64-aarch64-none-linux-gnu.tar.xz
fi
