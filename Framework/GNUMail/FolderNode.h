/*
**  FolderNode.h
**
**  Copyright (C) 2001-2004
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

#ifndef _GNUMail_H_FolderNode
#define _GNUMail_H_FolderNode

#import <Foundation/Foundation.h>

@interface FolderNode : NSObject <NSCopying>
{
  @private
    FolderNode *_parent;
    NSString *_name;
    NSString *_path;
  
    BOOL _subscribed;
    NSMutableArray *_children;
}

//
// access / mutation methods
//
- (NSString *) name;
- (void) setName: (NSString *) theName;

- (NSString *) path;
- (void) setPath: (NSString *) thePath;

- (FolderNode *) parent;
- (void) setParent: (FolderNode *) theParent;


- (BOOL) subscribed;
- (void) setSubscribed: (BOOL) theBOOL;

- (NSArray *) children;
- (void) setChildren: (NSArray *) theChildren;

- (void) addChild: (FolderNode *) theChild;
- (void) removeChild: (FolderNode *) theChild;

- (FolderNode *) childAtIndex: (int) theIndex;
- (FolderNode *) childWithName: (NSString *) theName;

- (int) childCount;


//
// Comparison
//
- (NSComparisonResult) compare: (FolderNode *) theFolderNode;


//
// class methods
//
+ (FolderNode *) folderNodeWithName: (NSString *) theName
                             parent: (FolderNode *) theParent;

@end

#endif // _GNUMail_H_FolderNode
