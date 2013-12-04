include $(GNUSTEP_MAKEFILES)/common.make

BUNDLE_NAME = Advanced
BUNDLE_EXTENSION = .prefs

BUNDLE_INSTALL_DIR = $(GNUSTEP_APPLICATION_SUPPORT)/GNUMail

Advanced_RESOURCE_FILES = advanced.tiff

Advanced_OBJC_FILES = \
	AdvancedView.m \
	AdvancedViewController.m

Advanced_HEADERS = \
	AdvancedView.h \
	AdvancedViewController.h

Advanced_PRINCIPAL_CLASS = \
	AdvancedViewController

ADDITIONAL_OBJCFLAGS = -Wall -Wno-import

ADDITIONAL_INCLUDE_DIRS += -I../../Framework/GNUMail
ADDITIONAL_LIB_DIRS += -L../../Framework/GNUMail/GNUMail.framework/Versions/Current/$(GNUSTEP_TARGET_LDIR)
ADDITIONAL_GUI_LIBS += -lGNUMail

include $(GNUSTEP_MAKEFILES)/bundle.make

-include GNUmakefile.postamble
