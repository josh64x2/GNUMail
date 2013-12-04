/*
**  Task.m
**
**  Copyright (c) 2002-2007
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

#include "Task.h"

#include "Constants.h"

#include <Foundation/NSArray.h>
#include <Foundation/NSDebug.h>
#include <Foundation/NSString.h>
#include <Foundation/NSValue.h>

//
//
//
@implementation Task

- (id) init
{
  self = [super init];

  [self setMessage: nil];
  [self setUnmodifiedMessage: nil];
  [self setKey: nil];
  [self setSendingKey: nil];
  [self setDate: [NSDate date]];
  [self setOwner: nil];
  [self setFilteredMessagesFolders: [NSMutableArray array]];

  op = sub_op = total_size = current_size = filtered_count = received_count = total_count = 0;
  is_running = immediate = NO;
  origin = ORIGIN_USER;

  _controllers = [[NSMutableArray alloc] init];
  _subtitle = nil;

  return self;
}

//
//
//
- (void) dealloc
{
  RELEASE(message);
  RELEASE(unmodifiedMessage);
  RELEASE(key);
  RELEASE(sendingKey);
  RELEASE(date);
  RELEASE(owner);
  RELEASE(filteredMessagesFolders);
  RELEASE(_controllers);
  RELEASE(_subtitle);
  [super dealloc];
}


//
// NSCoding protocol
//
// We do NOT store the owner and if the task is running. The task
// is obviously not running when it's encoded :-)
//
- (void) encodeWithCoder: (NSCoder *) theCoder
{
  [theCoder encodeObject: [self message]];
  [theCoder encodeObject: [self unmodifiedMessage]];
  [theCoder encodeObject: [self key]];
  [theCoder encodeObject: [self sendingKey]];
  [theCoder encodeObject: [NSNumber numberWithInt: op]];
  [theCoder encodeObject: [NSNumber numberWithInt: sub_op]];
  [theCoder encodeObject: [self date]];
}


//
//
//
- (id) initWithCoder: (NSCoder *) theCoder
{
  self = [super init];

  [self setMessage: [theCoder decodeObject]];
  [self setUnmodifiedMessage: [theCoder decodeObject]];
  [self setKey: [theCoder decodeObject]];
  [self setSendingKey: [theCoder decodeObject]];
  [self setDate: [theCoder decodeObject]];
  [self setOwner: nil];
  [self setFilteredMessagesFolders: [NSMutableArray array]];

  op = sub_op = filtered_count = received_count = total_count = 0;
  is_running = NO;
  
  _controllers = [[NSMutableArray alloc] init];

  return self;
}


//
// NSCopying protocol
//
- (id) copyWithZone: (NSZone *) zone
{
  Task *aTask;

  aTask = [[Task alloc] init];

  [aTask setMessage: [self message]];
  [aTask setUnmodifiedMessage: [self unmodifiedMessage]];
  [aTask setKey: [self key]];
  [aTask setSendingKey: [self sendingKey]];
  [aTask setDate: [self date]];
  [aTask setOwner: [self owner]];

  aTask->op = op;
  aTask->sub_op = sub_op;
  aTask->is_running = is_running;
  aTask->received_count = received_count;
  aTask->filtered_count = filtered_count;

  return aTask;
}


//
//
//
- (id) message
{
  return message;
}

- (void) setMessage: (id) theMessage
{
  ASSIGN(message,theMessage);
}


//
//
//
- (id) unmodifiedMessage
{
  return unmodifiedMessage;
}

- (void) setUnmodifiedMessage: (id) theMessage
{
  ASSIGN(unmodifiedMessage, theMessage);
}

//
//
//
- (id) key
{
  return key;
}

- (void) setKey: (id) theKey
{
  ASSIGN(key, theKey);
}


//
//
//
- (id) sendingKey
{
  return sendingKey;
}

- (void) setSendingKey: (id) theKey
{
  ASSIGN(sendingKey, theKey);
}

//
//
//
- (NSDate *) date
{
  return date;
}

- (void) setDate: (NSDate *) theDate
{
  ASSIGN(date, theDate);
}

//
//
//
- (id) owner
{
  return owner;
}

- (void) setOwner: (id) theOwner
{
  ASSIGN(owner, theOwner);
}

//
//
//
- (NSMutableArray *) filteredMessagesFolders
{
  return filteredMessagesFolders;
}

- (void) setFilteredMessagesFolders: (NSMutableArray *) theMutableArray
{
  ASSIGN(filteredMessagesFolders, theMutableArray);
}

//
//
//
- (void) addController: (id) theController
{
  if (theController && ![_controllers containsObject: theController])
    {
      [_controllers addObject: theController];
    }
}

//
//
//
- (NSArray *) allControllers
{
  return _controllers;
}

//
//
//
- (NSString *) title
{
  return @"";
}


//
//
//
- (NSString *) subtitle
{
  return _subtitle;
}

- (void) setSubtitle: (NSString *) theSubtitle
{
  ASSIGN(_subtitle, theSubtitle);
}
@end
