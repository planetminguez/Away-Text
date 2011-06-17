GO_EASY_ON_ME=1
SYSROOT=/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS4.3.sdk
include theos/makefiles/common.mk
TWEAK_NAME = awaytext
awaytext_FILES = Tweak.xm
awaytext_FRAMEWORKS=ChatKit Foundation UIKit
awaytext_PRIVATE_FRAMEWORKS= CoreTelephony
include $(THEOS_MAKE_PATH)/tweak.mk

LIBRARY_NAME = awaytexttoggle
awaytexttoggle_OBJC_FILES = Toggle.m
awaytexttoggle_INSTALL_PATH = /var/mobile/Library/SBSettings/Toggles/awaytext/
awaytexttoggle_FRAMEWORKS = CoreFoundation CoreGraphics UIKit Foundation SystemConfiguration
ADDITIONAL_CFLAGS = -std=c99

include $(THEOS_MAKE_PATH)/library.mk

