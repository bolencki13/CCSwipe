ARCHS = armv7 arm64

include theos/makefiles/common.mk

BUNDLE_NAME = CCSwipe
CCSwipe_CFLAGS = -fobjc-arc
CCSwipe_FILES = SinisterPrefsListController.m NMRangeSlider.m
CCSwipe_INSTALL_PATH = /Library/PreferenceBundles
CCSwipe_FRAMEWORKS = Foundation UIKit QuartzCore CoreGraphics
CCSwipe_PRIVATE_FRAMEWORKS = Preferences Social

include $(THEOS_MAKE_PATH)/bundle.mk

internal-stage::
	$(ECHO_NOTHING)mkdir -p $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences$(ECHO_END)
	$(ECHO_NOTHING)cp entry.plist $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences/SinisterPrefs.plist$(ECHO_END)
