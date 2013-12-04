include $(GNUSTEP_MAKEFILES)/common.make

BUNDLE_NAME = Compose
BUNDLE_EXTENSION = .prefs

BUNDLE_INSTALL_DIR = $(GNUSTEP_APPLICATION_SUPPORT)/GNUMail

Compose_RESOURCE_FILES = MailIcon_create.tiff

Compose_OBJC_FILES = \
	ComposeView.m \
	ComposeViewController.m

Compose_HEADERS = \
	ComposeView.h \
	ComposeViewController.h

Compose_PRINCIPAL_CLASS = \
	ComposeViewController

ADDITIONAL_OBJCFLAGS = -Wall -Wno-import

ADDITIONAL_INCLUDE_DIRS += -I../../Framework/GNUMail
ADDITIONAL_LIB_DIRS += -L../../Framework/GNUMail/GNUMail.framework/Versions/Current/$(GNUSTEP_TARGET_LDIR)
ADDITIONAL_GUI_LIBS += -lGNUMail -lPantomime

include $(GNUSTEP_MAKEFILES)/bundle.make

-include GNUmakefile.postamble
