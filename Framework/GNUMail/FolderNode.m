/*
**  FolderNode.m
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

#include "FolderNode.h"

#include "Constants.h"

@implementation FolderNode 

- (id) init
{
  self = [super init];
 
  [self setChildren: nil];

  _parent = nil;
  _name = nil;
  _path = nil;
  _subscribed = NO;
 
  return self;
}

- (void) dealloc
{
  RELEASE(_name);
  RELEASE(_path);
  RELEASE(_children);
  
  [super dealloc];
}


//
// NSCopying protocol
//
- (id) copyWithZone: (NSZone *) zone
{
  return RETAIN(self);
}


//
// access / mutation methods
//
- (NSString *) name
{
  return _name;
}

- (void) setName: (NSString *) theName
{
  DESTROY(_path);
  ASSIGN(_name, theName);
}

- (NSString *) path
{
  return _path;
}

- (void) setPath: (NSString *) thePath
{
  ASSIGN(_path, thePath);
}

- (FolderNode *) parent
{
  return _parent;
}

- (void) setParent: (FolderNode *) theParent
{
  _parent = theParent;
}

- (BOOL) subscribed
{
  return _subscribed;
}

- (void) setSubscribed: (BOOL) theBOOL
{
  _subscribed = theBOOL;
}

- (NSArray *) children
{
  return _children;
}

- (void) setChildren: (NSArray *) theChildren
{
  NSMutableArray *aMutableArray;
 
  aMutableArray = [[NSMutableArray alloc] init];
  
  if (theChildren)
    {
      int i;

      [aMutableArray addObjectsFromArray: theChildren];

      for (i = 0; i < [theChildren count]; i++)
	{
	  [[theChildren objectAtIndex: i] setParent: self];
	}
    }
  
  RELEASE(_children);
  _children = aMutableArray;
}

- (void) addChild: (FolderNode *) theChild
{
  [_children addObject: theChild];
  [_children sortUsingSelector: @selector(compare:)];
}

- (void) removeChild: (FolderNode *) theChild
{
  [_children removeObject: theChild];
}

- (FolderNode *) childAtIndex: (int) theIndex
{
  return [_children objectAtIndex: theIndex];
}

- (FolderNode *) childWithName: (NSString *) theName
{
  int i, count;

  count = [_children count];

  for (i = 0; i < count; i++)
    {
      FolderNode *aFolderNode;

      aFolderNode = (FolderNode *)[_children objectAtIndex: i];

      if ([theName isEqualToString: [aFolderNode name]])
	{
	  return aFolderNode;
	}
    }

  return nil;
}

- (int) childCount
{
  return [_children count];
}


//
// Comparison
//
- (NSComparisonResult) compare: (FolderNode *) theFolderNode
{
  return [_name compare: [theFolderNode name]];
}

//
// class methods
//
+ (FolderNode *) folderNodeWithName: (NSString *) theName
                             parent: (FolderNode *) theParent
{
  FolderNode *aFolderNode;

  aFolderNode = [[FolderNode alloc] init];

  [aFolderNode setName: theName];
  [aFolderNode setParent: theParent];
  
  return AUTORELEASE(aFolderNode);
}

@end
