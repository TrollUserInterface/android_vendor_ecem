# Inherit common Ecem stuff
$(call inherit-product, vendor/ecem/config/common_mini.mk)

# Required Ecem packages
PRODUCT_PACKAGES += \
    LatinIME
