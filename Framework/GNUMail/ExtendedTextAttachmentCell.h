/*
**  ExtendedTextAttachmentCell.h
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

#ifndef _GNUMail_H_ExtendedTextAttachmentCell
#define _GNUMail_H_ExtendedTextAttachmentCell

#import <AppKit/AppKit.h>

@class CWPart;

@interface ExtendedTextAttachmentCell : NSTextAttachmentCell
{
  @private
    NSAttributedString *_attributedString;
    CWPart *_part;
}


//
//
//
- (id) initWithFilename: (NSString *) theFilename
                   size: (int) theSize;


//
// access/mutation methods
//
- (CWPart *) part;
- (void) setPart: (CWPart *) thePart;

@end

#endif // _GNUMail_H_ExtendedTextAttachmentCell
