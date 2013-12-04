/*
**  GNUMail+MenuValidation.m
**
**  Copyright (c) 2007
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

#include "GNUMail+MenuValidation.h"

#include "Constants.h"
#include "EditWindowController.h"
#include "MailWindowController.h"

#include <Pantomime/CWConstants.h>
#include <Pantomime/CWFlags.h>
#include <Pantomime/CWFolder.h>
#include <Pantomime/CWMessage.h>

@implementation GNUMail (MenuValidation)

- (BOOL) validateMenuItem: (id<NSMenuItem>) theMenuItem
{
  id aController;
  id aMessage;

  aController = [[GNUMail lastMailWindowOnTop] delegate];
  aMessage = nil;

  if (aController)
    {
      if ([aController isKindOfClass: [MailWindowController class]] && [[aController dataView] numberOfSelectedRows] > 0)
	{
	  aMessage = [[aController selectedMessages] objectAtIndex: 0];
	}
      else
	{
	  aMessage = [aController selectedMessage];
	}
    }
  
  //
  // Delete / Undelete message
  //
  if (theMenuItem == deleteOrUndelete)
    {
      if (!aMessage) return NO;

      if ([[aMessage flags] contain: PantomimeDeleted])
	{
	  [deleteOrUndelete setTitle: _(@"Undelete")];
	  [deleteOrUndelete setTag: UNDELETE_MESSAGE];
	}
      else
	{
	  [deleteOrUndelete setTitle: _(@"Delete")];
	  [deleteOrUndelete setTag: DELETE_MESSAGE];
	}
    }
  //
  // Deliver
  //
  else if (theMenuItem == deliver)
    {
      if ([[[NSApp keyWindow] windowController] isKindOfClass: [EditWindowController class]])
	{
	  [theMenuItem setTarget: [[[NSApp orderedWindows] objectAtIndex: 0] windowController]];
	  return YES;
	}
      else
	{
	  [theMenuItem setTarget: nil];
	  return NO;
	}
    }
  //
  // Mark as Flagged / Unflagged
  //
  else if (theMenuItem == markAsFlaggedOrUnflagged)
    {
      if (!aMessage) return NO;

      if ([[aMessage flags] contain: PantomimeFlagged])
	{
	  [markAsFlaggedOrUnflagged setTitle: _(@"Mark as Unflagged")];
	  [markAsFlaggedOrUnflagged setTag: MARK_AS_UNFLAGGED];
	}
      else
	{
	  [markAsFlaggedOrUnflagged setTitle: _(@"Mark as Flagged")];
	  [markAsFlaggedOrUnflagged setTag: MARK_AS_FLAGGED];
	}   
    }
  //
  // Mark as Read / Unread
  //
  else if (theMenuItem == markAsReadOrUnread)
    {
      if (!aMessage) return NO;
      
      if ([[aMessage flags] contain: PantomimeSeen])
	{
	  [markAsReadOrUnread setTitle: _(@"Mark as Unread")];
	  [markAsReadOrUnread setTag: MARK_AS_UNREAD];
	}
      else
	{
	  [markAsReadOrUnread setTitle: _(@"Mark as Read")];
	  [markAsReadOrUnread setTag: MARK_AS_READ];
	}   
    }
  //
  // Save in Drafts
  else if (theMenuItem == saveInDrafts)
    {
      if ([[[NSApp keyWindow] windowController] isKindOfClass: [EditWindowController class]])
	{
	  return YES;
	}
      
      return NO;
    }
  //
  //
  // Show All Headers / Filtered
  //
  else if (theMenuItem == showAllHeaders)
    {
      if (!aMessage) return NO;

      if ([aController showAllHeaders])
        {
	  [showAllHeaders setTitle: _(@"Filtered Headers")];
	  [showAllHeaders setTag: HIDE_ALL_HEADERS];
        }
      else
        {
	  [showAllHeaders setTitle: _(@"All Headers")];
	  [showAllHeaders setTag: SHOW_ALL_HEADERS];
        }
    }
  //
  // Show / Hide Delete messages
  //
  else if (theMenuItem == showOrHideDeleted)
    {
      if (!aController) return NO;

      if ([[aController folder] showDeleted])
	{
	  [showOrHideDeleted setTitle: _(@"Hide Deleted")];
	  [showOrHideDeleted setTag: HIDE_DELETED_MESSAGES];
	}
      else
	{
	  [showOrHideDeleted setTitle: _(@"Show Deleted")];
	  [showOrHideDeleted setTag: SHOW_DELETED_MESSAGES];
	}
    }
  //
  // Show / Hide Read messages
  // 
  else if (theMenuItem == showOrHideRead)
    {
      if (!aController) return NO;
      
      if ([[aController folder] showRead])
	{
	  [showOrHideRead setTitle: _(@"Hide Read")];
	  [showOrHideRead setTag: HIDE_READ_MESSAGES];
	}
      else
	{
	  [showOrHideRead setTitle: _(@"Show Read")];
	  [showOrHideRead setTag: SHOW_READ_MESSAGES];
	}
    }
  //
  // Show / Hide Toolbar and Customize Toolbar...
  //
  else if (theMenuItem == customizeToolbar || theMenuItem == showOrHideToolbar)
    {
      id aWindow;
	
      aWindow = [NSApp keyWindow];
      
      if (!aWindow || ![aWindow toolbar])
	{
	  return NO;
	}

      if (theMenuItem == showOrHideToolbar)
	{
	  if ([(NSToolbar *)[aWindow toolbar] isVisible])
	    {
	      [showOrHideToolbar setTitle: _(@"Hide Toolbar")];
	    }
	  else
	    {
	      [showOrHideToolbar setTitle: _(@"Show Toolbar")];
	    }
	}
    }
  //
  // Show Raw Source / Normal Display
  //
  else if (theMenuItem == showRawSource)
    {
      if (!aMessage) return NO;

      if ([aController showRawSource])
	{
	  [showRawSource setTitle: _(@"Normal Display")];
	}
      else
	{
	  [showRawSource setTitle: _(@"Raw Source")];
	}
    }
  //
  // Thread / Unthread messages
  //
  else if (theMenuItem == threadOrUnthreadMessages)
    {
      if (!aController) return NO;

      if ([[aController folder] allContainers])
	{
	  [threadOrUnthreadMessages setTitle: _(@"Unthread Messages")];
	  [threadOrUnthreadMessages setTag: UNTHREAD_MESSAGES];
	  [selectAllMessagesInThread setAction: @selector(selectAllMessagesInThread:)];
	}
      else
	{
	  [threadOrUnthreadMessages setTitle: _(@"Thread Messages")];
	  [threadOrUnthreadMessages setTag: THREAD_MESSAGES];
	  [selectAllMessagesInThread setAction: NULL];
	}
    }

  return YES;
}

@end
