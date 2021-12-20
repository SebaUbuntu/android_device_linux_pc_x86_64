#
# Copyright (C) 2022 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

# Display
TARGET_DISPLAY_ENABLE_DRM := true

# Inherit from mainline-common
$(call inherit-product, device/linux/mainline-common/mainline.mk)

# Boot animation
TARGET_SCREEN_HEIGHT := 900
TARGET_SCREEN_WIDTH := 1440

# Setup dalvik vm configs
$(call inherit-product, frameworks/native/build/phone-xhdpi-4096-dalvik-heap.mk)

# Include prebuilt kernel
$(call inherit-product-if-exists, device/linux/pc_x86_64-kernel/kernel.mk)

# Rootdir
PRODUCT_PACKAGES += \
    fstab.mainline \
    fstab.mainline_ramdisk \
    init.device.rc

# Soong namespaces
PRODUCT_SOONG_NAMESPACES += \
    $(LOCAL_PATH)
