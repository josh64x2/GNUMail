include $(GNUSTEP_MAKEFILES)/common.make

BUNDLE_NAME = Emoticon
BUNDLE_EXTENSION = .bundle

BUNDLE_INSTALL_DIR = $(GNUSTEP_APPLICATION_SUPPORT)/GNUMail

Emoticon_RESOURCE_FILES = *.tiff

Emoticon_OBJC_FILES = \
	EmoticonController.m

Emoticon_HEADERS = \
	EmoticonController.h

Emoticon_PRINCIPAL_CLASS = \
	EmoticonController

ADDITIONAL_OBJCFLAGS = -Wall -Wno-import

ADDITIONAL_INCLUDE_DIRS += -I../../Framework/GNUMail
ADDITIONAL_LIB_DIRS += -L../../Framework/GNUMail/GNUMail.framework/Versions/Current/$(GNUSTEP_TARGET_LDIR)
ADDITIONAL_GUI_LIBS += -lGNUMail -lPantomime

include $(GNUSTEP_MAKEFILES)/bundle.make

-include GNUmakefile.postamble
