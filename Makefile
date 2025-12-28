TARGET = appletv:clang:latest:14.0
INSTALL_TARGET_PROCESSES = Volte

include $(THEOS)/makefiles/common.mk

APPLICATION_NAME = Volte

Volte_FILES = ContentView.swift VolteApp.swift
CODESIGN_ENTITLEMENT = entitlements.xml
Volte_CODESIGN_FLAGS = -S$(CODESIGN_ENTITLEMENT)

include $(THEOS_MAKE_PATH)/application.mk
