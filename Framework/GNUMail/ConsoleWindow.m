/*
**  ConsoleWindow.m
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

#include "ConsoleWindow.h"

#include "Constants.h"
#include "ExtendedTableView.h"

@implementation ConsoleWindow

//
//
//
- (void) dealloc
{
  NSDebugLog(@"ConsoleWindow: -dealloc");
  
  RELEASE(tasksTableView);
  RELEASE(tasksScrollView);
  RELEASE(messagesTableView);
  RELEASE(messagesScrollView);
  [super dealloc];
}


//
//
//
- (void) layoutWindow
{
  NSTableColumn *statusColumn, *dateColumn, *messageColumn;
  NSTabViewItem *tabViewItem1, *tabViewItem2;
  NSTabView *tabView;
  
  //
  // Our tab view
  //
  tabView = [[NSTabView alloc] initWithFrame: NSMakeRect(0,0,500,278)];
  [tabView setAutoresizingMask: NSViewWidthSizable|NSViewHeightSizable];

  //
  // Our first tabview
  //
  statusColumn = [(NSTableColumn *)[NSTableColumn alloc] initWithIdentifier: @"Status"];
  [statusColumn setEditable: NO];
  [statusColumn setResizable: YES];
  [[statusColumn headerCell] setStringValue: _(@"Status")];
  [[statusColumn headerCell] setAlignment: NSLeftTextAlignment];

  tasksScrollView = [[NSScrollView alloc] initWithFrame: NSMakeRect(0,0,495,275)];

  tasksTableView = [[ExtendedTableView alloc] initWithFrame: [[tasksScrollView contentView] frame]];
  [tasksTableView setAutoresizingMask: NSViewWidthSizable|NSViewHeightSizable];
  [tasksTableView setDrawsGrid: YES];
  [tasksTableView setRowHeight: 46];
  [tasksTableView setAllowsColumnSelection: NO];
  [tasksTableView setAllowsColumnReordering: NO];
  [tasksTableView setAllowsColumnResizing: YES];
  [tasksTableView setAllowsEmptySelection: YES];
  [tasksTableView setAllowsMultipleSelection: NO];
  [tasksTableView addTableColumn: statusColumn];
  [tasksTableView setAutoresizesAllColumnsToFit: YES];
  [tasksTableView sizeLastColumnToFit];
  [tasksTableView setAction: @selector(clickedOnTableView:)];
  [tasksTableView setDataSource: [self windowController]];
  [tasksTableView setDelegate: [self windowController]];
  RELEASE(statusColumn);

  [tasksScrollView setDocumentView: tasksTableView];
  [tasksScrollView setHasHorizontalScroller: NO];
  [tasksScrollView setHasVerticalScroller: YES];
  [tasksScrollView setBorderType: NSBezelBorder];
  [tasksScrollView setAutoresizingMask: NSViewWidthSizable|NSViewHeightSizable];
  
  //
  // Our second item
  //
  tabViewItem1 = [(NSTableColumn *)[NSTabViewItem alloc] initWithIdentifier: @"Activities"];
  [tabViewItem1 setLabel: _(@"Activities")];
  [tabViewItem1 setView: tasksScrollView];
  [tabView addTabViewItem: tabViewItem1];
  RELEASE(tabViewItem1);


  //
  // Our second tabview
  //
  messageColumn = [(NSTableColumn *)[NSTableColumn alloc] initWithIdentifier: @"Message"];
  [messageColumn setEditable: NO];
  [messageColumn setResizable: YES];
  [[messageColumn headerCell] setStringValue: _(@"Message")];
  [messageColumn setMinWidth: 115];
  
  dateColumn = [(NSTableColumn *)[NSTableColumn alloc] initWithIdentifier: @"Message Date"];
  [dateColumn setEditable: NO];
  [dateColumn setResizable: YES];
  [[dateColumn headerCell] setStringValue: _(@"Date")];
  [dateColumn setMinWidth: 60];
  [dateColumn setMaxWidth: 60];

  messagesScrollView = [[NSScrollView alloc] initWithFrame: NSMakeRect(5,35,470,100)];

  messagesTableView = [[NSTableView alloc] initWithFrame: [[messagesScrollView contentView] frame]];
  [messagesTableView setAutoresizingMask: NSViewWidthSizable|NSViewHeightSizable];
  [messagesTableView setDrawsGrid: NO];
  [messagesTableView setAllowsColumnSelection: NO];
  [messagesTableView setAllowsColumnReordering: NO];
  [messagesTableView setAllowsColumnResizing: YES];
  [messagesTableView setAllowsEmptySelection: YES];
  [messagesTableView setAllowsMultipleSelection: NO];
  [messagesTableView addTableColumn: messageColumn];
  [messagesTableView addTableColumn: dateColumn];
  [messagesTableView setAutoresizesAllColumnsToFit: YES];
  [messagesTableView sizeLastColumnToFit];
  [messagesTableView setDataSource: [self windowController]];
  [messagesTableView setDelegate: [self windowController]];
  RELEASE(messageColumn);
  RELEASE(dateColumn);

  [messagesScrollView setDocumentView: messagesTableView];
  [messagesScrollView setHasHorizontalScroller: NO];
  [messagesScrollView setHasVerticalScroller: YES];
  [messagesScrollView setBorderType: NSBezelBorder];
  [messagesScrollView setAutoresizingMask: NSViewWidthSizable|NSViewHeightSizable];

  tabViewItem2 = [(NSTableColumn *)[NSTabViewItem alloc] initWithIdentifier: @"Messages"];
  [tabViewItem2 setLabel: _(@"Messages")];
  [tabViewItem2 setView: messagesScrollView];
  [tabView addTabViewItem: tabViewItem2];
  RELEASE(tabViewItem2);
  
  //
  // We add our tabView
  //
  [[self contentView] addSubview: tabView];
  RELEASE(tabView);

  //
  // We set the window's minimum size
  //
  //[self setMinSize: NSMakeSize(400,320)];
}

@end
