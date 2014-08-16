//
//  Notification.h
//  daka
//
//  Created by Luming Nie on 7/27/14.
//  Copyright (c) 2014 bobatea. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Notification : NSObject

@property int userID;
@property NSString* content;
@property NSDate* fireDate;

@end
