/*
**  AddressBookController.h
**
**  Copyright (c) 2003-2007
**
**  Author: Ludovic Marcotte <ludovic@Sophos.ca>
**
**  This program is free software; you can redistribute it and/or modify
**  it under the terms of the GNU General Public License as published by
**  the Free Software Foundation; either version 2 of the License, or
**  (at your option) any later version.
**
**  This program is distributed in the hope that it will be useful,
**  but WITHOUT ANY WARRANTY; without even the implied warranty of
**  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
**  GNU General Public License for more details.
**
**  You should have received a copy of the GNU General Public License
**  along with this program; if not, write to the Free Software
**  Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
*/

#ifndef _GNUMail_H_AddressBookController
#define _GNUMail_H_AddressBookController

#import <AppKit/AppKit.h>
#import <AddressBook/AddressBook.h>

#ifndef MACOSX
@class ADSinglePropertyView;
#endif

//
//
//
@interface NSArray (GNUMailABExtensions)
- (BOOL) containsRecord: (ABRecord *) record;
@end

//
//
//
@interface ABPerson (GNUMailABExtensions)
- (NSArray *) formattedValuesForPrefix: (NSString *) thePrefix;
- (NSString *) formattedValue;
- (NSString *) fullName;
#ifdef MACOSX
- (BOOL) compare: (ABPerson *) thePerson;
#endif
@end

@class CWMessage;

//
//
//
@interface AddressBookController: NSWindowController
{
  // Outlets and ivars
#ifdef MACOSX
  IBOutlet NSTableView *tableView;
  IBOutlet NSBrowser *browser;
  IBOutlet NSButton *open;
  
  NSMutableDictionary *allPersons;
  NSMutableArray *allSortedKeys;
#else
  ADSinglePropertyView *singlePropertyView;
#endif

  NSMapTable *_table;
}

//
// Action methods
//
- (void) doubleClickOnName: (NSString *) theName
                     value: (NSString *) theValue
                    inView: (id) theView;
- (IBAction) toClicked: (id) sender;
- (IBAction) ccClicked: (id) sender;
- (IBAction) bccClicked: (id) sender;
- (IBAction) openClicked: (id) sender;

//
// Other methods
//
- (NSArray *) addressesWithPrefix: (NSString *) thePrefix;
- (NSArray *) addressesWithSubstring: (NSString *) theSubstring;
- (NSArray *) addressesWithSubstring: (NSString *) theSubstring
		       inGroupWithId: (NSString *) groupId;
- (void) addSenderToAddressBook: (CWMessage *) theMessage;
- (void) freeCache;

//
// Mac OS X-only methods
//
#ifdef MACOSX
- (void) windowDidLoad;

- (IBAction) doubleClicked: (id) sender;

- (IBAction) selectionInBrowserHasChanged: (id) sender;

- (int)       browser: (NSBrowser *) sender
 numberOfRowsInColumn: (int) column;

- (void) browser: (NSBrowser *) sender
 willDisplayCell: (id) cell
	   atRow: (int) row
          column: (int) column;

- (BOOL) browser: (NSBrowser *) sender
       selectRow: (int) row
        inColumn: (int) column;
#endif

//
// class methods
//
+ (id) singleInstance;

@end


//
// AddressBookController private category
//
@interface AddressBookController (Private)

- (void) _updateFieldUsingSelector: (SEL) theSelector;

@end

#endif // _GNUMail_H_AddressBookController
