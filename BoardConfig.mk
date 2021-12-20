#
# Copyright (C) 2022 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

# Inherit from mainline-common
include device/linux/mainline-common/BoardConfigCommon.mk

DEVICE_PATH := device/linux/pc_x86_64

BUILD_BROKEN_ELF_PREBUILT_PRODUCT_COPY_FILES := true

# Architecture
TARGET_ARCH := x86_64
TARGET_ARCH_VARIANT := x86_64
TARGET_CPU_ABI := x86_64
TARGET_CPU_VARIANT := generic

TARGET_2ND_ARCH := x86
TARGET_2ND_ARCH_VARIANT := x86_64
TARGET_2ND_CPU_ABI := x86
TARGET_2ND_CPU_VARIANT := generic

# Display
TARGET_SCREEN_DENSITY := 240

# Kernel
BOARD_KERNEL_BASE := 0x00000000
BOARD_KERNEL_CMDLINE += initrd=initramfs.img root=/dev/ram rw
BOARD_KERNEL_CMDLINE += fbcon=map:2
BOARD_KERNEL_CMDLINE += androidboot.hardware=mainline
BOARD_KERNEL_CMDLINE += loop.max_part=7
BOARD_KERNEL_CMDLINE += androidboot.boot_devices=soc/f9824900.sdhci
BOARD_KERNEL_CMDLINE += androidboot.init_fatal_reboot_target=recovery
BOARD_KERNEL_CMDLINE += androidboot.selinux=permissive
BOARD_KERNEL_IMAGE_NAME := Image
BOARD_KERNEL_PAGESIZE := 4096
TARGET_KERNEL_ARCH := x86_64
TARGET_KERNEL_SOURCE := kernel/google/android-mainline
TARGET_KERNEL_CONFIG := gki_defconfig
-include device/linux/pc_x86_64-kernel/BoardConfigKernel.mk

# Partitions
BOARD_FLASH_BLOCK_SIZE := 262144 # (BOARD_KERNEL_PAGESIZE * 64)
BOARD_BOOTIMAGE_PARTITION_SIZE := 512753664
BOARD_RECOVERYIMAGE_PARTITION_SIZE := 512753664
BOARD_CACHEIMAGE_PARTITION_SIZE := 300941312
BOARD_CACHEIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_USERDATAIMAGE_PARTITION_SIZE := 5209325568

# Partitions - legacy
BOARD_SYSTEMIMAGE_PARTITION_SIZE := 4000317440
BOARD_VENDORIMAGE_PARTITION_SIZE := 1983905792

PARTITION_LIST := system vendor

$(foreach p, $(call to-upper, $(PARTITION_LIST)), \
    $(eval BOARD_$(p)IMAGE_FILE_SYSTEM_TYPE := ext4) \
    $(eval TARGET_COPY_OUT_$(p) := $(call to-lower, $(p))))

# Recovery
TARGET_RECOVERY_FSTAB := $(DEVICE_PATH)/rootdir/etc/fstab.mainline
TARGET_RECOVERY_PIXEL_FORMAT := BGRA_8888
