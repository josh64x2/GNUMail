include $(GNUSTEP_MAKEFILES)/common.make

BUNDLE_NAME = Account
BUNDLE_EXTENSION = .prefs

BUNDLE_INSTALL_DIR = $(GNUSTEP_APPLICATION_SUPPORT)/GNUMail

Account_RESOURCE_FILES = account.tiff

Account_OBJC_FILES = \
	AccountView.m \
	AccountViewController.m \
	AccountEditorWindow.m \
	AccountEditorWindowController.m \
	PersonalView.m \
	ReceiveView.m \
	SendView.m \
	IMAPView.m \
	POP3View.m \
	UNIXView.m

Account_HEADERS = \
	AccountView.h \
	AccountViewController.h \
	AccountEditorWindow.h \
	AccountEditorWindowController.h \
	PersonalView.h \
	ReceiveView.h \
	SendView.h \
	IMAPView.h \
	POP3View.h \
	UNIXView.h

Account_PRINCIPAL_CLASS = \
	AccountViewController

ADDITIONAL_OBJCFLAGS += -Wall -Wno-import

ADDITIONAL_INCLUDE_DIRS += -I../../Framework/GNUMail
ADDITIONAL_LIB_DIRS += -L../../Framework/GNUMail/GNUMail.framework/Versions/Current/$(GNUSTEP_TARGET_LDIR)
ADDITIONAL_GUI_LIBS += -lGNUMail -lPantomime

# Under Solaris, we include SSL headers / libraries
ifeq ($(findstring solaris, $(GNUSTEP_TARGET_OS)), solaris)
ADDITIONAL_OBJCFLAGS = -I/usr/local/ssl/include
endif

include $(GNUSTEP_MAKEFILES)/bundle.make

-include GNUmakefile.postamble
