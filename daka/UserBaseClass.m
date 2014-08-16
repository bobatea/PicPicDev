//
//  UserBaseClass.m
//  daka
//
//  Created by Luming Nie on 7/27/14.
//  Copyright (c) 2014 bobatea. All rights reserved.
//

#import "UserBaseClass.h"

@implementation UserBaseClass

+ (id) initWithUser:(UserBaseClass *)u {
	UserBaseClass *user = [UserBaseClass new];
	user.user_id = u.user_id;
	user.user_name = u.user_name;
	user.gender = u.gender;
	user.profile_pic = u.profile_pic;
	return user;
}

@end
