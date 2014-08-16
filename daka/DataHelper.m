//
//  DataHelper.m
//  daka
//
//  Created by Luming Nie on 7/27/14.
//  Copyright (c) 2014 bobatea. All rights reserved.
//

#import "DataHelper.h"
#import <CommonCrypto/CommonDigest.h>
#import "Notification.h"

@implementation DataHelper

+ (NSString *) md5:(NSString *) input
{
    const char *cStr = [input UTF8String];
    unsigned char digest[16];
    CC_MD5( cStr, strlen(cStr), digest ); // This is the md5 call
    
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    
    return  output;
    
}


+ (UserBaseClass*) dictToUser:(NSDictionary*) dict{
    
    UserBaseClass * new = [[UserBaseClass alloc] init];
    if(dict.count == 0)
        return new;
    new.user_id = [(NSNumber*)[dict objectForKey:@"userID"] intValue];
    new.user_name = [dict objectForKey:@"userName"];
    NSString* photo_name = @"running_img.png";
    if([new.user_name isEqual:@"derrick"])
        photo_name = @"running_img.png";
    else if([new.user_name isEqual:@"luming"])
        photo_name = @"running_img.png";
    UIImage *img = [[UIImage alloc] init];
    img = [UIImage imageNamed:photo_name];
    new.profile_pic = img;
    return new;
}

+ (NSDate*)stringToDatetime:(NSString*) date{
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    [dateFormat setTimeZone:[NSTimeZone timeZoneWithName:@"GMT"]];
    return [dateFormat dateFromString: date];
}

+ (Notification*) dictToNotification:(NSDictionary*) dict{
    Notification * new = [[Notification alloc] init];
    if(dict.count == 0)
        return new;
    new.userID = [(NSNumber*)[dict objectForKey:@"userID"] intValue];
    new.content = [dict objectForKey:@"content"];
    new.fireDate = [self stringToDatetime :(NSString*)[dict objectForKey:@"fireTime"]];
    return new;
}

+ (void) setNotification:(NSMutableArray*) notificationList{
    
    for (Notification* key in notificationList) {
        
        UILocalNotification *localNotification = [[UILocalNotification alloc] init];
        localNotification.fireDate = [key.fireDate dateByAddingTimeInterval:-30*60];
        localNotification.timeZone = [NSTimeZone defaultTimeZone];
        localNotification.alertBody = key.content;
        localNotification.soundName = UILocalNotificationDefaultSoundName;
        [UIApplication sharedApplication].applicationIconBadgeNumber = [UIApplication sharedApplication].applicationIconBadgeNumber + 1;
        
        [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
        NSLog(@"add a new notifaction %@", localNotification);
    }
}

+ (void)showNetWorkAlertWindow:(NSError*) error{
    NSLog(@"Error: %@", error);
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error Retrieving data"
                                                        message:[error localizedDescription]
                                                       delegate:nil
                                              cancelButtonTitle:@"Ok"
                                              otherButtonTitles:nil];
    [alertView show];
}

@end
