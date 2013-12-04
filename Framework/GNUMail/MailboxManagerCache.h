/*
**  MailboxManagerCache.h
**
**  Copyright (c) 2001-2006
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

#ifndef _GNUMail_H_MailboxManagerCache
#define _GNUMail_H_MailboxManagerCache

#import <Foundation/Foundation.h>

NSString *PathToMailboxManagerCache();

@interface MailboxManagerCache : NSObject <NSCoding>
{
  @private
    NSMutableDictionary *_cache;
}

- (BOOL) synchronize;

//
// Access / mutation methods
//
- (NSDictionary *) allCacheObjects;
- (void) setAllCacheObjects: (NSDictionary *) theObjects;

- (void) allValuesForStoreName: (NSString *) theStoreName
                    folderName: (NSString *) theFolderName
                      username: (NSString *) theUsername
                  nbOfMessages: (unsigned int *) theNbOfMessages
            nbOfUnreadMessages: (unsigned int *) theNbOfUnreadMessages;

- (void) setAllValuesForStoreName: (NSString *) theStoreName
                       folderName: (NSString *) theFolderName
                         username: (NSString *) theUsername
                     nbOfMessages: (unsigned int) theNbOfMessages
               nbOfUnreadMessages: (unsigned int) theNbOfUnreadMessages;

- (void) removeAllValuesForStoreName: (NSString *) theStoreName
                          folderName: (NSString *) theFolderName
                            username: (NSString *) theUsername;

//
// class methods
//
+ (id) cacheFromDisk;

@end


//
// Our cached object
//
@interface MailboxManagerCacheObject : NSObject <NSCoding>
{
  @public
    int nbOfMessages;
    int nbOfUnreadMessages;
}

@end

#endif // _GNUMail_H_MailboxManagerCache
