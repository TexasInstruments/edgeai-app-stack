# Edge AI App Stack

Repository to assist Edge AI application development on PC by supporting
cross-compile Edge AI repos and installing them on target


# Getting Started

1. Clone the edgeai-app-stack on your PC

    `git clone https://github.com/TexasInstruments/edgeai-app-stack.git`

2. Get all the edge ai components using submodule init and update

    `git submodule init`

    `git submodule update`

3. Run setup script to install dependencies

    `./setup.sh`

4. Modify Makefile to set TARGETFS, SOC, INSTALL_PATH etc..

5. Build and Install the components

    `make`

    `make install`

6. Run `make help` to know the differnet make targets available


# Sync to latest updates

1. Use below git command to sync to latest develop branch

    `git submodule update --recursive --remote`

2. Get the diff in all submodules

    `git diff --submodule=diff`
