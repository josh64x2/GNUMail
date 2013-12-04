/*
**  AboutPanel.m
**
**  Copyright (c) 2002-2007
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

#include "AboutPanel.h"

#include "Constants.h"
#include "LabelWidget.h"
#include "Utilities.h"

@implementation AboutPanel

//
//
//
- (void) layoutWindow
{
  LabelWidget *label;
  NSButton *icon;

  [self setBackgroundColor: [NSColor whiteColor]];

  icon = [[NSButton alloc] initWithFrame: NSMakeRect(0,65,180,400)];
  [icon setImagePosition: NSImageOnly];
  [icon setImage: [NSImage imageNamed: @"GNUMail_big"]];
  [icon setBordered: NO];
  [icon setTarget: [NSApp delegate]];
  [icon setAction: @selector(orderFrontSharedMemoryPanel:)];
  [[self contentView] addSubview: icon];
  RELEASE(icon);

  //
  // App's title
  //
  label = [LabelWidget labelWidgetWithFrame: NSMakeRect(190,385,295,50)
		       label: @"GNUMail"
		       alignment: NSLeftTextAlignment];
  [label setFont: [NSFont boldSystemFontOfSize: 40]];
  [[self contentView] addSubview: label];

  
  //
  // Main author
  //
  label = [LabelWidget labelWidgetWithFrame: NSMakeRect(200,355,430,20)
		       label: _(@"Main author:")
		       alignment: NSLeftTextAlignment];
  [label setFont: [NSFont boldSystemFontOfSize: 14]];
  [[self contentView] addSubview: label];

  label = [LabelWidget labelWidgetWithFrame: NSMakeRect(210,335,430,20)
		       label: @"Ludovic Marcotte <ludovic@Sophos.ca>"
		       alignment: NSLeftTextAlignment];
  [[self contentView] addSubview: label];

  //
  // Contributors
  //
  label = [LabelWidget labelWidgetWithFrame: NSMakeRect(200,305,430,20)
		       label: _(@"Contributors:")
		       alignment: NSLeftTextAlignment];
  [label setFont: [NSFont boldSystemFontOfSize: 14]];
  [[self contentView] addSubview: label];

  label = [LabelWidget labelWidgetWithFrame: NSMakeRect(210,205,430,110)
		       label: @"Ken Ferry, Francis Lachapelle\nBjorn Giesler, Jonathan B. Leffert\nVincent Ricard, Pierre-Yves Rivaille\nNicolas Roard, Jesse Ross\nUjwal S. Setlur"
		       alignment: NSLeftTextAlignment];
  [[self contentView] addSubview: label];

  
  //
  // Special thanks
  //
  label = [LabelWidget labelWidgetWithFrame: NSMakeRect(200,185,430,20)
		       label: _(@"Special thanks:")
		       alignment: NSLeftTextAlignment];
  [label setFont: [NSFont boldSystemFontOfSize: 14]];
  [[self contentView] addSubview: label];
  
  label = [LabelWidget labelWidgetWithFrame: NSMakeRect(210,40,430,145)
		       label: @"Matt Ackeret, Luis Garcia Alanis\nMartin Brecher\nErik Dalen\nAndrew Lindesay\nJeff Meininger\nStéphane Peron\nJeff Teunissen\nQuique"
		       alignment: NSLeftTextAlignment];
  [[self contentView] addSubview: label];

  //
  // Bottom labels
  //
  label = [LabelWidget labelWidgetWithFrame: NSMakeRect(10,20,460,15)
		       label: [NSString stringWithFormat: _(@"GNUMail Version %@  -  http://www.collaboration-world.com/gnumail"), GNUMailVersion()]
		       alignment: NSLeftTextAlignment];
  [label setTextColor: [NSColor darkGrayColor]];
  [[self contentView] addSubview: label];
  
  label = [LabelWidget labelWidgetWithFrame: NSMakeRect(10,5,460,15)
		       label: _(@"(c) 1998-2007 Ludovic Marcotte and contributors.")
		       alignment: NSLeftTextAlignment];
  [label setTextColor: [NSColor darkGrayColor]];
  [[self contentView] addSubview: label];
}

@end





