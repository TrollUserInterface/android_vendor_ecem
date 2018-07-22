# Inherit common Ecem stuff
$(call inherit-product, vendor/ecem/config/common_full.mk)

# Required Ecem packages
PRODUCT_PACKAGES += \
    LatinIME

# Include Ecem LatinIME dictionaries
PRODUCT_PACKAGE_OVERLAYS += vendor/ecem/overlay/dictionaries

$(call inherit-product, vendor/ecem/config/telephony.mk)
