#
# Copyright (C) 2018 The LineageOS Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

DEVICE_PATH := device/leagoo/f5c62w
VENDOR_BLOBS ?= vendor/leagoo/f5c62w/f5c62w-vendor.mk
$(call inherit-product-if-exists, $(VENDOR_BLOBS))

# Kernel
ifeq ($(TARGET_PREBUILT_KERNEL),)
	LOCAL_KERNEL := device/leagoo/f5c62w/prebuilts/kernel
else
	LOCAL_KERNEL := $(TARGET_PREBUILT_KERNEL)
endif

PRODUCT_COPY_FILES += \
    $(LOCAL_KERNEL):kernel

# Charger and USB
PRODUCT_DEFAULT_PROPERTY_OVERRIDES += \
    ro.usb.vid=0E8D

# Overlay
DEVICE_PACKAGE_OVERLAYS += $(LOCAL_PATH)/overlay

# Init
PRODUCT_COPY_FILES += \
    $(DEVICE_PATH)/rootdir/init.target.rc:root/init.target.rc

# Permissions
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.audio.low_latency.xml:system/etc/permissions/android.hardware.audio.low_latency.xml \
    frameworks/native/data/etc/android.hardware.bluetooth.xml:system/etc/permissions/android.hardware.bluetooth.xml \
    frameworks/native/data/etc/android.hardware.bluetooth_le.xml:system/etc/permissions/android.hardware.bluetooth_le.xml \
    frameworks/native/data/etc/android.hardware.camera.flash-autofocus.xml:system/etc/permissions/android.hardware.camera.flash-autofocus.xml \
    frameworks/native/data/etc/android.hardware.camera.front.xml:system/etc/permissions/android.hardware.camera.front.xml \
    frameworks/native/data/etc/android.hardware.fingerprint.xml:system/etc/permissions/android.hardware.fingerprint.xml \
    frameworks/native/data/etc/android.hardware.location.gps.xml:system/etc/permissions/android.hardware.location.gps.xml \
    frameworks/native/data/etc/android.hardware.sensor.accelerometer.xml:system/etc/permissions/android.hardware.sensor.accelerometer.xml \
    frameworks/native/data/etc/android.hardware.sensor.light.xml:system/etc/permissions/android.hardware.sensor.light.xml \
    frameworks/native/data/etc/android.hardware.sensor.proximity.xml:system/etc/permissions/android.hardware.sensor.proximity.xml \
    frameworks/native/data/etc/android.hardware.sensor.stepcounter.xml:system/etc/permissions/android.hardware.sensor.stepcounter.xml \
    frameworks/native/data/etc/android.hardware.sensor.stepdetector.xml:system/etc/permissions/android.hardware.sensor.stepdetector.xml \
    frameworks/native/data/etc/android.hardware.telephony.cdma.xml:system/etc/permissions/android.hardware.telephony.cdma.xml \
    frameworks/native/data/etc/android.hardware.telephony.gsm.xml:system/etc/permissions/android.hardware.telephony.gsm.xml \
    frameworks/native/data/etc/android.hardware.touchscreen.multitouch.jazzhand.xml:system/etc/permissions/android.hardware.touchscreen.multitouch.jazzhand.xml \
    frameworks/native/data/etc/android.hardware.usb.accessory.xml:system/etc/permissions/android.hardware.usb.accessory.xml \
    frameworks/native/data/etc/android.hardware.usb.host.xml:system/etc/permissions/android.hardware.usb.host.xml \
    frameworks/native/data/etc/android.hardware.wifi.xml:system/etc/permissions/android.hardware.wifi.xml \
    frameworks/native/data/etc/android.hardware.wifi.direct.xml:system/etc/permissions/android.hardware.wifi.direct.xml \
    frameworks/native/data/etc/android.software.midi.xml:system/etc/permissions/android.software.midi.xml \
    frameworks/native/data/etc/android.software.sip.voip.xml:system/etc/permissions/android.software.sip.voip.xml \
    $(DEVICE_PATH)/configs/handheld_core_hardware.xml:system/etc/permissions/handheld_core_hardware.xml

# Screen density
PRODUCT_AAPT_CONFIG := normal
PRODUCT_AAPT_PREBUILT_DPI := xhdpi 280dpi hdpi tvdpi mdpi ldpi
PRODUCT_AAPT_PREF_CONFIG := xhdpi

# Boot animation
TARGET_SCREEN_HEIGHT := 1280
TARGET_SCREEN_WIDTH := 720

# Fingerprint
PRODUCT_PACKAGES += \
    fingerprintd

# Telephony
SIM_COUNT := 2
PRODUCT_PROPERTY_OVERRIDES += ro.telephony.sim.count=$(SIM_COUNT)
PRODUCT_PROPERTY_OVERRIDES += persist.radio.default.sim=0
PRODUCT_PROPERTY_OVERRIDES += persist.radio.multisim.config=dsds

PRODUCT_COPY_FILES += \
    $(DEVICE_PATH)/configs/ecc_list.xml:system/etc/ecc_list.xml

# Graphics
MTK_GPU_VERSION := mali midgard r7p0

# IO Scheduler
PRODUCT_PROPERTY_OVERRIDES += \
    sys.io.scheduler=cfq

# Dalvik heap configurations
$(call inherit-product-if-exists, frameworks/native/build/phone-xhdpi-2048-dalvik-heap.mk)

# Call hwui memory config
$(call inherit-product-if-exists, frameworks/native/build/phone-xhdpi-2048-hwui-memory.mk)

# Inherit the rest from mt6737-common
$(call inherit-product, device/mediatek/mt6737-common/mt6737.mk)
