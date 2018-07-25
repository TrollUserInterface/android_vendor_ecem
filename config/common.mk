PRODUCT_BRAND ?= EcemUI

PRODUCT_BUILD_PROP_OVERRIDES += BUILD_UTC_DATE=0

ifeq ($(PRODUCT_GMS_CLIENTID_BASE),)
PRODUCT_PROPERTY_OVERRIDES += \
    ro.com.google.clientidbase=android-google
else
PRODUCT_PROPERTY_OVERRIDES += \
    ro.com.google.clientidbase=$(PRODUCT_GMS_CLIENTID_BASE)
endif

PRODUCT_PROPERTY_OVERRIDES += \
    keyguard.no_require_sim=true

PRODUCT_PROPERTY_OVERRIDES += \
    ro.build.selinux=1

ifneq ($(TARGET_BUILD_VARIANT),user)
# Thank you, please drive thru!
PRODUCT_PROPERTY_OVERRIDES += persist.sys.dun.override=0
endif

ifneq ($(TARGET_BUILD_VARIANT),eng)
# Enable ADB authentication
ADDITIONAL_DEFAULT_PROPERTIES += ro.adb.secure=1
endif

# Backup Tool
PRODUCT_COPY_FILES += \
    vendor/ecem/prebuilt/common/bin/backuptool.sh:install/bin/backuptool.sh \
    vendor/ecem/prebuilt/common/bin/backuptool.functions:install/bin/backuptool.functions \
    vendor/ecem/prebuilt/common/bin/50-ecem.sh:system/addon.d/50-ecem.sh \
    vendor/ecem/prebuilt/common/bin/blacklist:system/addon.d/blacklist

# System feature whitelists
PRODUCT_COPY_FILES += \
    vendor/ecem/config/permissions/backup.xml:system/etc/sysconfig/backup.xml \
    vendor/ecem/config/permissions/power-whitelist.xml:system/etc/sysconfig/power-whitelist.xml

# Signature compatibility validation
PRODUCT_COPY_FILES += \
    vendor/ecem/prebuilt/common/bin/otasigcheck.sh:install/bin/otasigcheck.sh

# init.d support
PRODUCT_COPY_FILES += \
    vendor/ecem/prebuilt/common/bin/sysinit:system/bin/sysinit

ifneq ($(TARGET_BUILD_VARIANT),user)
# userinit support
PRODUCT_COPY_FILES += \
    vendor/ecem/prebuilt/common/etc/init.d/90userinit:system/etc/init.d/90userinit
endif

# Ecem-specific init file
PRODUCT_COPY_FILES += \
    vendor/ecem/prebuilt/common/etc/init.local.rc:root/init.viper.rc

# Copy over added mimetype supported in libcore.net.MimeUtils
PRODUCT_COPY_FILES += \
    vendor/ecem/prebuilt/common/lib/content-types.properties:system/lib/content-types.properties

# Enable SIP+VoIP on all targets
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.software.sip.voip.xml:system/etc/permissions/android.software.sip.voip.xml

# Enable wireless Xbox 360 controller support
PRODUCT_COPY_FILES += \
    frameworks/base/data/keyboards/Vendor_045e_Product_028e.kl:system/usr/keylayout/Vendor_045e_Product_0719.kl

# This is EcemUI!
PRODUCT_COPY_FILES += \
    vendor/ecem/config/permissions/com.viper.android.xml:system/etc/permissions/com.viper.android.xml

# Include CM audio files
include vendor/ecem/config/cm_audio.mk

ifneq ($(TARGET_DISABLE_CMSDK), true)
# CMSDK
include vendor/ecem/config/cmsdk_common.mk
endif

ifeq ($(TARGET_USE_AUDIOFX), true)
PRODUCT_PACKAGES += \
    AudioFX \
    CMAudioService
else
PRODUCT_PACKAGES += \
    MusicFX
ifneq ($(TARGET_NO_DSPMANAGER), true)
PRODUCT_PACKAGES += \
    libcyanogen-dsp \
    audio_effects.conf
endif
endif

# TWRP
ifeq ($(WITH_TWRP),true)
include vendor/cm/config/twrp.mk
endif

# Bootanimation
PRODUCT_PACKAGES += \
    bootanimation.zip

PRODUCT_PROPERTY_OVERRIDES := \
    ro.com.google.ime.theme_id=5

PRODUCT_PROPERTY_OVERRIDES := \
    ro.opa.eligible_device=true

PRODUCT_PROPERTY_OVERRIDES := \
    ro.substratum.verified=true

# LatinIme Gestures
PRODUCT_COPY_FILES += \
    vendor/ecem/prebuilt/common/lib/libjni_latinimegoogle.so:system/lib/libjni_latinimegoogle.so

# Camera Effects for devices without a vendor partition
ifneq ($(filter shamu,$(TARGET_PRODUCT)),)
PRODUCT_COPY_FILES +=  \
    vendor/ecem/prebuilt/common/media/LMspeed_508.emd:system/vendor/media/LMspeed_508.emd \
    vendor/ecem/prebuilt/common/media/PFFprec_600.emd:system/vendor/media/PFFprec_600.emd
endif

# Android O emojis
PRODUCT_COPY_FILES += \
    vendor/ecem/prebuilt/common/fonts/NotoColorEmoji.ttf:system/fonts/NotoColorEmoji.ttf

# Prebuilt Packages
PRODUCT_PACKAGES += \
    GoogleWallpaperPicker \
    Lawnchair \
    GDeskClock \
    Turbo

# Required Ecem packages
PRODUCT_PACKAGES += \
    BluetoothExt \
    CMParts \
    Development \
    Profiles

# Optional Ecem packages
PRODUCT_PACKAGES += \
    libemoji \
    LiveWallpapersPicker \
    Terminal

# Include explicitly to work around GMS issues
PRODUCT_PACKAGES += \
    libprotobuf-cpp-full \
    librsjni

# Custom Ecem packages
PRODUCT_PACKAGES += \
    CMSettingsProvider \
    ExactCalculator \
    LiveLockScreenService \
    ThemeInterfacer \
    WallpaperPicker \
    EcemPapers \
    Gallery2 \
    Jelly

# Omni packages
PRODUCT_PACKAGES += \
    OmniStyle \
    OmniJaws

# Extra tools in Ecem
PRODUCT_PACKAGES += \
    7z \
    bash \
    bzip2 \
    curl \
    fsck.ntfs \
    gdbserver \
    htop \
    lib7z \
    libsepol \
    micro_bench \
    mke2fs \
    mkfs.ntfs \
    mount.ntfs \
    oprofiled \
    pigz \
    powertop \
    sqlite3 \
    strace \
    tune2fs \
    unrar \
    unzip \
    vim \
    wget \
    zip

# Custom off-mode charger
ifneq ($(WITH_CM_CHARGER),false)
PRODUCT_PACKAGES += \
    charger_res_images \
    cm_charger_res_images \
    font_log.png \
    libhealthd.cm
endif

# ExFAT support
WITH_EXFAT ?= true
ifeq ($(WITH_EXFAT),true)
TARGET_USES_EXFAT := true
PRODUCT_PACKAGES += \
    mount.exfat \
    fsck.exfat \
    mkfs.exfat
endif

# Openssh
PRODUCT_PACKAGES += \
    scp \
    sftp \
    ssh \
    sshd \
    sshd_config \
    ssh-keygen \
    start-ssh

# rsync
PRODUCT_PACKAGES += \
    rsync

# Stagefright FFMPEG plugin
PRODUCT_PACKAGES += \
    libffmpeg_extractor \
    libffmpeg_omx \
    media_codecs_ffmpeg.xml

PRODUCT_PROPERTY_OVERRIDES += \
    media.sf.omx-plugin=libffmpeg_omx.so \
    media.sf.extractor-plugin=libffmpeg_extractor.so

# Storage manager
PRODUCT_PROPERTY_OVERRIDES += \
    ro.storage_manager.enabled=true

# Dex optimization not required
WITH_DEXPREOPT := false

# Telephony
PRODUCT_PACKAGES += \
    telephony-ext

PRODUCT_BOOT_JARS += \
    telephony-ext

# These packages are excluded from user builds
ifneq ($(TARGET_BUILD_VARIANT),user)
PRODUCT_PACKAGES += \
    procmem \
    procrank
endif

DEVICE_PACKAGE_OVERLAYS += vendor/ecem/overlay/common

# Versioning System
# EcemUI version.
ECEM_VERSION_CODENAME := Mızrak
ECEM_VERSION_NUMBER := v1.0

ECEM_DEVICE := $(ECEM_BUILD)

ifndef ECEM_BUILD_TYPE
    ECEM_BUILD_TYPE := UNOFFICIAL
    
PRODUCT_PROPERTY_OVERRIDES += \
    ro.ecem.buildtype=unofficial
endif

ifeq ($(ECEM_BUILD_TYPE), OFFICIAL)
PRODUCT_PACKAGES += \
    CMUpdater
PRODUCT_PROPERTY_OVERRIDES += \
    ro.ota.build.date=$(shell date +%Y%m%d)
    ro.ecem.buildtype=official
endif

# Set all versions
ECEM_VERSION := EcemUI-$(ECEM_DEVICE)-$(shell date +"%Y%m%d")-$(ECEM_VERSION_CODENAME)-$(ECEM_VERSION_NUMBER)-$(ECEM_BUILD_TYPE)

PRODUCT_PROPERTY_OVERRIDES += \
    BUILD_DISPLAY_ID=$(BUILD_ID) \
    ecem.ota.version=$(ECEM_VERSION) \
    ro.ecem.version=$(ECEM_VERSION)

PRODUCT_EXTRA_RECOVERY_KEYS += \
    vendor/ecem/build/target/product/security/ecem

-include vendor/ecem-priv/keys/keys.mk

-include $(WORKSPACE)/build_env/image-auto-bits.mk
-include vendor/ecem/config/partner_gms.mk
-include vendor/cyngn/product.mk

$(call prepend-product-if-exists, vendor/extra/product.mk)
