/*
**  PasswordPanelController.m
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

#include "PasswordPanelController.h"

#include "GNUMail.h"
#include "Constants.h"

#ifndef MACOSX
#include "PasswordPanel.h"
#endif


//
//
//
@implementation PasswordPanelController

- (id) initWithWindowNibName: (NSString *) windowNibName
{

#ifdef MACOSX
  
  self = [super initWithWindowNibName: windowNibName];
 
#else
  PasswordPanel *aPasswordPanel;
  
  aPasswordPanel = [[PasswordPanel alloc] initWithContentRect: NSMakeRect(200,200,290,150)
					  styleMask: NSTitledWindowMask|NSMiniaturizableWindowMask
					  backing: NSBackingStoreBuffered
					  defer: YES];
  
  self = [super initWithWindow: aPasswordPanel];
  
  [aPasswordPanel layoutPanel];
  [aPasswordPanel setDelegate: self];
 
  // We link our outlets 
  passwordSecureField = aPasswordPanel->passwordSecureField;

  RELEASE(aPasswordPanel);
#endif

  return self;
}


//
//
//
#ifdef MACOSX
- (void) awakeFromNib
{
  [[self window] setInitialFirstResponder: [[passwordSecureField cell] controlView]];
}
#endif


//
//
//
- (void) dealloc
{
  NSDebugLog(@"PasswordPanelController: -dealloc");
  RELEASE(password);

  [super dealloc];
}


//
// action methods
//

- (IBAction) okClicked: (id) sender
{
  [self setPassword: [passwordSecureField stringValue]];
  [NSApp stopModal];
  [self close];
}


- (IBAction) cancelClicked: (id) sender
{
  [self setPassword: nil];
  [NSApp stopModalWithCode: NSRunAbortedResponse];
  [self close];
}


//
// delegate methods
//
- (void) windowWillClose: (NSNotification *) theNotification
{
  // Do nothing
}


//
// access/mutation methods
//
- (NSString *) password
{
  return password;
}


- (void) setPassword: (NSString *) thePassword
{
  if ( thePassword )
    {
      RETAIN(thePassword);
      RELEASE(password);
      password = thePassword;
    }
  else
    {
      DESTROY(password);
    }
}

@end
