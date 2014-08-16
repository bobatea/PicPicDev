//
//  UserMainPageViewController.h
//  daka
//
//  Created by Luming Nie on 8/3/14.
//  Copyright (c) 2014 bobatea. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserMainPageViewController : UIViewController <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (weak, nonatomic) IBOutlet UILabel *desc;
@property (nonatomic, strong) NSString *recipeDesc;

@end
