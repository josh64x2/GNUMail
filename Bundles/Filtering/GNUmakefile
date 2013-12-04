include $(GNUSTEP_MAKEFILES)/common.make

BUNDLE_NAME = Filtering
BUNDLE_EXTENSION = .prefs

BUNDLE_INSTALL_DIR = $(GNUSTEP_APPLICATION_SUPPORT)/GNUMail

Filtering_RESOURCE_FILES = Filtering.tiff

Filtering_OBJC_FILES = \
	FilteringView.m \
	FilteringViewController.m \
	FilterEditorWindow.m \
	FilterEditorWindowController.m \
	FilterHeaderEditorWindow.m \
	FilterHeaderEditorWindowController.m \
	FilterMessageWindow.m \
	FilterMessageWindowController.m

Filtering_HEADERS = \
	FilteringView.h \
	FilteringViewController.h \
	FilterEditorWindowController.h \
	FilterHeaderEditorWindow.h \
	FilterHeaderEditorWindowController.h \
	FilterMessageWindow.h \
	FilterMessageWindowController.h

Filtering_PRINCIPAL_CLASS = \
	FilteringViewController

ADDITIONAL_OBJCFLAGS = -Wall -Wno-import

ADDITIONAL_INCLUDE_DIRS += -I../../Framework/GNUMail
ADDITIONAL_LIB_DIRS += -L../../Framework/GNUMail/GNUMail.framework/Versions/Current/$(GNUSTEP_TARGET_LDIR)
ADDITIONAL_GUI_LIBS += -lAddresses -lGNUMail -lPantomime

include $(GNUSTEP_MAKEFILES)/bundle.make

-include GNUmakefile.postamble
