#
#  GNUMail Framework Makefile for GNUstep
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

FRAMEWORK_NAME = GNUMail

GNUMAIL_MAJOR_VERSION=1
GNUMAIL_MINOR_VERSION=2
GNUMAIL_SUBMINOR_VERSION=0
GNUMAIL_VERSION=${GNUMAIL_MAJOR_VERSION}.${GNUMAIL_MINOR_VERSION}.${GNUMAIL_SUBMINOR_VERSION}
VERSION=${GNUMAIL_VERSION}

GNUMail_OBJC_FILES = \
	AboutPanel.m \
	AboutPanelController.m \
	AddressBookController.m \
	AddressBookPanel.m \
	ApplicationIconController.m \
	AutoCompletingTextField.m \
	ConsoleWindow.m \
	ConsoleWindowController.m \
	Constants.m \
	ExtendedCell.m \
	ExtendedFileWrapper.m \
	ExtendedMenuItem.m \
	ExtendedTableView.m \
	ExtendedTextAttachmentCell.m \
	ExtendedTextView.m \
	ExtendedOutlineView.m \
	ExtendedWindow.m \
	EditWindow.m \
	EditWindowController.m \
	EditWindowToolbar.m \
	Filter.m \
	FilterManager.m \
	FindWindow.m \
	FindWindowController.m \
	FolderNode.m \
	FolderNodePopUpItem.m \
	GNUMail.m \
	GNUMail+Extensions.m \
	GNUMail+MenuValidation.m \
	GNUMail+Services.m \
	ImageTextCell.m \
	LabelWidget.m \
	MailboxInspectorPanel.m \
	MailboxInspectorPanelController.m \
	MailboxManager.m \
	MailboxManagerCache.m \
	MailboxManagerController.m \
	MailboxManagerToolbar.m \
	MailHeaderCell.m \
	MailWindow.m \
	MailWindowController.m \
	MailWindowToolbar.m \
	MessageViewWindow.m \
	MessageViewWindowController.m \
	MessageViewWindowToolbar.m \
	MimeType.m \
	MimeTypeManager.m \
	NavigationToolbarItem.m \
	NewMailboxPanel.m \
	NewMailboxPanelController.m \
	NSAttributedString+Extensions.m \
	NSAttributedString+TextEnriched.m \
	NSBezierPath+Extensions.m \
	NSBundle+Extensions.m \
	NSColor+Extensions.m \
	NSFont+Extensions.m \
	NSPasteboard+Extensions.m \
	NSUserDefaults+Extensions.m \
	PasswordPanel.m \
	PasswordPanelController.m \
	PreferencesWindow.m \
	PreferencesWindowController.m \
	STScriptingSupport.m \
	Task.m \
	TaskManager.m \
	ThreadArcsCell.m \
	Utilities.m \
	WelcomePanel.m

GNUMail_LIB_DIRS = -L../$(GNUSTEP_LIBRARIES_ROOT)
GNUMail_GUI_LIBS = -lPantomime -lAddresses -lAddressView
ADDITIONAL_INCLUDE_DIRS = -I.

# We want to get all the warnings... 
ADDITIONAL_OBJCFLAGS += -Wall -Wno-import -I/usr/kerberos/include

# Under Solaris, we include SSL headers / libraries
ifeq ($(findstring solaris, $(GNUSTEP_TARGET_OS)), solaris)
ADDITIONAL_OBJCFLAGS += -I/usr/local/ssl/include
ADDITIONAL_LDFLAGS += -L/usr/local/ssl/lib -lssl -lcrypto
endif

include $(GNUSTEP_MAKEFILES)/aggregate.make
include $(GNUSTEP_MAKEFILES)/framework.make
