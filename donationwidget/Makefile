export TARGET = iphone:clang:13.3:13.0
INSTALL_TARGET_PROCESSES = SpringBoard
ARCHS = arm64 arm64e


include $(THEOS)/makefiles/common.mk

BUNDLE_NAME = DonationWidget
DonationWidget_FILES = HSDonationWidgetViewController.mm $(wildcard *.swift)
DonationWidget_FRAMEWORKS = UIKit
DonationWidget_EXTRA_FRAMEWORKS = HSWidgets
DonationWidget_INSTALL_PATH = /Library/HSWidgets
_THEOS_TARGET_SWIFT_LDPATH = /Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/../lib/swift/iphoneos -L/usr/lib/swift -L/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/../lib/swift-5.0/iphoneos/ -rpath /usr/lib/swift

include $(THEOS_MAKE_PATH)/bundle.mk

