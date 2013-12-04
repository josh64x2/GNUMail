/*
**  FilterMessageWindowController.m
**
**  Copyright (c) 2001-2006
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

#include "FilterMessageWindowController.h"

#include "Constants.h"

#ifndef MACOSX
#include "FilterMessageWindow.h"
#endif

@implementation FilterMessageWindowController

- (id) initWithWindowNibName: (NSString *) windowNibName
{
#ifdef MACOSX
  
  self = [super initWithWindowNibName: windowNibName];
  
#else
  FilterMessageWindow *filterMessageWindow;

  filterMessageWindow = [[FilterMessageWindow alloc] initWithContentRect:NSMakeRect(100,100,500,250)
						     styleMask: (NSTitledWindowMask
								 | NSClosableWindowMask
								 | NSResizableWindowMask)
						     backing: NSBackingStoreBuffered
						     defer: NO];

  self = [super initWithWindow: filterMessageWindow];
  
  [filterMessageWindow layoutWindow];
  [filterMessageWindow setDelegate: self];

  // We set out outlets
  textView = [filterMessageWindow textView];

  RELEASE(filterMessageWindow);
#endif

  [[self window] setTitle: @""];

  return self;
}


- (void) dealloc
{
  NSDebugLog(@"FilterMessageWindowController: -dealloc");

  RELEASE(messageString);
  
  [super dealloc];
}


//
// delegate methods
//

- (void) windowWillClose: (NSNotification *) theNotification
{
  // do nothing
}


- (void) windowDidLoad
{
 
}

//
// action methods
//

- (IBAction) cancelClicked: (id) sender
{
  [NSApp stopModal];
  [self close];
}

- (IBAction) okClicked: (id) sender
{
  [self setMessageString: [textView string]];
  [NSApp stopModalWithCode: NSRunAbortedResponse];
  [self close];
}


//
// access/mutation methods
//
- (NSString *) messageString
{
  return messageString;
}

- (void) setMessageString: (NSString*) theMessageString
{
  RETAIN(theMessageString);
  RELEASE(messageString);
  messageString = theMessageString;

  [textView setString: messageString];
}


@end
