include $(GNUSTEP_MAKEFILES)/common.make

BUNDLE_NAME = Fonts
BUNDLE_EXTENSION = .prefs

BUNDLE_INSTALL_DIR = $(GNUSTEP_APPLICATION_SUPPORT)/GNUMail

Fonts_RESOURCE_FILES = fonts.tiff

Fonts_OBJC_FILES = \
	FontsView.m \
	FontsViewController.m

Fonts_HEADERS = \
	FontsView.h \
	FontsViewController.h

Fonts_PRINCIPAL_CLASS = \
	FontsViewController

ADDITIONAL_OBJCFLAGS = -Wall -Wno-import

ADDITIONAL_INCLUDE_DIRS += -I../../Framework/GNUMail
ADDITIONAL_LIB_DIRS += -L../../Framework/GNUMail/GNUMail.framework/Versions/Current/$(GNUSTEP_TARGET_LDIR)
ADDITIONAL_GUI_LIBS += -lGNUMail

include $(GNUSTEP_MAKEFILES)/bundle.make

-include GNUmakefile.postamble
