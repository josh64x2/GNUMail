/*
**  TaskManager.h
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

#ifndef _GNUMail_H_TaskManager
#define _GNUMail_H_TaskManager

#include <Foundation/NSMapTable.h>
#include <Foundation/NSObject.h>

@class CWMessage;
@class CWService;
@class MailWindowController;
@class NSMutableArray;
@class NSNotification;
@class NSTimer;
@class Task;

@interface TaskManager : NSObject
{
  @private
    NSTimer *_timer;
    NSMapTable *_table;
    
    NSMutableArray *_tasks;

    unsigned int _counter;
}

- (void) run;
- (void) stop;

- (void) addTask: (Task *) theTask;
- (void) nextTask;
- (void) removeTask: (Task *) theTask;

- (Task *) taskForService: (CWService *) theService;
- (Task *) taskForService: (CWService *) theService  message: (CWMessage *) theMessage;

- (NSArray *) allTasks;

- (void) checkForNewMail: (id) theSender
              controller: (MailWindowController *) theMailWindowController;

- (void) stopTask: (Task *) theTask;
- (void) stopTasksForService: (id) theService;
- (void) setMessage: (id) theMessage  forHash: (int) theHash;

//
// Pantomime's delegate methods
//
- (void) authenticationCompleted: (NSNotification *) theNotification;
- (void) authenticationFailed: (NSNotification *) theNotification;
- (void) connectionEstablished: (NSNotification *) theNotification;
- (void) connectionTerminated: (NSNotification *) theNotification;
- (void) connectionTimedOut: (NSNotification *) theNotification;
- (void) folderPrefetchCompleted: (NSNotification *) theNotification;
- (void) messagePrefetchCompleted: (NSNotification *) theNotification;
- (void) messageNotSent: (NSNotification *) theNotification;
- (void) messageSent: (NSNotification *) theNotification;
- (void) service: (CWService *) theService receivedData: (NSData *) theData;
- (void) service: (CWService *) theService sentData: (NSData *) theData;


//
// Class methods
//
+ (id) singleInstance;

@end

#endif // _GNUMail_H_TaskManager
