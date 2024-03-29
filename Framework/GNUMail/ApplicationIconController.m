/*
**  ApplicationIconController.m
**
**  Copyright (c) 2004-2007
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

#include "ApplicationIconController.h"

#include <Pantomime/CWFolder.h>
#include <Pantomime/CWStore.h>
#include <Pantomime/CWIMAPStore.h>
#include <Pantomime/CWLocalStore.h>
#include <Pantomime/NSString+Extensions.h>

#include "Constants.h"
#include "MailboxManagerCache.h"
#include "MailboxManagerController.h"

static ApplicationIconController *singleInstance;
static NSMapTable *_cache;

#ifndef GNUSTEP
static int previous_unread_count = -1;
#endif

@interface UglyHack : NSObject
-(NSSize)iconSize;
-(NSImage *)iconTileImage;
@end

//
//
//
void draw_value(int value)
{
  NSMutableDictionary *attrs;
  NSString *aString;
  
  NSPoint text_location;
  NSRect disc_rect;
  NSSize disc_size;
  int image_width, pad;
  
  attrs = [[NSMutableDictionary alloc] init];
#ifdef MACOSX
  [attrs setObject: [NSFont fontWithName: @"Helvetica"  size: 32]  forKey: NSFontAttributeName];
#else
  [attrs setObject: [NSFont boldSystemFontOfSize: 0]  forKey: NSFontAttributeName];
#endif
  [attrs setObject: [NSColor blackColor]  forKey: NSForegroundColorAttributeName];
  
  aString = [NSString stringWithFormat: @"%d", value];
  disc_size = [aString sizeWithAttributes: attrs];
  
#ifdef MACOSX
  image_width = 128;
  pad = 20;
#else
  image_width = 64;
  pad = 8;
#endif
  disc_size.height += pad;
  disc_size.width += pad;
  disc_size.width = (disc_size.width < disc_size.height ? disc_size.height : disc_size.width);
  disc_size.height = (disc_size.height < disc_size.width ? disc_size.width : disc_size.height);

  disc_rect = NSMakeRect(image_width-disc_size.width-5,
			 image_width-disc_size.height-5,
			 disc_size.width,
			 disc_size.height);
  
  text_location = NSMakePoint(image_width-(disc_size.width - ((disc_size.width - [aString sizeWithAttributes: attrs].width) * 0.5))-5,
			      image_width-(disc_size.height - ((disc_size.height - [aString sizeWithAttributes: attrs].height) * 0.5))-4);
  
  [[NSColor colorWithDeviceRed: 1.0
	    green: 0.90
	    blue: 0.24
	    alpha: 1.0] set];
  [[NSBezierPath bezierPathWithOvalInRect: disc_rect] fill];
  [aString drawAtPoint: text_location  withAttributes: attrs];
  
  RELEASE(attrs);
}

//
// Set of all INBOX mailboxes (INBOXFOLDERNAME:s)
//
NSArray* inbox_folder_names()
{
  NSDictionary *allAccounts, *theAccount;
  NSEnumerator *theEnumerator;
  NSMutableArray *names;

  names = [NSMutableArray arrayWithCapacity: 10];
  allAccounts = [[NSUserDefaults standardUserDefaults] objectForKey: @"ACCOUNTS"];
  theEnumerator = [allAccounts keyEnumerator];
  
  while ((theAccount = [theEnumerator nextObject]))
    {
      [names addObject: [[[allAccounts objectForKey: theAccount] objectForKey: @"MAILBOXES"]
			  objectForKey: @"INBOXFOLDERNAME"]];
    }

  return names;
}


//
//
//
NSString* stringValueOfURLNameFromFolderName(NSString *folderName, id aStore)
{
  NSString *aString;
  
  if ([aStore isKindOfClass: [CWIMAPStore class]])
    {
      aString = [NSString stringWithFormat: @"imap://%@@%@/%@", 
			  [((CWIMAPStore *)aStore) username],
			  [((CWIMAPStore *)aStore) name],
			  folderName];
    }
  else
    {
      aString = [NSString stringWithFormat: @"local://%@/%@", 
			  [[NSUserDefaults standardUserDefaults] objectForKey: @"LOCALMAILDIR"],
			  folderName];
    }
  
  return aString;
}

//
//
//
int number_of_unread_messages()
{
  NSArray *allFolders, *allKeys;
  MailboxManagerCache *cache;
  NSString *aFolderName;
  id<NSObject> aStore;
  NSArray *inboxNames;
  BOOL inboxOnly;

  unsigned int c, i, j, v, result;
  
  cache = [[MailboxManagerController singleInstance] cache];
  allKeys = NSAllMapTableKeys(_cache);
  result = 0;
  
  inboxOnly = [[NSUserDefaults standardUserDefaults] boolForKey: @"ShowUnreadForInboxOnly"];
  inboxNames = nil;

  if (inboxOnly)
    {
      inboxNames = inbox_folder_names();
    }
  
  for (i = 0; i < [allKeys count]; i++)
    {
      aStore = [allKeys objectAtIndex: i];
      allFolders = NSMapGet(_cache, aStore);
      c = [allFolders count];
      
      for (j = 0; j < c; j++)
	{
	  aFolderName = [allFolders objectAtIndex: j];

	  if (inboxOnly && ![inboxNames containsObject: stringValueOfURLNameFromFolderName(aFolderName, aStore)])
	    continue;
	  
	  [cache allValuesForStoreName: ([aStore isKindOfClass: [CWIMAPStore class]] ? (id)[(CWIMAPStore *)aStore name] : (id)@"GNUMAIL_LOCAL_STORE")
		 folderName: [aFolderName stringByReplacingOccurrencesOfCharacter: [(id<CWStore>)aStore folderSeparator]  withCharacter: '/']
		 username: ([aStore isKindOfClass: [CWIMAPStore class]] ? [(CWIMAPStore *)aStore username] : NSUserName())
		 nbOfMessages: NULL
		 nbOfUnreadMessages: &v];
	  result += v;
	}
    }
  
  return result;
}

//
//
//
#ifndef MACOSX
@interface ApplicationIconView : NSView
{
  @private
    NSImage *_icon;
    NSImage *_tile;
    NSPoint _borderPoint;
}
@end

@implementation ApplicationIconView

- (id) init
{
  id currentServer = nil;
  NSSize serverIconSize;

  self = [super init];

  currentServer = [[[NSThread currentThread] threadDictionary] objectForKey:@"NSCurrentServerThreadKey"];
  _icon = [NSImage imageNamed: @"GNUMail_128"];
  [_icon setScalesWhenResized: YES];
  if (currentServer && [currentServer respondsToSelector: @selector(iconSize)])
    {
      serverIconSize = [currentServer iconSize];
      [_icon setSize: NSMakeSize(serverIconSize.width - (serverIconSize.width / 4),
      				 serverIconSize.height - (serverIconSize.height / 4))];
      _borderPoint = NSMakePoint(serverIconSize.width/8,serverIconSize.height/8);
    }
  else
    {
      serverIconSize = NSMakeSize(64,64);
      [_icon setSize: NSMakeSize(56,56)];
      _borderPoint = NSMakePoint(0, 4);
    }
  RETAIN(_icon);

  _tile = nil;

  if (currentServer && [currentServer respondsToSelector:@selector(iconTileImage)])
    {
      _tile = [[currentServer iconTileImage] copy];
      [_tile setScalesWhenResized:YES];
      [_tile setSize:serverIconSize];
    }
  else
    {
      _tile = [NSImage imageNamed: @"common_Tile"];
      RETAIN(_tile);
    }
  [self setFrame: NSMakeRect(0,0,serverIconSize.width,serverIconSize.height)];

  return self;
}

- (void) dealloc
{
  RELEASE(_icon);
  TEST_RELEASE(_tile);
  [super dealloc];
}

- (BOOL) acceptsFirstMouse: (NSEvent *) theEvent
{
  return YES;
}

- (void) drawRect: (NSRect) theRect
{
  int v;

  [_tile compositeToPoint: NSMakePoint(0,0)  operation: NSCompositeSourceAtop];

  [_icon compositeToPoint: _borderPoint operation: NSCompositeSourceOver];
  v = number_of_unread_messages();

  if (v > 0)
    {
      draw_value(v);
    }
}

- (void) mouseDown: (NSEvent *) theEvent
{
  [[self superview]  mouseDown: theEvent];
}

@end
#endif



//
//
//
@implementation ApplicationIconController

- (id) init
{
  self = [super init];
  
  _cache = NSCreateMapTable(NSObjectMapKeyCallBacks, NSObjectMapValueCallBacks, 16);

#ifndef MACOSX
  [[[NSApp iconWindow] contentView] addSubview: AUTORELEASE([[ApplicationIconView alloc] init])];
#endif

  [[NSNotificationCenter defaultCenter]
    addObserver: self
    selector: @selector(folderListCompleted:)
    name: PantomimeFolderListCompleted
    object: nil];

 [[NSNotificationCenter defaultCenter]
    addObserver: self
    selector: @selector(connectionTerminated:)
    name: PantomimeConnectionTerminated
    object: nil];
 
 [[NSNotificationCenter defaultCenter]
    addObserver: self
    selector: @selector(folderListCompleted:)
    name: PantomimeFolderListSubscribedCompleted
    object: nil];
  
  return self;
}


//
//
//
- (void) dealloc
{
  [[NSNotificationCenter defaultCenter] removeObserver: self];
  NSFreeMapTable(_cache);  
  [super dealloc];
}

//
//
//
- (void) update
{
#ifndef MACOSX
  [[[NSApp iconWindow] contentView] setNeedsDisplay: YES];
#else
  NSImage *image;
  int v;
  
  image = AUTORELEASE([[NSImage alloc] initWithContentsOfFile: [[NSBundle mainBundle] pathForImageResource: @"GNUMail_128"]]);
  [image lockFocus];
  
  v = number_of_unread_messages();

  if (previous_unread_count != -1 && previous_unread_count < v)
    {
      [NSApp requestUserAttention: NSInformationalRequest];
    }

  previous_unread_count = v;

  if (v > 0)
    {
      draw_value(v);
    }
  
  [image unlockFocus];
  [NSApp setApplicationIconImage: image];
#endif
}

//
//
//
+ (id) singleInstance
{
  if (!singleInstance)
    {
      singleInstance = [[ApplicationIconController alloc] init];
    }

  return singleInstance;
}


//
//
//
- (void) connectionTerminated: (NSNotification *) theNotification
{
  NSMapRemove(_cache, [theNotification object]);
  [self update];
}

//
//
//
- (void) folderListCompleted: (NSNotification *) theNotification
{
  //
  // We skip those notifications for the STATUS'ing task AND
  // we verify if it's our LocalStore (since it's not added to the allStores ivar in MailboxManagerController)
  //
  if ([[[[MailboxManagerController singleInstance] allStores] allValues] containsObject: [theNotification object]] ||
      [[theNotification object] isKindOfClass: [CWLocalStore class]])
    {
      NSMapInsert(_cache, [theNotification object], [[[theNotification userInfo] objectForKey: @"NSEnumerator"] allObjects]);
      [self update];
    }
}
@end
