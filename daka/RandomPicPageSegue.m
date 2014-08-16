//
//  RandomPicPageSegue.m
//  picpic
//
//  Created by Luming Nie on 8/10/14.
//  Copyright (c) 2014 bobatea. All rights reserved.
//

#import "RandomPicPageSegue.h"

@implementation RandomPicPageSegue


-(void) perform{
    
    UIViewController *sourceViewController = (UIViewController*)[self sourceViewController];
    UIViewController *destinationController = (UIViewController*)[self destinationViewController];
    
    CATransition* transition = [CATransition animation];
    transition.duration = .30;
    transition.type = kCATransitionPush;
    transition.subtype = kCATransitionFromLeft;
    
    [destinationController.view.layer addAnimation:transition forKey:kCATransition];
    [sourceViewController presentViewController:destinationController animated:NO completion:nil];
    
}

@end
