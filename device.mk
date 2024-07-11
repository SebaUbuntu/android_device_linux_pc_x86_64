#
# Copyright (C) 2024 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

TARGET_DISPLAY_ENABLE_DRM := true
TARGET_DISPLAY_ENABLE_MESA := false

# Inherit from mainline-common
$(call inherit-product, device/linux/mainline-common/mainline.mk)

# Setup dalvik vm configs
$(call inherit-product, frameworks/native/build/phone-xhdpi-6144-dalvik-heap.mk)

# Boot animation
TARGET_SCREEN_HEIGHT := 1080
TARGET_SCREEN_WIDTH := 1920

# Core hardware
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/pc_core_hardware.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/pc_core_hardware.xml

# Dynamic partitions
PRODUCT_USE_DYNAMIC_PARTITIONS := true

# Init
PRODUCT_PACKAGES += \
    fstab.mainline \
    fstab.mainline_ramdisk

PRODUCT_PACKAGES += \
    init.device.rc

# Soong namespaces
PRODUCT_SOONG_NAMESPACES += \
    $(LOCAL_PATH)
