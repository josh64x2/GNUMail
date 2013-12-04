/*
**  MailHeaderCell.m
**
**  Copyright (c) 2002-2007
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

#include "MailHeaderCell.h"

#include "GNUMail.h"
#include "Constants.h"
#include "MailWindowController.h"
#include "NSBezierPath+Extensions.h"
#include "NSUserDefaults+Extensions.h"

#include <Pantomime/CWFolder.h>


//
//
//
@implementation MailHeaderCell

- (id) init 
{
  self = [super init];

  [self setColor: nil];
  _width = 0;

  _allViews = [[NSMutableArray alloc] init];

  return self;
}


//
//
//
- (void) dealloc
{
  RELEASE(_originalAttributedString);
  RELEASE(_allViews);
  RELEASE(_color);
  [super dealloc];
}



//
//
//
- (float) height
{
  float h;

#ifdef MACOSX
  h = [[self attributedStringValue] size].height+5;
#else
  h = [[self attributedStringValue] size].height+20;
#endif

  //
  // We want the MailHeaderCell to be at least as high
  // as the ThreadArcsCell, which needs a minimum height.
  //
  if ([[_controller folder] allContainers])
    {
      if (h < THREAD_ARCS_CELL_MIN_HEIGHT)
        h = THREAD_ARCS_CELL_MIN_HEIGHT;
    }
  return h;
}


//
//
//
- (float) width
{
  return _width;
}


//
//
//
- (void) setWidth: (float) theWidth
{
  _width = theWidth;
}


//
//
//
- (void) setColor: (NSColor *) theColor
{
  if (theColor)
    {
      ASSIGN(_color, theColor);
    }
  else
    {
      RELEASE(_color);

      _color = [[NSUserDefaults standardUserDefaults] colorForKey: @"MAILHEADERCELL_COLOR"];
      
      if (!_color)
	{
	  _color = [NSColor colorWithCalibratedWhite: 0.9 alpha: 1.0];
	}
      
      RETAIN(_color);
    }
}


//
//
//
- (NSSize) cellSize
{
  return NSMakeSize(_width, [self height]);
}


//
// other methods
//
- (void) addView: (id) theView
{
  if (theView)
    {
      [_allViews addObject: theView];
    }
}


//
//
//
- (BOOL) containsView: (id) theView
{
  return [_allViews containsObject: theView];
}


//
//
//
- (void) resize: (id) sender
{
  NSRect aRect;
  
  aRect = [[_controller textView] frame];
  
  //if (!NSEqualSizes(aRect.size, NSMakeSize(width, aRect.size.height)))
    {
      if ([[_controller folder] allContainers])
	{
	  _width = aRect.size.width-THREAD_ARCS_CELL_WIDTH-10;
	}
      else
	{
	  _width = aRect.size.width;
	}

      //[super setAttributedStringValue: [self _fold]];
    }
}


//
//
//
- (void) setAttributedStringValue: (NSAttributedString *) theAttributedString
{
  ASSIGN(_originalAttributedString, theAttributedString);
  [super setAttributedStringValue: theAttributedString];
}


//
// No need to retain here.
//
- (void) setController: (id) theController
{
  _controller = theController;
}


//
//
//
- (void) drawWithFrame: (NSRect) theFrame
		inView: (NSView *) theView
{  
  NSBezierPath *aRoundRect;
  NSView *aView;
  NSSize aSize;
  
  float current_x, current_y, delta;
  int i;
  
  if (![theView window])
    {
      return;
    }

  // We fill our cell
#ifdef MACOSX
  theFrame.origin.y += 4;
#endif
  theFrame.size.width -= 10;
  [_color set];
  aRoundRect = [NSBezierPath bezierPath];
  [aRoundRect appendBezierPathWithRoundedRectangle: theFrame
                                        withRadius: 8.0];
  [aRoundRect fill];
  
  current_x = theFrame.origin.x + theFrame.size.width;
  delta = 0;

  for (i = 0; i < [_allViews count]; i++)
    {
      aView = [_allViews objectAtIndex: i];

      // If our bundle doesn't provide an image, we draw it's view
      if (![aView respondsToSelector: @selector(image)])
	{
	  if (NSEqualRects([aView frame], NSZeroRect))
	    {
	      continue;
	    }

	  aSize = [aView frame].size;
	  current_x = current_x - aSize.width - 10;
	  current_y = theFrame.origin.y + aSize.height + (theFrame.size.height - aSize.height)/2;
	  delta += aSize.width;

	  [aView drawRect: NSMakeRect(current_x, current_y, aSize.width, aSize.height)];
	}
      else
	{
	  NSImage *aImage;

	  aImage = [(id)aView image];
	  
	  if (!aImage)
	    {
	      continue;
	    }
	  
	  aSize = [aImage size];
	  
	  current_x = current_x - aSize.width - 10;
	  current_y = theFrame.origin.y + aSize.height + (theFrame.size.height - aSize.height)/2;
	  delta += aSize.width;

	  [aImage compositeToPoint: NSMakePoint(current_x, current_y)
		  operation: NSCompositeSourceAtop];
	}
    }

  // We adjust our frame and we draw our attributed string
  theFrame.origin.x += 8; 
  theFrame.size.width -= (16+delta);
  theFrame.origin.y += 10;
  theFrame.size.height -= 20;

  [[self attributedStringValue] drawInRect: theFrame];
}
@end
