#
#  GNUMail.app Makefile for GNUstep
#
#  Copyright (C) 2001-2006
#
#  Author: Ludovic Marcotte <ludovic@Sophos.ca>
#
#  This program is free software; you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation; either version 2 of the License, or
#  (at your option) any later version.
#   
#  This program is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#   
#  You should have received a copy of the GNU General Public License
#  along with this program; if not, write to the Free Software
#  Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.

include $(GNUSTEP_MAKEFILES)/common.make

SUBPROJECTS = \
	Framework/GNUMail \
	Bundles/Account \
	Bundles/Advanced \
	Bundles/Colors \
	Bundles/Compose \
	Bundles/Filtering \
	Bundles/Fonts \
	Bundles/Import \
	Bundles/MIME \
	Bundles/Receiving \
	Bundles/Sending \
	Bundles/Viewing

APP_NAME = GNUMail
GNUMail_OBJC_FILES = GNUMail_main.m 
GNUMail_RESOURCE_FILES = \
	Resources/*.lproj \
	Resources/Icons/*.tiff \
	Resources/Goodies/Welcome \
	ScriptingInfo.plist

GNUMail_LANGUAGES = \
	Resources/Arabic \
	Resources/Czech \
	Resources/English \
	Resources/German \
	Resources/French \
	Resources/Russian \
	Resources/Spanish \
	Resources/Swedish \
	Resources/Turkish

GNUMail_LIB_DIRS = -L../$(GNUSTEP_LIBRARIES_ROOT) -LFramework/GNUMail/GNUMail.framework/Versions/Current/$(GNUSTEP_TARGET_LDIR) -LFramework/GNUMail/GNUMail.framework
GNUMail_GUI_LIBS = -lGNUMail -lPantomime -lAddresses -lAddressView
GNUMail_LOCALIZED_RESOURCE_FILES = Localizable.strings

ADDITIONAL_INCLUDE_DIRS += -I./Framework/GNUMail
ADDITIONAL_OBJCFLAGS += -Wall -Wno-import -I/usr/kerberos/include

# If we want to memory-debug the application on Linux
#ADDITIONAL_LDFLAGS += -lefence

include $(GNUSTEP_MAKEFILES)/aggregate.make
include $(GNUSTEP_MAKEFILES)/application.make
