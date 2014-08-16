//
//  DataHelper.h
//  daka
//
//  Created by Luming Nie on 7/27/14.
//  Copyright (c) 2014 bobatea. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserBaseClass.h"
#import "DataHelper.h"
#import "Notification.h"

@interface DataHelper : NSObject

+ (UserBaseClass*) dictToUser:(NSDictionary*) dict;
+ (NSString *) md5:(NSString *) input;
+ (void)showNetWorkAlertWindow:(NSError*) error;
+ (Notification*) dictToNotification:(NSDictionary*) dict;
+ (void) setNotification:(NSMutableArray*) events;

@end
