include $(GNUSTEP_MAKEFILES)/common.make

BUNDLE_NAME = Clock
BUNDLE_EXTENSION = .bundle

BUNDLE_INSTALL_DIR = $(GNUSTEP_APPLICATION_SUPPORT)/GNUMail

Clock_RESOURCE_FILES = *.tiff

Clock_OBJC_FILES = \
	Clock.m \
	ClockController.m

Clock_HEADERS = \
	Clock.h \
	ClockController.h

Clock_PRINCIPAL_CLASS = \
	ClockController

ADDITIONAL_OBJCFLAGS = -Wall -Wno-import

ADDITIONAL_INCLUDE_DIRS += -I../.. -I../../Framework/GNUMail/

include $(GNUSTEP_MAKEFILES)/bundle.make

-include GNUmakefile.postamble
