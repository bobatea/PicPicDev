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

//sign out
+ (void)signOutAccountWithHeader:(NSString *) userToken
                       completion:(void (^)(BOOL success, id info))completionBlock{
    
    NSString *apiName = @"protected/signout";
    NSString *token = userToken;
    
    [self networkDealerProtected:apiName
                          params:token
                      completion:^(NSDictionary *response) {
                 completionBlock([[response objectForKey:@"success"] boolValue], [response objectForKey:@"info"]);
             }];
}

//upload image
+(void)uploadPictureWithHeader:(NSString *) userToken
                       image:(NSData *) imageUpload
                  completion:(void (^)(BOOL success, id info))completionBlock{

    NSString *apiName = @"protected/picupload";
    NSString *token = userToken;
    NSData *image = imageUpload;
    
    [self networkDealerUploadPic:apiName
                           image:image
                          params:token
                      completion:^(NSDictionary *response) {
                          completionBlock([[response objectForKey:@"success"] boolValue], [response objectForKey:@"info"]);
                      }];

}


//network core function for "unprotected" methods: functions for Networking Communications
//unprotected methods: SignIn and SignUp
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

//network core function for "protected" methods: functions for Networking Communications
//unprotected methods: SignOut and PicUpload
+(void) networkDealerProtected:(NSString*) apiName
               params:(NSString*) params
           completion:(void (^)(NSDictionary * response))completionBlock {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    //initialize serializer for adding HTTP header
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    [manager.requestSerializer setValue:params forHTTPHeaderField:@"access_token"];
    NSString* url = [BaseURLString stringByAppendingString: apiName];
    
    NSLog(@"Call api url: %@", url);
    NSLog(@"api params: %@", params);
    
    [manager GET:url
       parameters:nil
          success:  ^(AFHTTPRequestOperation *operation, id responseObject)
                {
                    NSLog(@"Api response: %@", responseObject);
                    completionBlock((NSDictionary*)responseObject);
                }
          failure:
                    ^(AFHTTPRequestOperation *operation, NSError *error)
                {
                        NSLog(@"network error: %@", error);
                    [DataHelper showNetWorkAlertWindow:error];
                }];
}

//network core function for upload picture
+(void)networkDealerUploadPic:(NSString *) apiName
                        image:imageData
                       params:(NSString *) params
                   completion:(void (^)(NSDictionary * response))completionBlock {

    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    //initialize serializer for adding HTTP header
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    [manager.requestSerializer setValue:params forHTTPHeaderField:@"access_token"];
    NSString* url = [BaseURLString stringByAppendingString: apiName];
    
    NSLog(@"Call api url: %@", url);
    NSLog(@"api params: %@", params);
    
            [manager POST:url
               parameters:nil
constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
                            [formData appendPartWithFileData:imageData
                                                        name:@"pic_file"
                                                    fileName:@"pic_file"
                                                    mimeType:@"image/jpeg"];
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"Success: %@", responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
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
