//
//  SignOutSegue.m
//  picpic
//
//  Created by Luming Nie on 8/17/14.
//  Copyright (c) 2014 bobatea. All rights reserved.
//

#import "SignOutSegue.h"

@implementation SignOutSegue

- (void) perform
{
    
    UIViewController *sourceViewController = (UIViewController*)[self sourceViewController];
    UIViewController *destinationController = (UIViewController*)[self destinationViewController];
    
    CATransition* transition = [CATransition animation];
    transition.duration = 10.0f;
    transition.type = kCATransitionFade;
    
    [destinationController.view.layer addAnimation:transition forKey:kCATransition];
    [sourceViewController presentViewController:destinationController animated:NO completion:nil];
    
}

@end
