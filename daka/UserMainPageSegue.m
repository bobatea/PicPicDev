//
//  UserMainPageSegue.m
//  picpic
//
//  Created by Luming Nie on 8/10/14.
//  Copyright (c) 2014 bobatea. All rights reserved.
//

#import "UserMainPageSegue.h"

@implementation UserMainPageSegue

-(void) perform{
    
    UIViewController *sourceViewController = (UIViewController*)[self sourceViewController];
    UIViewController *destinationController = (UIViewController*)[self destinationViewController];
    
    CATransition* transition = [CATransition animation];
    transition.duration = 0.3f;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionPush;
    transition.subtype = kCATransitionFromRight;
    
    [destinationController.view.layer addAnimation:transition forKey:kCATransition];
    [sourceViewController presentViewController:destinationController animated:NO completion:nil];
    
}

@end
