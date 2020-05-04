INSTALL_TARGET_PROCESSES = SpringBoard
ARCHS = arm64 arm64e

include $(THEOS)/makefiles/common.mk

BUNDLE_NAME = CalculatorWidget
CalculatorWidget_FILES = $(wildcard CCCalcUI/*.xm) $(wildcard CCCalcUI/*.m)  HSCalculatorViewController.mm
CalculatorWidget_FRAMEWORKS = UIKit
CalculatorWidget_LIBRARIES = substrate
CalculatorWidget_EXTRA_FRAMEWORKS = HSWidgets
CalculatorWidget_PRIVATE_FRAMEWORKS = TelephonyUI
CalculatorWidget_INSTALL_PATH = /Library/HSWidgets

include $(THEOS_MAKE_PATH)/bundle.mk

