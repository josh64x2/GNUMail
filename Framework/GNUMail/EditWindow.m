/*
**  EditWindow.m
**
**  Copyright (c) 2001-2007
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

#include "EditWindow.h"
#include "ExtendedTextView.h"
#include "AutoCompletingTextField.h"

#include "Constants.h"
#include "LabelWidget.h"

@implementation EditWindow

//
//
//
- (void) dealloc
{
  NSDebugLog(@"EditWindow: -dealloc");

  RELEASE(scrollView);
  RELEASE(textView);

  RELEASE(fromLabel);
  RELEASE(accountPopUpButton);
  RELEASE(usingLabel);
  RELEASE(transportMethodPopUpButton);

  RELEASE(toLabel);
  RELEASE(toText);

  RELEASE(ccLabel);
  RELEASE(ccText);

  RELEASE(bccLabel);
  RELEASE(bccText);

  RELEASE(subjectLabel);
  RELEASE(subjectText);

  RELEASE(sizeLabel);

  [super dealloc];
}

//
//
//
- (void) layoutWindow
{ 
  // From
  fromLabel = [LabelWidget labelWidgetWithFrame: NSMakeRect(5,490,50,21) 
			   label: _(@"From:")
			   alignment: NSRightTextAlignment];
  [fromLabel setAutoresizingMask: NSViewMinYMargin];
  RETAIN(fromLabel);
  
  accountPopUpButton = [[NSPopUpButton alloc] initWithFrame: NSMakeRect(65,490,300,ButtonHeight)];
  [accountPopUpButton setAutoresizingMask: NSViewMinYMargin|NSViewWidthSizable];
  [accountPopUpButton setTarget: [self windowController]];
  [accountPopUpButton setAction: @selector(accountSelectionHasChanged:)];
  
  // Using
  usingLabel = [LabelWidget labelWidgetWithFrame: NSMakeRect(370,490,50,21) 
			    label: _(@"Using:")
			    alignment: NSRightTextAlignment];
  [usingLabel setAutoresizingMask: NSViewMinXMargin|NSViewMinYMargin];
  RETAIN(usingLabel);
  
  transportMethodPopUpButton = [[NSPopUpButton alloc] initWithFrame: NSMakeRect(430,490,300,ButtonHeight)];
  [transportMethodPopUpButton setAutoenablesItems: NO];
  [transportMethodPopUpButton setAutoresizingMask: NSViewMinXMargin|NSViewMinYMargin];
  [transportMethodPopUpButton addItemWithTitle: @"smtp.server.com"];

  // To 
  toLabel = [LabelWidget labelWidgetWithFrame: NSMakeRect(5,465,50,21) 
			 label: _(@"To:")
			 alignment: NSRightTextAlignment];
  [toLabel setAutoresizingMask: NSViewMinYMargin];
  RETAIN(toLabel);
  
  toText = [[AutoCompletingTextField alloc] initWithFrame: NSMakeRect(65,465,665,21)];
  [toText setAutoresizingMask: NSViewMinYMargin|NSViewWidthSizable];
  [[toText cell] setScrollable: YES];
  [toText setDelegate: [self windowController]];
 
  // Cc
  ccLabel = [LabelWidget labelWidgetWithFrame: NSZeroRect
			 label: _(@"Cc:")
			 alignment: NSRightTextAlignment];
  [ccLabel setAutoresizingMask: NSViewMinYMargin];
  RETAIN(ccLabel);

  ccText = [[AutoCompletingTextField alloc] init];
  [ccText setAutoresizingMask: NSViewMinYMargin|NSViewWidthSizable];
  [[ccText cell] setScrollable: YES];
  [ccText setDelegate: [self windowController]];

  // Bcc
  bccLabel = [LabelWidget labelWidgetWithFrame: NSZeroRect
			  label: _(@"Bcc:")
			  alignment: NSRightTextAlignment];
  [bccLabel setAutoresizingMask: NSViewMinYMargin];
  RETAIN(bccLabel);

  bccText = [[AutoCompletingTextField alloc] init];
  [bccText setAutoresizingMask: NSViewMinYMargin|NSViewWidthSizable];
  [[bccText cell] setScrollable: YES];
  [bccText setDelegate: [self windowController]];

  // Subject
  subjectLabel = [LabelWidget labelWidgetWithFrame: NSZeroRect
			      label: _(@"Subject:")
			      alignment: NSRightTextAlignment];
  [subjectLabel setAutoresizingMask: NSViewMinYMargin];
  RETAIN(subjectLabel);

  subjectText = [[NSTextField alloc] init];
  [subjectText setAutoresizingMask: NSViewMinYMargin|NSViewWidthSizable];
  [subjectText setDelegate: [self windowController]];

  // Size
  sizeLabel = [LabelWidget labelWidgetWithFrame: NSMakeRect(5,420,740,TextFieldHeight)
			   label: @"0 KB"];
  [sizeLabel setFont: [NSFont systemFontOfSize: 10]];
  [sizeLabel setTextColor: [NSColor darkGrayColor]];
  [sizeLabel setAutoresizingMask: NSViewMinYMargin|NSViewWidthSizable];
  RETAIN(sizeLabel);

  // Scrollview and text view
  scrollView = [[NSScrollView alloc] initWithFrame: NSMakeRect(5,5,740,415)];
  [scrollView setBorderType: NSBezelBorder];
  [scrollView setHasHorizontalScroller: NO];
  [scrollView setHasVerticalScroller: YES];
  [scrollView setAutoresizingMask: NSViewHeightSizable|NSViewWidthSizable];
  [[scrollView contentView] setAutoresizingMask: NSViewHeightSizable|NSViewWidthSizable];
  [[scrollView contentView] setAutoresizesSubviews:YES];
  
  textView = [[ExtendedTextView alloc] initWithFrame: [[scrollView contentView] frame]];
  [textView setDelegate: [self windowController]];
  [textView setTextContainerInset: NSMakeSize(5,5)];
  [textView setBackgroundColor: [NSColor textBackgroundColor]];
  [textView setRichText: YES];
  [textView setUsesFontPanel: YES];
  [textView setHorizontallyResizable: NO];
  [textView setVerticallyResizable: YES];
  [textView setMinSize: NSMakeSize (0, 0)];
  [textView setMaxSize: NSMakeSize (1E7, 1E7)];
  [textView setAutoresizingMask: NSViewWidthSizable];
  [[textView textContainer] setContainerSize: NSMakeSize([[scrollView contentView] frame].size.width, 1E7)];
  [[textView textContainer] setWidthTracksTextView: YES];
  [textView setEditable: YES];
  [textView setString: @""];
  [textView registerForDraggedTypes: [NSArray arrayWithObjects: MessagePboardType, NSFilenamesPboardType,nil]];
  
  [subjectText setNextKeyView: textView];
  [scrollView setDocumentView: textView];
  
  // We add our UI elemnts
  [[self contentView] addSubview: fromLabel];
  [[self contentView] addSubview: accountPopUpButton];
  [[self contentView] addSubview: usingLabel];
  [[self contentView] addSubview: transportMethodPopUpButton];

  [[self contentView] addSubview: toLabel];
  [[self contentView] addSubview: toText];

  [[self contentView] addSubview: subjectLabel];
  [[self contentView] addSubview: subjectText];

  [[self contentView] addSubview: sizeLabel];
  [[self contentView] addSubview: scrollView];

  [self setMinSize: NSMakeSize(700,450)];
}

@end


