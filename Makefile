export THEOS = /opt/theos
ARCHS = arm64
DEBUG = 0
FINALPACKAGE = 1
THEOS_PACKAGE_SCHEME = rootless
TARGET = iphone:clang:latest:12.1

include $(THEOS)/makefiles/common.mk

LIBRARY_NAME = StreamMod

StreamMod_FILES = StreamMode.m StreamModeImGui.cpp StreamModeIntegration.mm
StreamMod_FRAMEWORKS = UIKit Foundation
StreamMod_CFLAGS = -fobjc-arc -Wall -Wno-deprecated-declarations
StreamMod_CCFLAGS = -std=c++11 -fno-rtti -fno-exceptions

include $(THEOS_MAKE_PATH)/library.mk