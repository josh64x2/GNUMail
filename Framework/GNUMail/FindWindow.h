/*
**  FindWindow.h
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

#ifndef _GNUMail_H_FindWindow
#define _GNUMail_H_FindWindow

#import <AppKit/AppKit.h>

#include "LabelWidget.h"

#ifdef __MINGW32__
@interface FindWindowX: NSPanel
#else
@interface FindWindow: NSPanel
#endif
{
  @public
    NSTextField *findField;
    LabelWidget *foundLabel;
    NSMatrix *matrix;
    NSButton *ignoreCaseButton;
    NSButton *regularExpressionButton;
    NSButton *findAllButton;
    NSButton *previousButton;
    NSButton *nextButton;
}

- (void) layoutWindow;

@end

#endif // _GNUMail_H_FindWindow
