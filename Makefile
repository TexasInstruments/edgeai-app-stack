#
# Makefile to build edgeai components
#

DL_INFERER_PATH        = edgeai-dl-inferer/
TIOVX_KERNELS_PATH     = edgeai-tiovx-kernels/
TIOVX_MODULES_PATH     = edgeai-tiovx-modules/
GST_PLUGINS_PATH       = edgeai-gst-plugins/
GST_APPS_PATH          = edgeai-gst-apps/
CROSS_COMPILER_PATH    = $(shell pwd)/gcc-arm-9.2-2019.12-x86_64-aarch64-none-linux-gnu/
CROSS_COMPILER_PREFIX  = aarch64-none-linux-gnu-
TARGET_FS              = /media/$(USER)/rootfs/
INSTALL_PATH           = /media/$(USER)/rootfs/
SOC                   ?= none

MAKE                   = make -j$(shell nproc)

export CROSS_COMPILER_PATH
export CROSS_COMPILER_PREFIX
export TARGET_FS
export SOC

all: check_paths gst_apps

install: dl_inferer_install tiovx_kernels_install tiovx_modules_install gst_plugins_install gst_apps_install

clean: dl_inferer_clean tiovx_kernels_clean tiovx_modules_clean gst_plugins_clean gst_apps_clean

check_paths:
	@if [ ! -d $(DL_INFERER_PATH)     ]; then echo 'ERROR: $(DL_INFERER_PATH)     not found !!!'; exit 1; fi
	@if [ ! -d $(TIOVX_KERNELS_PATH)  ]; then echo 'ERROR: $(TIOVX_KERNELS_PATH)  not found !!!'; exit 1; fi
	@if [ ! -d $(TIOVX_MODULES_PATH)  ]; then echo 'ERROR: $(TIOVX_MODULES_PATH)  not found !!!'; exit 1; fi
	@if [ ! -d $(GST_PLUGINS_PATH)    ]; then echo 'ERROR: $(GST_PLUGINS_PATH)    not found !!!'; exit 1; fi
	@if [ ! -d $(GST_APPS_PATH)       ]; then echo 'ERROR: $(GST_APPS_PATH)       not found !!!'; exit 1; fi
	@if [ ! -d $(TARGET_FS)           ]; then echo 'ERROR: $(TARGET_FS)           not found !!!'; exit 1; fi
	@if [ ! -d $(INSTALL_PATH)        ]; then echo 'ERROR: $(INSTALL_PATH)        not found !!!'; exit 1; fi
	@if [ ! -d $(CROSS_COMPILER_PATH) ]; then echo 'ERROR: $(CROSS_COMPILER_PATH) not found !!!'; exit 1; fi
ifneq ("$(SOC)","$(filter $(SOC),j721e j721s2 j784s4 am62a)")
	@echo 'ERROR: SOC: "$(SOC)" is not supported !!!';
	@exit 1
endif

help:
	@echo "Below are targets available"
	@echo ""
	@echo "--COMPONENT--         - to build the component"
	@echo "--COMPONENT--_install - to install the component"
	@echo "--COMPONENT--_clean   - to clean the component"
	@echo ""
	@echo "Below are list fo components"
	@echo "    dl_inferer"
	@echo "    tiovx_kernels"
	@echo "    tiovx_modules"
	@echo "    gst_plugins"
	@echo "    gst_apps"

########################### EDGEAI-DL-INFERER ##################################

dl_inferer:
	@echo "Building DL Inferer"
	cd $(DL_INFERER_PATH); \
	mkdir build; \
	cd build; \
	cmake -DCMAKE_TOOLCHAIN_FILE=../cmake/cross_compile_aarch64.cmake ..; \
	$(MAKE)

dl_inferer_install: dl_inferer
	@echo "Install DL Inferer"
	cd $(DL_INFERER_PATH); \
	sudo $(MAKE) install DESTDIR=$(INSTALL_PATH) -C build

dl_inferer_clean:
	@echo "Clean DL Inferer"
	cd $(DL_INFERER_PATH); \
	rm -rf build bin lib

########################### EDGEAI-TIOVX-KERNELS ###############################

tiovx_kernels:
	@echo "Building TIOVX Kernels"
	cd $(TIOVX_KERNELS_PATH); \
	mkdir build; \
	cd build; \
	cmake -DCMAKE_TOOLCHAIN_FILE=../cmake/cross_compile_aarch64.cmake ..; \
	$(MAKE)

tiovx_kernels_install: tiovx_kernels
	@echo "Install TIOVX Kernels"
	cd $(TIOVX_KERNELS_PATH); \
	sudo $(MAKE) install DESTDIR=$(INSTALL_PATH) -C build

tiovx_kernels_clean:
	@echo "Clean TIOVX Kernels"
	cd $(TIOVX_KERNELS_PATH); \
	rm -rf build bin lib

########################### EDGEAI-TIOVX-MODULES ###############################

tiovx_modules: tiovx_kernels
	@echo "Building TIOVX Modules"
	cd $(TIOVX_MODULES_PATH); \
	mkdir build; \
	cd build; \
	cmake -DCMAKE_TOOLCHAIN_FILE=../cmake/cross_compile_aarch64.cmake ..; \
	$(MAKE)

tiovx_modules_install: tiovx_modules
	@echo "Install TIOVX Modules"
	cd $(TIOVX_MODULES_PATH); \
	sudo $(MAKE) install DESTDIR=$(INSTALL_PATH) -C build

tiovx_modules_clean:
	@echo "Clean TIOVX Modules"
	cd $(TIOVX_MODULES_PATH); \
	rm -rf build bin lib

########################### EDGEAI-GST-PLUGINS #################################

gst_plugins: tiovx_modules dl_inferer
	@echo "Building GST Plugins"
	cd $(GST_PLUGINS_PATH); \
	echo [constants] > aarch64-none-linux-gnu.ini; \
	echo "" >> aarch64-none-linux-gnu.ini; \
	echo TOOLCHAIN = \'$(CROSS_COMPILER_PATH)/bin/$(CROSS_COMPILER_PREFIX)\' >> aarch64-none-linux-gnu.ini; \
	echo SYSROOT = \'$(TARGET_FS)\' >> aarch64-none-linux-gnu.ini; \
	echo PKG_CONFIG_LIBDIR = \'$(TARGET_FS)/usr/lib/pkgconfig:$(shell pwd)/$(GST_PLUGINS_PATH)/pkgconfig\' >> aarch64-none-linux-gnu.ini; \
	echo SYSTEM = \'linux-gnu\' >> aarch64-none-linux-gnu.ini; \
	echo CPU_FAMILY = \'aarch64\' >> aarch64-none-linux-gnu.ini; \
	echo CPU = \'aarch64-none\' >> aarch64-none-linux-gnu.ini; \
	echo ENDIAN = \'little\' >> aarch64-none-linux-gnu.ini; \
	echo PREFIX = \'/usr\' >> aarch64-none-linux-gnu.ini; \
	echo LIBDIR = \'/usr/lib\' >> aarch64-none-linux-gnu.ini; \
	PKG_CONFIG_PATH='' meson build --cross-file aarch64-none-linux-gnu.ini --cross-file crossbuild/crosscompile.ini; \
	DESTDIR=$(TARGET_FS) ninja -C build

gst_plugins_install: gst_plugins
	@echo "Install Gst Plugins"
	cd $(GST_PLUGINS_PATH); \
	sudo DESTDIR=$(INSTALL_PATH) ninja -C build install

gst_plugins_clean:
	@echo "Clean Gst Plugins"
	cd $(GST_PLUGINS_PATH); \
	rm -rf build

########################### EDGEAI-TIOVX-MODULES ###############################

gst_apps: dl_inferer gst_plugins
	@echo "Building Gst Apps"
	cd $(GST_APPS_PATH)/apps_cpp; \
	mkdir build; \
	cd build; \
	cmake -DCMAKE_TOOLCHAIN_FILE=../cmake/cross_compile_aarch64.cmake ..; \
	$(MAKE)

gst_apps_install: gst_apps
	@echo "Install Gst Apps"
	sudo mkdir -p $(INSTALL_PATH)/opt/edgeai-gst-apps-pc
	sudo cp -r $(GST_APPS_PATH)/* $(INSTALL_PATH)/opt/edgeai-gst-apps-pc/

gst_apps_clean:
	@echo "Clean Gst Apps"
	cd $(GST_APPS_PATH)/apps_cpp; \
	rm -rf build bin lib

################################################################################
