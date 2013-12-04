include $(GNUSTEP_MAKEFILES)/common.make

BUNDLE_NAME = PGP
BUNDLE_EXTENSION = .bundle

BUNDLE_INSTALL_DIR = $(GNUSTEP_APPLICATION_SUPPORT)/GNUMail

PGP_RESOURCE_FILES = *.tiff

PGP_OBJC_FILES = \
	PGPController.m \
	PGPView.m \
	PGPViewController.m

PGP_HEADERS = \
        PGPController.h \
	PGPView.h \
	PGPViewController.h

PGP_PRINCIPAL_CLASS = \
	PGPController

ADDITIONAL_OBJCFLAGS = -Wall -Wno-import

ADDITIONAL_INCLUDE_DIRS += -I../../Framework/GNUMail
ADDITIONAL_LIB_DIRS += -L../../Framework/GNUMail/GNUMail.framework/Versions/Current/$(GNUSTEP_TARGET_LDIR)
ADDITIONAL_GUI_LIBS += -lGNUMail -lPantomime

include $(GNUSTEP_MAKEFILES)/bundle.make

-include GNUmakefile.postamble
