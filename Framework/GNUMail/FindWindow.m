/*
**  FindWindow.m
**
**  Copyright (c) 2001-2004
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

#include "FindWindow.h"

#include "Constants.h"

#ifdef __MINGW32__
@implementation FindWindowX
#else
@implementation FindWindow
#endif

- (void) dealloc
{
  RELEASE(findField);
  RELEASE(matrix);
  RELEASE(ignoreCaseButton);
  RELEASE(regularExpressionButton);
  RELEASE(findAllButton);
  RELEASE(previousButton);
  RELEASE(nextButton);
  [super dealloc];
}


//
//
//
- (void) layoutWindow
{
  LabelWidget *findLabel;
  NSButtonCell *cell;
  NSBox *box;
  
  findLabel = [LabelWidget labelWidgetWithFrame: NSMakeRect(8,140,60,TextFieldHeight)
			   label: _(@"Find:")
			   alignment: NSRightTextAlignment];
  [findLabel setAutoresizingMask: NSViewMinYMargin];
  [[self contentView] addSubview: findLabel];
  
  findField = [[NSTextField alloc] initWithFrame: NSMakeRect(75,140,260,TextFieldHeight)];
  [findField setAutoresizingMask: NSViewWidthSizable|NSViewMinYMargin];
  [findField setStringValue: @""];
  [findField setTarget: [self windowController]];
  [findField setAction: @selector(findAll:)];
  [[self contentView] addSubview: findField];
  
  box = [[NSBox alloc] initWithFrame: NSMakeRect(5,50,160,80)];
  [box setAutoresizingMask: NSViewWidthSizable|NSViewMaxXMargin|NSViewHeightSizable];
  [box setContentViewMargins: NSMakeSize(8,8)];
  [box setTitle: _(@"Find Scope")];
  [box setTitleFont: [NSFont boldSystemFontOfSize: 12]];
  [box setTitlePosition: NSAtTop];
  [box setBorderType: NSGrooveBorder];
  [[self contentView] addSubview: box];
  RELEASE(box);

  
  cell = [[NSButtonCell alloc] init];
  AUTORELEASE(cell);
  [cell setButtonType: NSRadioButton];
  [cell setBordered: NO];
  [cell setImagePosition: NSImageLeft];

  matrix = [[NSMatrix alloc] initWithFrame: NSZeroRect
			     mode: NSRadioModeMatrix
			     prototype: cell
			     numberOfRows: 2
			     numberOfColumns: 2];
  [matrix setAutoresizingMask: NSViewWidthSizable|NSViewHeightSizable];
  [matrix setTarget: [self windowController]];
  [matrix setIntercellSpacing: NSMakeSize (0, 10)];
  [matrix setAutosizesCells: NO];

  cell = [matrix cellAtRow: 0 column: 0];
  [cell setTitle: _(@"From")];
  [cell setTag: 0];

  cell = [matrix cellAtRow: 1 column: 0];
  [cell setTitle: _(@"To")];
  [cell setTag: 1];

  cell = [matrix cellAtRow: 0 column: 1];
  [cell setTitle: _(@"Subject")];
  [cell setTag: 0];

  cell = [matrix cellAtRow: 1 column: 1];
  [cell setTitle: _(@"Content")];
  [cell setTag: 1];
  
  [matrix sizeToFit];  
  [[box contentView] addSubview: matrix];

  box = [[NSBox alloc] initWithFrame: NSMakeRect(175,50,160,80)];
  [box setAutoresizingMask: NSViewWidthSizable|NSViewMinXMargin|NSViewHeightSizable];
  [box setContentViewMargins: NSMakeSize(0,0)];
  [box setTitle: _(@"Find Options")];
  [box setTitleFont: [NSFont boldSystemFontOfSize: 12]];
  [box setTitlePosition: NSAtTop];
  [box setBorderType: NSGrooveBorder];
  [[self contentView] addSubview: box];
  RELEASE(box);
  
  ignoreCaseButton = [[NSButton alloc] initWithFrame: NSMakeRect(8,33,140,ButtonHeight)];
  [ignoreCaseButton setTitle: _(@"Ignore Case")];
  [ignoreCaseButton setButtonType: NSSwitchButton];
  [ignoreCaseButton setBordered: NO];
  [[box contentView] addSubview: ignoreCaseButton];

  regularExpressionButton = [[NSButton alloc] initWithFrame: NSMakeRect(8,5,140,ButtonHeight)];
  [regularExpressionButton setAutoresizingMask: NSViewMinYMargin];
  [regularExpressionButton setTitle: _(@"Regular Expression")];
  [regularExpressionButton setButtonType: NSSwitchButton];
  [regularExpressionButton setBordered: NO];
  [[box contentView] addSubview: regularExpressionButton];

  findAllButton = [[NSButton alloc] initWithFrame: NSMakeRect(10,10,75,ButtonHeight)];
  [findAllButton setStringValue: _(@"Find All")];
  [findAllButton setTarget: [self windowController]];
  [findAllButton setAction: @selector(findAll:) ];
  [[self contentView] addSubview: findAllButton];
    
  previousButton = [[NSButton alloc] initWithFrame: NSMakeRect(180,10,75,ButtonHeight)];
  [previousButton setAutoresizingMask: NSViewMinXMargin];
  [previousButton setStringValue: _(@"Previous")];
  [previousButton setTarget: [self windowController]];
  [previousButton setAction: @selector(previousMessage:)];
  [[self contentView] addSubview: previousButton];

  nextButton = [[NSButton alloc] initWithFrame: NSMakeRect(260,10,75,ButtonHeight)];
  [nextButton setAutoresizingMask: NSViewMinXMargin];
  [nextButton setStringValue: _(@"Next")];
  [nextButton setTarget: [self windowController]];
  [nextButton setAction: @selector(nextMessage:)];
  [[self contentView] addSubview: nextButton];

  foundLabel = [LabelWidget labelWidgetWithFrame: NSMakeRect(90,13,85,TextFieldHeight)
			    label: @"" ];
  [foundLabel setTextColor: [NSColor darkGrayColor]];

  [[self contentView] addSubview: foundLabel];
}

@end

