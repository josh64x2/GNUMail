/*
**  PreferencesModule.h
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

#ifndef _GNUMail_H_PreferencesModule
#define _GNUMail_H_PreferencesModule

#import <AppKit/AppKit.h>

@protocol PreferencesModule

- (id) initWithNibName: (NSString *) theName;
- (void) dealloc;

- (NSImage *) image;
- (NSString *) name;
- (NSView *) view;

- (BOOL) hasChangesPending;
- (void) initializeFromDefaults;
- (void) saveChanges;


//
// class methods
//
+ (id) singleInstance;

@end

#endif // _GNUMail_H_PreferencesModule
