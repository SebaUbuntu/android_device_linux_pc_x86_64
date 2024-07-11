#
# Copyright (C) 2024 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

# Inherit from mainline-common
include device/linux/mainline-common/BoardConfigCommon.mk

DEVICE_PATH := device/linux/pc_x86_64

# Architecture
TARGET_ARCH := x86_64
TARGET_ARCH_VARIANT := x86_64
TARGET_CPU_ABI := x86_64
TARGET_CPU_ABI2 :=
TARGET_CPU_VARIANT_RUNTIME := generic

TARGET_2ND_ARCH := x86
TARGET_2ND_ARCH_VARIANT := x86_64
TARGET_2ND_CPU_ABI := x86
TARGET_2ND_CPU_ABI2 :=
TARGET_2ND_CPU_VARIANT_RUNTIME := generic

# Kernel
BOARD_KERNEL_BASE := 0x00000000
BOARD_KERNEL_PAGESIZE := 4096
BOARD_KERNEL_CMDLINE := fbcon=map:2
BOARD_KERNEL_CMDLINE += loop.max_part=7
BOARD_KERNEL_CMDLINE += androidboot.hardware=mainline
BOARD_KERNEL_CMDLINE += androidboot.boot_devices=any
BOARD_KERNEL_CMDLINE += androidboot.init_fatal_reboot_target=recovery
BOARD_KERNEL_CMDLINE += androidboot.first_stage_console=2
BOARD_KERNEL_CMDLINE += androidboot.console=tty0
BOARD_KERNEL_CMDLINE += androidboot.selinux=permissive
BOARD_KERNEL_IMAGE_NAME := bzImage
BOARD_USES_GENERIC_KERNEL_IMAGE := true
TARGET_KERNEL_SOURCE := kernel/google/android14-5.15
TARGET_KERNEL_CONFIG := \
    gki_defconfig \
    pc.config

# Kernel modules
BOARD_SYSTEM_KERNEL_MODULES_LOAD := $(strip $(shell cat $(DEVICE_PATH)/modprobe/modules.load.system_dlkm))
#BOARD_VENDOR_KERNEL_MODULES_LOAD := $(strip $(shell cat $(DEVICE_PATH)/modprobe/modules.load.vendor_dlkm))
BOARD_VENDOR_RAMDISK_KERNEL_MODULES_LOAD := $(strip $(shell cat $(DEVICE_PATH)/modprobe/modules.load.vendor_dlkm))
BOARD_VENDOR_RAMDISK_RECOVERY_KERNEL_MODULES_LOAD := $(strip $(shell cat $(DEVICE_PATH)/modprobe/modules.load.recovery))
BOOT_KERNEL_MODULES := $(strip $(shell cat $(DEVICE_PATH)/modprobe/modules.include.vendor_dlkm))
RECOVERY_KERNEL_MODULES := $(strip $(shell cat $(DEVICE_PATH)/modprobe/modules.include.vendor_dlkm))
SYSTEM_KERNEL_MODULES := $(strip $(shell cat $(DEVICE_PATH)/modprobe/modules.include.system_dlkm))

# Partitions
BOARD_FLASH_BLOCK_SIZE := 262144 # (BOARD_KERNEL_PAGESIZE * 64)
BOARD_BOOTIMAGE_PARTITION_SIZE := 134217728
BOARD_RECOVERYIMAGE_PARTITION_SIZE := 134217728
BOARD_CACHEIMAGE_PARTITION_SIZE := 402653184
BOARD_CACHEIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_USERDATAIMAGE_PARTITION_SIZE := 5209325568
BOARD_USERDATAIMAGE_FILE_SYSTEM_TYPE := f2fs
BOARD_USES_METADATA_PARTITION := true

SSI_PARTITIONS := product system system_ext system_dlkm
TREBLE_PARTITIONS := odm odm_dlkm vendor vendor_dlkm
ALL_PARTITIONS := $(SSI_PARTITIONS) $(TREBLE_PARTITIONS)

$(foreach p, $(call to-upper, $(SSI_PARTITIONS)), \
    $(eval BOARD_$(p)IMAGE_FILE_SYSTEM_TYPE := ext4))

$(foreach p, $(call to-upper, $(TREBLE_PARTITIONS)), \
    $(eval BOARD_$(p)IMAGE_FILE_SYSTEM_TYPE := erofs))

$(foreach p, $(call to-upper, $(ALL_PARTITIONS)), \
    $(eval TARGET_COPY_OUT_$(p) := $(call to-lower, $(p))))

# Partitions - dynamic
BOARD_SUPER_PARTITION_SIZE := 12884901888 # 12GiB
BOARD_SUPER_PARTITION_GROUPS := linux_dynamic_partitions
BOARD_LINUX_DYNAMIC_PARTITIONS_PARTITION_LIST := $(ALL_PARTITIONS)
BOARD_LINUX_DYNAMIC_PARTITIONS_SIZE := 12880707584 # (BOARD_SUPER_PARTITION_SIZE - 4MiB)

# Recovery
TARGET_RECOVERY_FSTAB := $(DEVICE_PATH)/init/etc/fstab.mainline
TARGET_RECOVERY_PIXEL_FORMAT := BGRA_8888
