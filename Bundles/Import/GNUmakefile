include $(GNUSTEP_MAKEFILES)/common.make

BUNDLE_NAME = Import
BUNDLE_EXTENSION = .bundle

BUNDLE_INSTALL_DIR = $(GNUSTEP_APPLICATION_SUPPORT)/GNUMail

Import_RESOURCE_FILES =  

Import_OBJC_FILES = \
	Views.m \
	MailboxImportController.m \
	MailboxImportController+Filters.m

Import_HEADERS = \
	Views.h \
	MailboxImportController.h \
	MailboxImportController+Filters.h

Import_PRINCIPAL_CLASS = \
	MailboxImportController	

ADDITIONAL_OBJCFLAGS = -Wall -Wno-import

ADDITIONAL_INCLUDE_DIRS += -I../../Framework/GNUMail
ADDITIONAL_LIB_DIRS += -L../../Framework/GNUMail/GNUMail.framework/Versions/Current/$(GNUSTEP_TARGET_LDIR)
ADDITIONAL_GUI_LIBS += -lGNUMail -lPantomime

include $(GNUSTEP_MAKEFILES)/bundle.make

-include GNUmakefile.postamble
