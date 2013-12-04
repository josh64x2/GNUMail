/*
**  WelcomePanel.m
**
**  Copyright (c) 2006-2007
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

#include "WelcomePanel.h"

#include "Constants.h"
#include "LabelWidget.h"
#include "Utilities.h"

@implementation WelcomePanel

- (void) _cancelClicked: (id) sender
{
  [NSApp stopModalWithCode: NSRunAbortedResponse]; 
}

- (void) _continueClicked: (id) sender
{
  [NSApp stopModal];
}

- (void) layoutWindow
{
  NSButton *cancelButton, *continueButton;
  LabelWidget *label;
  NSButtonCell *cell;
  NSImageView *icon;
  
  icon = [[NSImageView alloc] initWithFrame: NSMakeRect(-25,147,128,128)];
  [icon setImageAlignment: NSImageAlignLeft];
  [icon setImage: [NSImage imageNamed: @"GNUMail_128"]];
  [icon setImageFrameStyle: NSImageFrameNone];
  [[self contentView] addSubview: icon];
  RELEASE(icon);
  
  label = [LabelWidget labelWidgetWithFrame: NSMakeRect(81,230,290,32)
		       label: @"Welcome to GNUMail!"
		       alignment: NSLeftTextAlignment];
  [label setFont: [NSFont boldSystemFontOfSize: 24]];
  [[self contentView] addSubview: label];

#ifdef GNUSTEP
  label = [LabelWidget labelWidgetWithFrame: NSMakeRect(81,185,304,50)
#else
  label = [LabelWidget labelWidgetWithFrame: NSMakeRect(81,175,304,50)
#endif
		       label: _(@"You need to configure GNUMail before using it.")
		       alignment: NSLeftTextAlignment];
  [[self contentView] addSubview: label];
  
#ifdef GNUSTEP
  label = [LabelWidget labelWidgetWithFrame: NSMakeRect(16,100,385,50)
#else
  label = [LabelWidget labelWidgetWithFrame: NSMakeRect(16,90,385,50)		       
#endif
		       label: @"Please choose your preferred local storage format:\n(if unsure, choose the UNIX mbox format)"
		       alignment: NSLeftTextAlignment];
  [[self contentView] addSubview: label];

  cell = [[NSButtonCell alloc] init];
  [cell setButtonType: NSRadioButton];
  [cell setBordered: NO];
  [cell setImagePosition: NSImageLeft];

  matrix = [[NSMatrix alloc] initWithFrame:NSMakeRect(16,46,250,50)
			     mode: NSRadioModeMatrix
			     prototype: cell
			     numberOfRows: 2
			     numberOfColumns: 1];
  [matrix setIntercellSpacing: NSMakeSize(0, 5)];
  [matrix setAutosizesCells: NO];
  [matrix setAllowsEmptySelection: NO];
  RELEASE(cell);

  [[matrix cellAtRow: 0  column: 0] setTitle: _(@"Standard UNIX mbox format")];
  [[matrix cellAtRow: 1  column: 0] setTitle: _(@"Maildir mailbox format")];
#ifndef GNUSTEP
  [matrix sizeToFit];
#endif
  [[self contentView] addSubview: matrix];
  RELEASE(matrix);

  cancelButton = [[NSButton alloc] initWithFrame: NSMakeRect(230,12,70,25)];
  [cancelButton setTitle: _(@"Cancel")];
  [cancelButton setTarget: self];
  [cancelButton setAction: @selector(_cancelClicked:)];
#ifndef GNUSTEP
  [cancelButton setBezelStyle: NSRoundedBezelStyle];
#endif
  [[self contentView] addSubview: cancelButton];
  RELEASE(cancelButton);
  
  continueButton = [[NSButton alloc] initWithFrame: NSMakeRect(310,12,80,25)];
  [continueButton setTitle: _(@"Continue")];
  [continueButton setTarget: self];
  [continueButton setKeyEquivalent: @"\r"];
#ifdef GNUSTEP
  [continueButton setImagePosition: NSImageRight];
  [continueButton setImage: [NSImage imageNamed: @"common_ret"]];
  [continueButton setAlternateImage: [NSImage imageNamed: @"common_retH"]];
#else
  [continueButton setBezelStyle: NSRoundedBezelStyle];
#endif
  [continueButton setAction: @selector(_continueClicked:)];
  [[self contentView] addSubview: continueButton];
  RELEASE(continueButton);

  [self setContentSize: NSMakeSize(400,275)];
}
		       
- (NSMatrix *) matrix
{
  return matrix;
}

@end





