/*
**  AboutPanelController.m
**
**  Copyright (c) 2002-2005
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

#include "AboutPanelController.h"

#ifndef MACOSX
#include "AboutPanel.h"
#else
#include "Utilities.h"
#endif

#include "Constants.h"

static AboutPanelController *singleInstance = nil;

//
//
//
@implementation AboutPanelController

- (id) initWithWindowNibName: (NSString *) windowNibName
{
#ifdef MACOSX
  
  self = [super initWithWindowNibName: windowNibName];
  
#else
  AboutPanel *aboutPanel;

  aboutPanel = [[AboutPanel alloc] initWithContentRect: NSMakeRect(100,100,490,470)
				   styleMask: NSTitledWindowMask|NSClosableWindowMask
				   backing: NSBackingStoreBuffered
				   defer: NO];
  
  self = [super initWithWindow: aboutPanel];
  
  [aboutPanel layoutWindow];
  [aboutPanel setDelegate: self];
  
  RELEASE(aboutPanel);
#endif

  [[self window] setTitle: _(@"About GNUMail")];
  
  // We finally set our autosave window frame name and restore the one from the user's defaults.
  [[self window] setFrameAutosaveName: @"AboutPanel"];
  [[self window] setFrameUsingName: @"AboutPanel"];
 
  return self;
}


//
//
//
- (void) dealloc
{
  NSDebugLog(@"AboutPanelController: -dealloc");
  singleInstance = nil;
  [super dealloc];
}


//
// action methods
//


//
// delegate methods
//
- (void) windowWillClose: (NSNotification *) theNotification
{
  AUTORELEASE(self);
}

//
//
//
- (void) windowDidLoad
{
#ifdef MACOSX
  [[self window] setBackgroundColor: [NSColor whiteColor]];
  [(NSPanel *)[self window] setFloatingPanel: YES];
  [versionLabel setStringValue: [NSString stringWithFormat: _(@"GNUMail Version %@  - http://www.collaboration-world.com/gnumail"), GNUMailVersion()]];
#endif
}


//
// class methods
//
+ (id) singleInstance
{
  if ( !singleInstance )
    {
      singleInstance = [[AboutPanelController alloc] initWithWindowNibName: @"AboutPanel"];
    }

  return singleInstance;
}

@end
