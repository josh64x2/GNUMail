/*
**  MIMEView.h
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

#ifndef _GNUMail_H_MIMEView
#define _GNUMail_H_MIMEView

#import <AppKit/AppKit.h>

@interface MIMEView : NSView
{
  @public
    NSTableView *tableView;
    NSTableColumn *mimeTypesColumn, *fileExtensionsColumn;
    NSButton *add, *delete, *edit;
    NSScrollView *scrollView;

  @private
    id parent;
}

- (id) initWithParent: (id) theParent;
- (void) layoutView;
- (void) dealloc;

@end

#endif // _GNUMail_H_MIMEView
