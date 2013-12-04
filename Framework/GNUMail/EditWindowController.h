/*
**  EditWindowController.h
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

#ifndef _GNUMail_H_EditWindowController
#define _GNUMail_H_EditWindowController

#import <AppKit/AppKit.h>

#include "AddressTaker.h"

@class AutoCompletingTextField;
@class CWFolder;
@class CWMessage;
@class CWPart;
@class EditWindow;
@class ExtendedTextView;

@interface EditWindowController: NSWindowController <AddressTaker>
{
  // Outlets
  IBOutlet NSTextField *subjectText;
  IBOutlet AutoCompletingTextField *toText;
  IBOutlet AutoCompletingTextField *ccText;
  IBOutlet AutoCompletingTextField *bccText;

  IBOutlet NSTextField *subjectLabel;
  IBOutlet NSTextField *toLabel;
  IBOutlet NSTextField *ccLabel;
  IBOutlet NSTextField *bccLabel;

  IBOutlet NSTextField *sizeLabel;

  IBOutlet NSScrollView *scrollView;
  IBOutlet ExtendedTextView *textView;

  IBOutlet id send;
  IBOutlet id insert;
  IBOutlet id addBcc;
  IBOutlet id addCc;
  IBOutlet id addresses;
  IBOutlet id saveInDrafts;

  IBOutlet NSPopUpButton *accountPopUpButton;
  IBOutlet NSPopUpButton *transportMethodPopUpButton;
  
  // Other ivars
  CWMessage *message;
  CWMessage *unmodifiedMessage;

  NSString *charset;

  BOOL showCc;
  BOOL showBcc;
  BOOL updateColors;

  NSRange affectedRangeForColors;

  int signaturePosition;
  int _mode;

  NSMutableArray *allowedToolbarItemIdentifiers;
  NSMutableDictionary *additionalToolbarItems;

  @private
    NSMutableArray *addressCompletionCandidates;
    NSString *previousSignatureValue;
}

//
// action methods
//
- (IBAction) insertFile: (id) sender;;
- (IBAction) sendMessage: (id) sender;
- (IBAction) showBcc: (id) sender;
- (IBAction) showCc: (id) sender;
- (IBAction) accountSelectionHasChanged: (id) sender;


//
// access/mutation methods
//
- (CWMessage *) message;
- (void) setMessage: (CWMessage *) theMessage;

- (CWMessage *) unmodifiedMessage;
- (void) setUnmodifiedMessage: (CWMessage *) theUnmodifiedMessage;

- (void) setMessageFromDraftsFolder: (CWMessage *) theMessage;

- (BOOL) showCc;
- (void) setShowCc: (BOOL) theBOOL;

- (BOOL) showBcc;
- (void) setShowBcc: (BOOL) theBOOL;

- (int) signaturePosition;
- (void) setSignaturePosition: (int) thePosition;

- (NSPopUpButton *) accountPopUpButton;

- (void) setAccountName: (NSString *) theAccountName;

- (NSString *) charset;
- (void) setCharset: (NSString *) theCharset;

- (int) mode;
- (void) setMode: (int) theMode;

- (NSTextView *) textView;

//
// Other methods
//
- (BOOL) updateMessageContentFromTextView;
- (void) updateWithMessage: (CWMessage *) theMessage;

@end

#endif // _GNUMail_H_EditWindowController
