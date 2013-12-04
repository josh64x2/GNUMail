include $(GNUSTEP_MAKEFILES)/common.make

BUNDLE_NAME = MIME
BUNDLE_EXTENSION = .prefs

BUNDLE_INSTALL_DIR = $(GNUSTEP_APPLICATION_SUPPORT)/GNUMail

MIME_RESOURCE_FILES = mime.tiff

MIME_OBJC_FILES = \
	MIMEView.m \
	MIMEViewController.m \
	MimeTypeEditorWindow.m \
	MimeTypeEditorWindowController.m

MIME_HEADERS = \
	MIMEView.h \
	MIMEViewController.h \
	MimeTypeEditorWindow.h \
	MimeTypeEditorWindowController.h

MIME_PRINCIPAL_CLASS = \
	MIMEViewController

ADDITIONAL_OBJCFLAGS = -Wall -Wno-import

ADDITIONAL_INCLUDE_DIRS += -I../../Framework/GNUMail
ADDITIONAL_LIB_DIRS += -L../../Framework/GNUMail/GNUMail.framework/Versions/Current/$(GNUSTEP_TARGET_LDIR)
ADDITIONAL_GUI_LIBS += -lGNUMail
 
include $(GNUSTEP_MAKEFILES)/bundle.make

-include GNUmakefile.postamble
