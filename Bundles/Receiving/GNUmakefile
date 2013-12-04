include $(GNUSTEP_MAKEFILES)/common.make

BUNDLE_NAME = Receiving
BUNDLE_EXTENSION = .prefs

BUNDLE_INSTALL_DIR = $(GNUSTEP_APPLICATION_SUPPORT)/GNUMail

Receiving_RESOURCE_FILES = MailIcon_retrieve.tiff

Receiving_OBJC_FILES = \
	ReceivingView.m \
	ReceivingViewController.m

Receiving_HEADERS = \
	ReceivingView.h \
	ReceivingViewController.h

Receiving_PRINCIPAL_CLASS = \
	ReceivingViewController

ADDITIONAL_OBJCFLAGS = -Wall -Wno-import

ADDITIONAL_INCLUDE_DIRS += -I../../Framework/GNUMail
ADDITIONAL_LIB_DIRS += -L../../Framework/GNUMail/GNUMail.framework/Versions/Current/$(GNUSTEP_TARGET_LDIR)
ADDITIONAL_GUI_LIBS += -lGNUMail

include $(GNUSTEP_MAKEFILES)/bundle.make

-include GNUmakefile.postamble
