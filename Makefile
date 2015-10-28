GO_EASY_ON_ME = 1
ARCHS = armv7 arm64

include theos/makefiles/common.mk

TWEAK_NAME = CCSwipe
CCSwipe_FILES = Tweak.xm
CCSwipe_FRAMEWORKS = UIKit Foundation CoreGraphics
CCSwipe_PRIVATE_FRAMEWORKS = BackBoardServices SpringBoardServices
CCSwipe_CFLAGS = -fobjc-arc
CCSwipe_CODESIGN_FLAGS = -Sentitlements.xml
CCSwipe_LDFLAGS += -Wl,-segalign,4000

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 SpringBoard"

SUBPROJECTS += CCSwipe
include $(THEOS_MAKE_PATH)/aggregate.mk
