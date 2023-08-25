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

4. Connect the SD card that is flashed with EdgeAI WIC Image. By default
   TargetFS and Install Path is set as $(PWD)/targetfs

5. Modify Makefile to set TARGETFS, SOC, INSTALL_PATH etc..

6. Build and Install the components

    `make`

    `make install`

7. Run `make help` to know the differnet make targets available


# Sync to latest updates

1. Use below git command to sync to latest develop branch

    `git submodule update --recursive --remote`

2. Get the diff in all submodules

    `git diff --submodule=diff`

![Edge AI application stack](edgeai-app-stack.jpg)

Edge AI app stack is validated on below devices, for more information please refer to the user guide links below

Device | Release Version | Link
--- | --- | ---
AM62A | 09.00.00 | [Processor SDK Linux for AM62Ax](https://software-dl.ti.com/jacinto7/esd/processor-sdk-linux-edgeai/AM62AX/09_00_00/exports/edgeai_docs/common/sdk_components.html#edge-ai-application-stack)
AM68A | 09.00.00 | [Processor SDK Linux for AM68A](https://software-dl.ti.com/jacinto7/esd/processor-sdk-linux-edgeai/AM68A/09_00_00/exports/edgeai_docs/common/sdk_components.html#edge-ai-application-stack)
AM69A | 09.00.00 | [Processor SDK Linux for AM69A](https://software-dl.ti.com/jacinto7/esd/processor-sdk-linux-edgeai/AM69A/09_00_00/exports/edgeai_docs/common/sdk_components.html#edge-ai-application-stack)
TDA4VM-SK | 09.00.00 | [Processor SDK Linux for SK-TDA4VM](https://software-dl.ti.com/jacinto7/esd/processor-sdk-linux-edgeai/TDA4VM/09_00_00/exports/edgeai_docs/common/sdk_components.html#edge-ai-application-stack)
