include $(GNUSTEP_MAKEFILES)/common.make

BUNDLE_NAME = Colors
BUNDLE_EXTENSION = .prefs

BUNDLE_INSTALL_DIR = $(GNUSTEP_APPLICATION_SUPPORT)/GNUMail

Colors_RESOURCE_FILES = colors.tiff

Colors_OBJC_FILES = \
	ColorsView.m \
	ColorsViewController.m

Colors_HEADERS = \
	ColorsView.h \
	ColorsViewController.h

Colors_PRINCIPAL_CLASS = \
	ColorsViewController

ADDITIONAL_OBJCFLAGS = -Wall -Wno-import

ADDITIONAL_INCLUDE_DIRS += -I../../Framework/GNUMail
ADDITIONAL_LIB_DIRS += -L../../Framework/GNUMail/GNUMail.framework/Versions/Current/$(GNUSTEP_TARGET_LDIR)
ADDITIONAL_GUI_LIBS += -lGNUMail

include $(GNUSTEP_MAKEFILES)/bundle.make

-include GNUmakefile.postamble
