//
//  NetWorkApi.m
//  daka
//
//  Created by Luming Nie on 7/27/14.
//  Copyright (c) 2014 bobatea. All rights reserved.
//

#import "NetWorkApi.h"
#import "DataHelper.h"

// network api
//#import "AFHTTPRequestOperationManager.h"
#import "AFNetworking.h"


@implementation NetWorkApi

static NSString * const BaseURLString = @"http://picpic-api.herokuapp.com/api/v1/"; // To be filled with url from Djiango
static NSNumber* uid;

// get self user id
+ (int)getSelfId{
    return [uid intValue];
}


//sign in
+ (void)signInAccountWithUserName:(NSString *)user_name
                         password:(NSString *)password
                       completion:(void (^)(BOOL success, id info))completionBlock
{
    NSString *apiName = @"signin";
    NSDictionary *params = @ {@"username" :user_name, @"password" :password};
    
    [self networkDealer:apiName
                 params:params
             completion:^(NSDictionary *response) {

//          Here is the call back function that calling "completionBlock" passed from SignIn and excute it:
//          Recusively clousure into next block, until the "manager" in "networkDearler", So there needs to be a "success" returned back
//                  uid = [NSNumber numberWithInt: [[response objectForKey:@"uid"] intValue]];
                    completionBlock([[response objectForKey:@"success"] boolValue] , [response objectForKey:@"info"]);
             }];
}


//sign up
+ (void)signUpAccountWithUserName:(NSString *)userName
                         password:(NSString *)password
                           gender:(NSString *)genderSelect
                       completion:(void (^)(BOOL success, id info))completionBlock{
    
    NSString *apiName = @"signup";
    NSDictionary *params = @ {@"username" :userName,
                              @"password" :password,
                              @"gender" :genderSelect};
    
    [self networkDealer:apiName
                 params:params
             completion:^(NSDictionary *response) {
                 completionBlock([[response objectForKey:@"success"] boolValue], [response objectForKey:@"info"]);
             }];
}

//
//+ (void)signOutAccount:{}


//network core function - functions for Networking Communications
+(void) networkDealer:(NSString*) apiName
               params:(NSDictionary*) params
           completion:(void (^)(NSDictionary * response))completionBlock {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSString* url = [BaseURLString stringByAppendingString: apiName];
    
    NSLog(@"Call api url: %@", url);
    NSLog(@"api params: %@", params);
    
    [manager POST:url
       parameters:params
          success:  ^(AFHTTPRequestOperation *operation, id responseObject)
                        {
                            NSLog(@"Api response: %@", responseObject);
                            completionBlock((NSDictionary*)responseObject);
         
                        }
          failure:
                    ^(AFHTTPRequestOperation *operation, NSError *error) {
                        NSLog(@"network error: %@", error);
                        [DataHelper showNetWorkAlertWindow:error];
                        }];
}


+ (void)getNotification:(int) userId
             completion:(void (^)(NSMutableArray* notificationList))completionBlock{
    NSString *apiName = @"getNotification";
    NSDictionary *params = @{@"uid":uid};
    
    [self networkDealer:apiName
                 params:params
             completion:^(NSDictionary *response) {
                 NSMutableArray *notificationList = [NSMutableArray new];
                 for (NSDictionary* value in response) {
                     [notificationList addObject: [DataHelper dictToNotification:value ]];
                 }
                 completionBlock(notificationList);
             }];
}

@end
