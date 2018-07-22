$(call inherit-product, vendor/ecem/config/common_mini.mk)

# Required Ecem packages
PRODUCT_PACKAGES += \
    LatinIME

$(call inherit-product, vendor/ecem/config/telephony.mk)
