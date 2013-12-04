/*
**  PasswordPanel.m
**
**  Copyright (c) 2001, 2002, 2003
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

#include "PasswordPanel.h"

#include "Constants.h"
#include "LabelWidget.h"

@implementation PasswordPanel


//
//
//
- (void) dealloc
{
  NSDebugLog(@"PasswordPanel: -dealloc");

  RELEASE(passwordSecureField);
  [super dealloc];
}


//
//
//
- (void) layoutPanel
{
  NSButton *okButton, *cancelButton;
  LabelWidget *passwordLabel;
  NSImageView *icon;
  
  icon = [[NSImageView alloc] initWithFrame: NSMakeRect(10,90,48,48)];
  [icon setImageAlignment: NSImageAlignCenter];
  [icon setImage: [NSImage imageNamed: @"pgp-mail.tiff"]];
  [icon setImageFrameStyle: NSImageFrameNone];
  [icon setEditable: NO];
  [[self contentView] addSubview: icon];
  RELEASE(icon);


  passwordLabel = [LabelWidget labelWidgetWithFrame: NSMakeRect(80,90,250,TextFieldHeight)
			       label: _(@"Please enter your password:")];
  [passwordLabel setFont: [NSFont systemFontOfSize: 14]];
  [[self contentView] addSubview: passwordLabel];
  
  passwordSecureField = [[NSSecureTextField alloc] initWithFrame: NSMakeRect(20,50,250,TextFieldHeight)];
  [passwordSecureField setSelectable: YES];
  [passwordSecureField setTarget: [self windowController]];
  [passwordSecureField setAction: @selector(okClicked:)];
  [[self contentView] addSubview: passwordSecureField];
  
  cancelButton = [[NSButton alloc] initWithFrame: NSMakeRect(110,10,75,ButtonHeight)];
  [cancelButton setButtonType: NSMomentaryPushButton];
  [cancelButton setKeyEquivalent: @"\e"];
  [cancelButton setTitle: _(@"Cancel")];
  [cancelButton setTarget: [self windowController]];
  [cancelButton setAction: @selector(cancelClicked:)];
  [[self contentView] addSubview: cancelButton];
  RELEASE(cancelButton);

  okButton = [[NSButton alloc] initWithFrame:  NSMakeRect(195,10,75,ButtonHeight)];
  [okButton setButtonType: NSMomentaryPushButton];
  [okButton setKeyEquivalent: @"\r"];
  [okButton setImagePosition: NSImageRight];
  [okButton setImage: [NSImage imageNamed: @"common_ret"]];
  [okButton setAlternateImage: [NSImage imageNamed: @"common_retH"]];
  [okButton setTitle: _(@"OK")];
  [okButton setTarget: [self windowController]];
  [okButton setAction: @selector(okClicked:)];
  [[self contentView] addSubview:okButton];
  RELEASE(okButton);

  // We set the initial responder and the next key views
  [self setInitialFirstResponder: passwordSecureField];
  [passwordSecureField setNextKeyView: cancelButton];
  [cancelButton setNextKeyView: okButton];
  [okButton setNextKeyView: passwordSecureField];
}

@end
