/*
**  AddressBookController.m
**
**  Copyright (c) 2003-2006
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

#include "AddressBookController.h"

#include "AddressTaker.h"

#ifndef MACOSX
#include "AddressBookPanel.h"
#endif

#include "GNUMail.h"
#include "Constants.h"
#include "Utilities.h"

#include <Pantomime/CWInternetAddress.h>
#include <Pantomime/CWMessage.h>
#include <Pantomime/NSString+Extensions.h>

#define AB_SEARCH_ELEMENT(class, property, prefix) \
  [class searchElementForProperty: property \
	    label: nil \
	    key: nil \
	    value: prefix \
	    comparison: kABPrefixMatchCaseInsensitive]

static AddressBookController *singleInstance = nil;

//
//
//
@implementation NSArray (GNUMailABExtensions)
- (BOOL) containsRecord: (ABRecord *) record
{
  int i;
  
  i = [self count];
  
  while( i-- )
    {
      if ( [[[self objectAtIndex: i] uniqueId] isEqualToString: [record uniqueId]] )
	{
	  return YES;
	}
    }

  return NO;
}
@end


//
//
//
@implementation ABPerson (GNUMailABExtensions)
- (NSArray *) formattedValuesForPrefix: (NSString *) thePrefix
{
  NSMutableArray *arr; ABMultiValue *emails;
  NSString *firstName, *lastName;
  int i;

  thePrefix = [thePrefix lowercaseString]; // only check to-lower

  emails = [self valueForProperty: kABEmailProperty];
  if(![emails count])
    return [NSArray array];
  
  firstName = [self valueForProperty: kABFirstNameProperty];
  lastName = [self valueForProperty: kABLastNameProperty];

  arr = [NSMutableArray array];
  if (firstName && [[firstName lowercaseString] hasPrefix: thePrefix])
    {
      for (i=0; i<[emails count]; i++)
	{
	  if (lastName)
	    {
	      [arr addObject: [NSString stringWithFormat: @"%@ %@ <%@>",
					firstName, lastName, [emails valueAtIndex: i]]];
	    }
	  else
	    {
	      [arr addObject: [NSString stringWithFormat: @"%@ <%@>",
					firstName, [emails valueAtIndex: i]]];
	    }
	}
      
      return [NSArray arrayWithArray: arr];
    }
  
  if (lastName && [[lastName lowercaseString] hasPrefix: thePrefix])
    {
      for (i=0; i<[emails count]; i++)
	{
	  if (firstName)
	    {
	      [arr addObject: [NSString stringWithFormat: @"%@, %@ <%@>",
					lastName, firstName, [emails valueAtIndex: i]]];
	    }
	  else
	    {
	      [arr addObject: [NSString stringWithFormat: @"%@ <%@>",
					lastName, [emails valueAtIndex: i]]];
	    }
	}

      return [NSArray arrayWithArray: arr];
    }
  
  for (i=0; i<[emails count]; i++)
    {
      if ([[[emails valueAtIndex: i] lowercaseString] hasPrefix: thePrefix])
	{
	  [arr addObject: [emails valueAtIndex: i]];
	}
    }

  return [NSArray arrayWithArray: arr];
}

- (NSString *) formattedValue
{
  NSString *firstName, *lastName;

  firstName = [self valueForProperty: kABFirstNameProperty];
  lastName = [self valueForProperty: kABLastNameProperty];

  if ( firstName && lastName )
    {
      return [NSString stringWithFormat: @"%@ %@ <%@>", firstName, lastName,
		       [[self valueForProperty: kABEmailProperty] valueAtIndex: 0]];
    }
  else if ( firstName || lastName )
    {
      return [NSString stringWithFormat: @"%@ <%@>", (firstName == nil ? lastName : firstName),
		       [[self valueForProperty: kABEmailProperty] valueAtIndex: 0]];
    }
  
  return [[self valueForProperty: kABEmailProperty] valueAtIndex: 0];
}

- (NSString *) fullName
{
  NSString *firstName, *lastName;
      
  firstName = [self valueForProperty: kABFirstNameProperty];
  lastName = [self valueForProperty: kABLastNameProperty];
      
  if ( firstName && lastName )
    {
      return [NSString stringWithFormat: @"%@ %@", firstName, lastName];
    }
  else if ( firstName && !lastName )
    {
      return firstName;
    }
  else if ( !firstName && lastName )
    {
      return lastName;
    }

 return _(@"< unknown >");
}

#ifdef MACOSX
- (BOOL) compare: (ABPerson *) thePerson
{
   return [[self fullName] compare: [thePerson fullName]];
}
#endif
@end


//
// We use the window ivar to represent the Address Book window, but we
// expect only a single instance of the controller app-wide.
//
@implementation AddressBookController

- (id) initWithWindowNibName: (NSString *) windowNibName
{
#ifdef MACOSX
  self = [super initWithWindowNibName: windowNibName];
  allPersons = [[NSMutableDictionary alloc] init];
  allSortedKeys = [[NSMutableArray alloc] init];
#else
  AddressBookPanel *thePanel;
  
  thePanel = [[AddressBookPanel alloc] initWithContentRect: NSMakeRect(200,200,520,325)
				       styleMask: NSTitledWindowMask|NSClosableWindowMask|NSMiniaturizableWindowMask
				       backing: NSBackingStoreBuffered
				       defer: YES];
  
  self = [super initWithWindow: thePanel];

  [thePanel layoutPanel];
  [thePanel setDelegate: self];
  [thePanel setMinSize: [thePanel frame].size];

  // We link our outlets
  singlePropertyView = thePanel->singlePropertyView;

  RELEASE(thePanel);
#endif

  // We set some initial parameters
  [[self window] setTitle: _(@"Address Book")];

#ifdef MACOSX
  [browser setAction: @selector(selectionInBrowserHasChanged:)];
  [browser setDoubleAction: @selector(doubleClicked:)];
  [tableView setDoubleAction: @selector(doubleClicked:)];
  [browser selectRow: 0  inColumn: 0];
#endif

  // We finally set our autosave window frame name and restore the one from the user's defaults.
  [[self window] setFrameAutosaveName: @"AddressBookPanel"];
  [[self window] setFrameUsingName: @"AddressBookPanel"];
  
  _table = NSCreateMapTable(NSObjectMapKeyCallBacks, NSObjectMapValueCallBacks, 64);

  return self;
}


//
//
//
- (void) dealloc
{
#ifdef MACOSX
  [tableView setDataSource: nil];
  RELEASE(allPersons);
  RELEASE(allSortedKeys);
#endif

  NSFreeMapTable(_table);

  [super dealloc];
}


//
//
//
- (void) addSenderToAddressBook: (CWMessage *) theMessage
{
  NSString *personal, *email, *first, *last;
  ABMutableMultiValue *aMutableMultiValue;
#ifdef MACOSX
  NSArray *allObjects, *allKeys;
  int i, j;
#endif
  NSEnumerator *theEnumerator;
  ABPerson *aPerson;
  ABPerson *other;
  int v;
  
  personal = [[theMessage from] personal];
  email = [[theMessage from] address];

  if (!email && !personal)
    {
      NSBeep();
      return;
    }
  
  aPerson = [[[ABPerson alloc] init] autorelease];
  
  if (email)
    {
#ifdef MACOSX
      aMutableMultiValue = AUTORELEASE([[ABMutableMultiValue alloc ] init ]);
#else
      aMutableMultiValue = AUTORELEASE([[aPerson valueForProperty: kABEmailProperty] mutableCopy]);
#endif
      [aMutableMultiValue addValue: email  withLabel: kABEmailWorkLabel];
      [aPerson setValue: aMutableMultiValue  forProperty: kABEmailProperty];
    }
  
  if (personal)
    {
      if ([personal rangeOfString: @","].location == NSNotFound)
	{
	  NSArray *theComponents;
	  
	  theComponents = [personal componentsSeparatedByString: @" "];
	  
	  if ([theComponents count] > 1)
	    {
	      first = [[theComponents subarrayWithRange: NSMakeRange(0, [theComponents count]-1)]
			componentsJoinedByString: @" "];
	      last = [theComponents objectAtIndex: [theComponents count]-1];
	      [aPerson setValue: first forProperty: kABFirstNameProperty];
	      [aPerson setValue: last forProperty: kABLastNameProperty];
	    }
	  else
	    {
	      [aPerson setValue: personal forProperty: kABLastNameProperty];
	    }
	}
      else
	{
	  NSArray *theComponents;
	  
	  theComponents = [personal componentsSeparatedByString: @","];
	  
	  if ([theComponents count] > 1)
	    {
	      last = [theComponents objectAtIndex: 0];
	      first = [theComponents objectAtIndex: 1];
	      [aPerson setValue: first forProperty: kABFirstNameProperty];
	      [aPerson setValue: last forProperty: kABLastNameProperty];
	    }
	  else
	    {
	      [aPerson setValue: personal forProperty: kABLastNameProperty];
	    }
       }
    }
  
  // We verify if the person is already in the address book
  theEnumerator = [[[ABAddressBook sharedAddressBook] people] objectEnumerator];
  
  while ((other = [theEnumerator nextObject]))
    {
      if ([[other fullName] isEqualToString: [aPerson fullName]])
	{
	  v = NSRunAlertPanel(_(@"Person exists!"),
			      _(@"There is already a person named '%@'\nin the address book."),
			      _(@"Don't add"),               // Default
			      _(@"Add anyway"),              // Alternate
			      _(@"Add address to existing"), // Other
			      [aPerson fullName]);
	  switch (v)
	    {
	      // add anyway, i.e. continue
	    case NSAlertAlternateReturn: 
	      break;
	      // add email to existing
	    case NSAlertOtherReturn: 
	      if (!email)
		{
		  NSRunAlertPanel(_(@"No address!"),
				  _(@"The sender of this messages has no email address!"),
				  _(@"OK"), 
				  nil, 
				  nil, 
				  nil);
		  return;
		}
	      
	      aMutableMultiValue = AUTORELEASE([[other valueForProperty: kABEmailProperty] mutableCopy]);
	      [aMutableMultiValue addValue: email withLabel: kABEmailWorkLabel];
	      [other setValue: aMutableMultiValue forProperty: kABEmailProperty];
	      [[ABAddressBook sharedAddressBook] save];
	      return;
	    case 1:
	    default:
	      return;
	    }
	}
    }
  
  if (![[ABAddressBook sharedAddressBook] addRecord: aPerson])
    {
      NSRunAlertPanel(_(@"The person could not be added "
			@"to the address book."), _(@"OK"), nil, nil, nil);
    }
  
  [[ABAddressBook sharedAddressBook] save];
    
#ifdef MACOSX
  [allPersons setObject: aPerson forKey: email ];
  allObjects = [[allPersons allValues] sortedArrayUsingSelector: @selector(compare:)];
  
  for (i = 0; i < [allObjects count]; i++)
    {
      allKeys = [allPersons allKeysForObject: [allObjects objectAtIndex: i]];
      
      for (j = 0; j < [allKeys count]; j++)
        {
          if (![allSortedKeys containsObject: [allKeys objectAtIndex: j]])
            {
              [allSortedKeys addObject: [allKeys objectAtIndex: j]];
            }
        }
    }

  [tableView reloadData];
#endif
}


//
//
//
- (void) freeCache
{
  NSResetMapTable(_table);
}

// 
// Action methods
//
- (void) doubleClickOnName: (NSString *) theName
                     value: (NSString *) theValue
                    inView: (id) theView
{
  int modifier;

  modifier = [[[self window] currentEvent] modifierFlags];

  if ( (modifier&NSControlKeyMask) && !(modifier&NSShiftKeyMask) )
    {
      return [self ccClicked: nil];
    }
  else if ( !(modifier&NSControlKeyMask) && (modifier&NSShiftKeyMask) )
    {
      return [self bccClicked: nil];
    }
  else
    {
      return [self toClicked: nil];
    }
}


//
//
//
- (IBAction) toClicked: (id) sender
{
  [self _updateFieldUsingSelector: @selector(takeToAddress:)];
}


//
//
//
- (IBAction) ccClicked: (id) sender
{
  [self _updateFieldUsingSelector: @selector(takeCcAddress:)];
}


//
//
//
- (IBAction) bccClicked: (id) sender
{
  [self _updateFieldUsingSelector: @selector(takeBccAddress:)];
}


//
//
//
- (IBAction) openClicked: (id) sender
{
#ifdef MACOSX
  [[NSWorkspace sharedWorkspace] launchApplication: @"Address Book"];
#else
  [[NSWorkspace sharedWorkspace] launchApplication: @"AddressManager"];
#endif
}


//
// Other methods
//
- (NSArray *) addressesWithPrefix: (NSString *) thePrefix
{
  ABSearchElement *firstNameElement, *lastNameElement, *emailElement, *groupNameElement;
  NSEnumerator *e; ABRecord *r;
  NSMutableArray *aMutableArray;
   
  if ( !thePrefix || [[thePrefix stringByTrimmingWhiteSpaces] length] == 0 )
    {
      return [NSArray array];
    }
  
  //
  // Create our search elements; we search on first name, last name, and E-Mail address.
  // Do search on last name last so that the order of the list is sensible.
  //
  firstNameElement = AB_SEARCH_ELEMENT(ABPerson, kABFirstNameProperty, thePrefix);
  lastNameElement = AB_SEARCH_ELEMENT(ABPerson, kABLastNameProperty, thePrefix);
  emailElement = AB_SEARCH_ELEMENT(ABPerson, kABEmailProperty, thePrefix);

  // We also search on groups    
  groupNameElement = AB_SEARCH_ELEMENT(ABGroup, kABGroupNameProperty, thePrefix);
  
  aMutableArray = [[NSMutableArray alloc] init];
      
  [aMutableArray addObjectsFromArray: [[ABAddressBook sharedAddressBook] recordsMatchingSearchElement: firstNameElement]];
  e = [[[ABAddressBook sharedAddressBook] recordsMatchingSearchElement: lastNameElement] objectEnumerator];
  while((r = [e nextObject]))
    if(![aMutableArray containsRecord: r])
      [aMutableArray addObject: r];
  e = [[[ABAddressBook sharedAddressBook] recordsMatchingSearchElement: emailElement] objectEnumerator];
  while((r = [e nextObject]))
    if(![aMutableArray containsRecord: r])
      [aMutableArray addObject: r];
  e = [[[ABAddressBook sharedAddressBook] recordsMatchingSearchElement: groupNameElement] objectEnumerator];
  while((r = [e nextObject]))
    if(![aMutableArray containsRecord: r])
      [aMutableArray addObject: r];
  
  return AUTORELEASE(aMutableArray);
}


//
//
//
- (NSArray *) addressesWithSubstring: (NSString *) theSubstring
		       inGroupWithId: (NSString *) theGroupId
{
  if (!theSubstring || ![theSubstring length])
    {
      return [NSArray array];
    }
  else
    {
      NSMutableArray *aMutableArray;
      NSArray *thePeople;
      ABPerson *aPerson;
      ABGroup *aGroup;
      
      int i, j, count;

      aMutableArray = NSMapGet(_table, theSubstring);

      if (aMutableArray && !theGroupId) return aMutableArray;
      
      if (theGroupId)
	{
	  aGroup = (id)[[ABAddressBook sharedAddressBook] recordForUniqueId: theGroupId];
	
	  if (!aGroup || ![aGroup isKindOfClass: [ABGroup class]])
	    {
	      return [NSArray array];
	    }
	  
	  thePeople = [aGroup members];
	}
      else
	{
	  thePeople = [[ABAddressBook sharedAddressBook] people];
	}

      aMutableArray = [[NSMutableArray alloc] init];
      count = [thePeople count];

      for (i = 0; i < count; i++)
	{
	  aPerson = [thePeople objectAtIndex: i];
	  
	  // We first look for the name
	  if ([theSubstring rangeOfString: [aPerson fullName]  options: NSCaseInsensitiveSearch].length)
	    {
	      for (j = 0; j < [[aPerson valueForProperty: kABEmailProperty] count]; j++)
		{
		  [aMutableArray addObject: [[aPerson valueForProperty: kABEmailProperty] valueAtIndex: j]];
		}
	    }
	  // We look at the addresses directly
	  else
	    {
	      for (j = 0; j < [[aPerson valueForProperty: kABEmailProperty] count]; j++)
		{
		  if ([theSubstring rangeOfString: [[aPerson valueForProperty: kABEmailProperty] valueAtIndex: j]
				    options: NSCaseInsensitiveSearch].length)
		    {
		      [aMutableArray addObject: [[aPerson valueForProperty: kABEmailProperty] valueAtIndex: j]];
		    }
		}
	    }
	}
      
      if (!theGroupId) NSMapInsert(_table, theSubstring, aMutableArray);
      
      return AUTORELEASE(aMutableArray);
    }
}


- (NSArray *) addressesWithSubstring: (NSString *) theSubstring
{
  return [self addressesWithSubstring: theSubstring inGroupWithId: nil];
}
  

//
// Mac OS X methods (delegates, data source methods, etc.)
// 
#ifdef MACOSX

- (void) windowDidLoad
{
  [browser loadColumnZero];
  [browser setNeedsDisplay: YES];
}


//
//
//
- (IBAction) doubleClicked: (id) sender
{
  if ( sender == browser )
    {
      [tableView selectAll: self];
    }
  else
    {
      [self doubleClickOnName: nil  value: nil  inView: nil];
    }
}


//
//
//
- (IBAction) selectionInBrowserHasChanged: (id) sender
{
  [tableView deselectAll: self];
  [self browser: browser
	selectRow: [browser selectedRowInColumn: 0]
	inColumn: 0];
}


//
//
//
- (int)       browser: (NSBrowser *) sender
 numberOfRowsInColumn: (int) column
{
  // We return the number of groups we have  
  return ([[[ABAddressBook sharedAddressBook] groups] count] + 1);
}


//
//
//
- (void) browser: (NSBrowser *) sender
 willDisplayCell: (id) cell
	   atRow: (int) row
	  column: (int) column
{
  // We display the group name
  if (row == 0)
    {
      [cell setStringValue: _(@"All")];
    }
  else
    {
      [cell setStringValue: [[[[ABAddressBook sharedAddressBook] groups] objectAtIndex: (row-1)]
            valueForProperty: kABGroupNameProperty]];
    }
  [cell setLeaf: YES];
}

- (BOOL) browser: (NSBrowser *) sender
       selectRow: (int) row
        inColumn: (int) column
{
  NSArray *allObjects, *allKeys;
  ABAddressBook *addressBook;
  ABPerson *aPerson;
  int i, j;
  
  addressBook = [ABAddressBook sharedAddressBook];
  [allPersons removeAllObjects];
  [allSortedKeys removeAllObjects];
   
  if ( row == 0 )
    {
      allObjects = [addressBook people];
    }
  else
    {
      allObjects = [[[addressBook groups] objectAtIndex: (row-1)] members];
    }
    
  for (i = 0; i < [allObjects count]; i++)
    {
      aPerson = [allObjects objectAtIndex: i];
      
      for (j = 0; j < [[aPerson valueForProperty: kABEmailProperty] count]; j++)
        {
          [allPersons setObject: aPerson
                         forKey: [[aPerson valueForProperty: kABEmailProperty] valueAtIndex: j]];
        }
    }

  allObjects = [[allPersons allValues] sortedArrayUsingSelector: @selector(compare:)];
  
  for (i = 0; i < [allObjects count]; i++)
    {
      allKeys = [allPersons allKeysForObject: [allObjects objectAtIndex: i]];
      
      for (j = 0; j < [allKeys count]; j++)
        {
           if ( ![allSortedKeys containsObject: [allKeys objectAtIndex: j]] )
             {
               [allSortedKeys addObject: [allKeys objectAtIndex: j]];
             }
        }
    }

  [tableView reloadData];  
  return YES;
}


- (int) numberOfRowsInTableView: (NSTableView *) theTableView
{
  return [allSortedKeys count];
}

- (id)           tableView: (NSTableView *) aTableView
 objectValueForTableColumn: (NSTableColumn *) aTableColumn 
		       row: (int) rowIndex
{
  ABPerson *aPerson;
  
  aPerson = [allPersons objectForKey: [allSortedKeys objectAtIndex: rowIndex]];
  
  // Email column
  if ( aTableColumn == [[aTableView tableColumns] lastObject] )
    {
      return [allSortedKeys objectAtIndex: rowIndex];
    }
  // Person name
  else
    {
      return [aPerson fullName];
    }
    
  // Never reached.
  return nil;
}

- (BOOL)  tableView: (NSTableView *) theTableView
shouldEditTableColumn: (NSTableColumn *) theTableColumn
                 row: (int) theRow
{
  // We prevent any kind of editing in the table view
  return NO;
}

//
// End of Mac OS X-only methods.
//
#endif


//
// class methods
//
+ (id) singleInstance
{
  if (!singleInstance)
    {
      singleInstance = [[AddressBookController alloc] initWithWindowNibName: @"AddressBookPanel"];
    }
  
  return singleInstance;
}

@end


//
// AddressBookController private category
//
@implementation AddressBookController (Private)

- (void) _updateFieldUsingSelector: (SEL) theSelector
{
#ifdef MACOSX
  NSEnumerator *theEnumerator;
  ABPerson *aPerson;
  id aRow;
#endif
  id theValues;

  if (![GNUMail lastAddressTakerWindowOnTop])
    {
      [[NSApp delegate] composeMessage: self];
    }

#ifdef MACOSX
  theValues = AUTORELEASE([[NSMutableArray alloc] init]);
  theEnumerator = [tableView selectedRowEnumerator];
  
  while ((aRow = [theEnumerator nextObject]))
    {
      aPerson = [allPersons objectForKey: [allSortedKeys objectAtIndex: [aRow intValue]]];
      [theValues addObject: [NSArray arrayWithObjects: [aPerson fullName],
				     [allSortedKeys objectAtIndex: [aRow intValue]], nil]];
    }
#else
  theValues = [singlePropertyView selectedNamesAndValues];
#endif
  
  if ([theValues count] > 0)
    { 
      int i;
           
      for (i = 0; i < [theValues count]; i++)
	{
	  [(id<NSObject>)[GNUMail lastAddressTakerWindowOnTop] performSelector: theSelector
			 withObject: [theValues objectAtIndex: i]];
	}
    }
  else
    {
      NSBeep();
    }
}

@end
