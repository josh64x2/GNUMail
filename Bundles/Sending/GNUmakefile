include $(GNUSTEP_MAKEFILES)/common.make

BUNDLE_NAME = Sending
BUNDLE_EXTENSION = .prefs

BUNDLE_INSTALL_DIR = $(GNUSTEP_APPLICATION_SUPPORT)/GNUMail

Sending_RESOURCE_FILES = MailIcon_send.tiff

Sending_OBJC_FILES = \
	SendingView.m \
	SendingViewController.m

Sending_HEADERS = \
	SendingView.h \
	SendingViewController.h

Sending_PRINCIPAL_CLASS = \
	SendingViewController

ADDITIONAL_OBJCFLAGS = -Wall -Wno-import

ADDITIONAL_INCLUDE_DIRS += -I../../Framework/GNUMail
ADDITIONAL_LIB_DIRS += -L../../Framework/GNUMail/GNUMail.framework/Versions/Current/$(GNUSTEP_TARGET_LDIR)
ADDITIONAL_GUI_LIBS += -lGNUMail

include $(GNUSTEP_MAKEFILES)/bundle.make

-include GNUmakefile.postamble
