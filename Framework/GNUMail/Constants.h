/*
**  Constants.h
**
**  Copyright (c) 2003-2007
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

#ifndef _GNUMail_H_GNUMailConstants
#define _GNUMail_H_GNUMailConstants


//
// Useful macros
//
#ifdef MACOSX
#define RETAIN(object)          [object retain]
#define RELEASE(object)         [object release]
#define AUTORELEASE(object)     [object autorelease]
#define TEST_RELEASE(object)    ({ if (object) [object release]; })
#define ASSIGN(object,value)    ({\
id __value = (id)(value); \
id __object = (id)(object); \
if (__value != __object) \
  { \
    if (__value != nil) \
      { \
        [__value retain]; \
      } \
    object = __value; \
    if (__object != nil) \
      { \
        [__object release]; \
      } \
  } \
})

#define DESTROY(object) ({ \
  if (object) \
    { \
      id __o = object; \
      object = nil; \
      [__o release]; \
    } \
})

#define NSLocalizedString(key, comment) \
  [[NSBundle mainBundle] localizedStringForKey:(key) value:@"" table:nil]

#define _(X) NSLocalizedString (X, @"")

#ifdef DEBUG
#define NSDebugLog(format, args...) \
  do { NSLog(format, ##args); } while(0)
#else
#define NSDebugLog(format, args...)
#endif

#endif


//
// Constants for the application
//
#define RETAIN_PERIOD 300
#define THREAD_ARCS_CELL_WIDTH 180
#define THREAD_ARCS_CELL_MIN_HEIGHT 105

enum {
  MANUALLY = 0,
  AUTOMATICALLY = 1,
  NEVER = 2
};

enum {
  SHOW_ALL_HEADERS = 1,
  HIDE_ALL_HEADERS = 2
};

enum {
  DELETE_MESSAGE = 1,
  UNDELETE_MESSAGE = 2,
};

enum {
  MARK_AS_FLAGGED = 1,
  MARK_AS_UNFLAGGED = 2
};

enum {
  MARK_AS_READ = 1,
  MARK_AS_UNREAD = 2
};

enum {
  SHOW_DELETED_MESSAGES = 1,
  HIDE_DELETED_MESSAGES = 2
};

enum {
  SHOW_READ_MESSAGES = 1,
  HIDE_READ_MESSAGES = 2
};

enum {
  THREAD_MESSAGES = 1,
  UNTHREAD_MESSAGES = 2
};

enum {
  OTHER = 0,
  POP3 = 1,
  IMAP = 2,
  UNIX = 3
};

enum {
  SECURITY_NONE = 0,
  SECURITY_SSL = 1,
  SECURITY_TLS_IF_AVAILABLE = 2,
  SECURITY_TLS = 3
};

enum {
  TRANSPORT_MAILER = 1,
  TRANSPORT_SMTP = 2
};

enum {
  SIGNATURE_BEGINNING = 0,
  SIGNATURE_END = 1,
  SIGNATURE_HIDDEN = 2
};

enum {
  MOVE_MESSAGES = 1,
  COPY_MESSAGES = 2
};

enum {
  MODE_STANDARD = 1,
  MODE_EXPERT = 2
};

enum {
  TYPE_PLAIN = 1,
  TYPE_HTML = 2
};

enum {
  IMAP_SHOW_ALL = 0,
  IMAP_SHOW_SUBSCRIBED_ONLY = 1
};


enum {
  ACTION_REPLY_TO_MESSAGE = 0,
  ACTION_VIEW_MESSAGE = 1,
  ACTION_NO_ACTION = 2
};

//
//
//
enum {
  GNUMailComposeMessage,
  GNUMailForwardMessage,
  GNUMailRedirectMessage,
  GNUMailReplyToMessage,
  GNUMailRestoreFromDrafts
};

//
//
//
enum {
  GNUMailDateColumn = 1,
  GNUMailFlagsColumn = 2,
  GNUMailFromColumn = 3,
  GNUMailNumberColumn = 4,
  GNUMailSizeColumn = 5,
  GNUMailStatusColumn = 6,
  GNUMailSubjectColumn = 7
};

//
//
//
enum {
  GNUMailSmallIconSize,
  GNUMailStandardIconSize,
  GNUMailLargeIconSize
};

//
//
//
enum {
  GNUMailDrawerView = 0,
  GNUMailFloatingView = 1,
  GNUMail3PaneView = 2,
  GNUMailWidescreenView = 3
};

//
// Constants for the UI
//
enum {
  TextFieldHeight = 21,
  ButtonHeight = 25,
};


//
// Notifications used in GNUMail
//
extern NSString *AccountsHaveChanged;
extern NSString *FiltersHaveChanged;
extern NSString *FontValuesHaveChanged;
extern NSString *MessageThreadingNotification;
extern NSString *ReloadMessageList;
extern NSString *TableColumnsHaveChanged;

//
// Operations and attributes for folders and messages
//
extern NSString *FolderExpireDate;
extern NSString *MessageData;
extern NSString *MessageDestinationChangeEncoding;
extern NSString *MessageDestinationFolder;
extern NSString *MessageDestinationPasteboard;
extern NSString *MessageDestinationStore;
extern NSString *MessageExpireDate;
extern NSString *MessageFlags;
extern NSString *MessageLoading;
extern NSString *MessageNumber;
extern NSString *MessageOperation;
extern NSString *MessagePreloading;
extern NSString *MessageRedirecting;
extern NSString *MessageViewing;

//
// Pasteboard data types
//
extern NSString *MessagePboardType;

#endif // _GNUMail_H_GNUMailConstants
