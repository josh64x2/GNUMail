/*
**  MailHeaderCell.h
**
**  Copyright (c) 2002-2004
**
**  Author: Nicolas Roard <nicolas@roard.com>
**          Ludovic Marcotte <ludovic@Sophos.ca>
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

#ifndef _GNUMail_H_MailHeaderCell
#define _GNUMail_H_MailHeaderCell

#import <AppKit/AppKit.h>

//
//
//
@interface MailHeaderCell : NSTextAttachmentCell
{
  NSAttributedString *_originalAttributedString;
  NSMutableArray *_allViews;
  NSColor *_color;
  id _controller;

  float _width;
}

//
// access / mutation methods
//
- (float) height;
- (float) width;
- (void) resize: (id) sender;
- (void) setWidth: (float) theWidth;
- (void) setColor: (NSColor *) theColor;

- (void) setController: (id) theController;

//
// other methods
//
- (void) addView: (id) theView;
- (BOOL) containsView: (id) theView;

@end

#endif // _GNUMail_H_MailHeaderCell
