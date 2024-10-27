#
# Copyright (C) 2024 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base.mk)

# Inherit some common Lineage stuff.
$(call inherit-product, vendor/lineage/config/common_full_tablet.mk)

# Inherit from pc_x86_64 device
$(call inherit-product, device/linux/pc_x86_64/device.mk)

PRODUCT_NAME := lineage_pc_x86_64
PRODUCT_DEVICE := pc_x86_64
PRODUCT_MANUFACTURER := Linux
PRODUCT_BRAND := Android
PRODUCT_MODEL := AOSP on x86_64 PC
