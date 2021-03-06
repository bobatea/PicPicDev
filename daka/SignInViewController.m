//
//  SignInViewController.m
//  daka
//
//  Created by Luming Nie on 7/27/14.
//  Copyright (c) 2014 bobatea. All rights reserved.
//

#import "SignInViewController.h"
#import "NetWorkApi.h"
#import "DataHelper.h"
#import "Notification.h"
#import "UserMainPageViewController.h"
#import "LCAlertView.h"
#import <QuartzCore/QuartzCore.h>

#define HEXCOLOR(c) [UIColor colorWithRed:((c>>24)&0xFF)/255.0 green:((c>>16)&0xFF)/255.0 blue:((c>>8)&0xFF)/255.0 alpha:((c)&0xFF)/255.0]

@interface SignInViewController ()
- (IBAction)SignIn:(id)sender;

@property (weak, nonatomic) IBOutlet UITextField *username;
@property (weak, nonatomic) IBOutlet UITextField *password;
@property NSString *apiDesc;
@property (weak, nonatomic) IBOutlet UIButton *SignInButton;
@property (weak, nonatomic) IBOutlet UIButton *SignUpButton;

@property NSString *responseUserName;
@property NSString *responseUserId;
@property NSString *responseUserGender;
@property NSString *responseToken;

@end

@implementation SignInViewController
@synthesize SignInButton;
@synthesize SignUpButton;
@synthesize responseUserName;
@synthesize responseUserId;
@synthesize responseUserGender;
@synthesize responseToken;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    self.view.backgroundColor = HEXCOLOR(0xDADAC8FF);
    
    self.username.backgroundColor = HEXCOLOR(0xCC9900FF);
    self.password.backgroundColor = HEXCOLOR(0xCC9900FF);
    [self.username setReturnKeyType:UIReturnKeyDone];
    [self.password setReturnKeyType:UIReturnKeyDone];
    self.username.layer.cornerRadius = 10;
    self.password.layer.cornerRadius = 10;

    self.username.delegate = self;
    self.password.delegate = self;
    self.password.secureTextEntry = YES;
    
    SignInButton.backgroundColor = HEXCOLOR(0x205081FF);
    SignInButton.layer.cornerRadius = 10;
    SignInButton.clipsToBounds = YES;
    
    SignUpButton.backgroundColor = HEXCOLOR(0x0099CCFF);
    SignUpButton.layer.cornerRadius = 10;
    SignUpButton.clipsToBounds = YES;
    
    [self.view addGestureRecognizer:tap];
    
    //auto login
    NSUserDefaults *autoLoginInfo = [NSUserDefaults standardUserDefaults];
    NSString *autoUsername = [autoLoginInfo stringForKey:@"username"];
    NSString *autoPassword = [autoLoginInfo stringForKey:@"password"];
    
    if (autoLoginInfo && autoPassword) {
        [NetWorkApi signInAccountWithUserName:autoUsername
                                     password:autoPassword
                                   completion:^(BOOL success, id info) {
                                       if (success) {
                                           //[self performSelector:@selector(getNotification) withObject:self];
                                           NSLog(@"-------------login Success-------------");
                                           NSLog(@"%@", info);
                                           NSLog(@"%@", [info objectForKey:@"username"]);
                                           self.apiDesc = [info objectForKey:@"username"];
                                           responseToken = [info objectForKey:@"token"];
                                           //perform segue
                                           [self performSegueWithIdentifier:@"SignInSuccess" sender:self];
                                       } else {
                                           LCAlertView *alert = [[LCAlertView alloc]initWithTitle:@"Oops~" message:@"LogIn Error: username and password dismatch." delegate:self cancelButtonTitle:@"Try Again" otherButtonTitles:@"OK",nil];
                                           [alert show];
                                       }
                                   }];
    }
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
} //make "Done" button on keyboards work

-(void)dismissKeyboard {
    [self.view endEditing:YES];
} //make the view end editing!


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void) getNotification
{
    NSLog(@"getNotification");
    [NetWorkApi getNotification:0 completion:^(NSMutableArray *notificationList) {
        [DataHelper setNotification:notificationList];
    }];
    
    [self performSelector:@selector(getNotification) withObject:self afterDelay:15.0f];
}


- (IBAction)SignIn:(id)sender {
    
    [NetWorkApi signInAccountWithUserName:self.username.text
                                 password:self.password.text
                               completion:^(BOOL success, id info) {
                                   if (success) {
                                       //[self performSelector:@selector(getNotification) withObject:self];
                                       NSLog(@"-------------login Success-------------");
                                       NSLog(@"%@", info);
                                       NSLog(@"%@", [info objectForKey:@"username"]);
                                       self.apiDesc = [info objectForKey:@"username"];
                                       responseToken = [info objectForKey:@"token"];
                                       //store username and password to UserDefaults
                                       NSUserDefaults *LoginInfo = [NSUserDefaults standardUserDefaults];
                                       [LoginInfo setObject:self.username.text forKey:@"username"];
                                       [LoginInfo setObject:self.password.text forKey:@"password"];
                                       //perform segue
                                       [self performSegueWithIdentifier:@"SignInSuccess" sender:self];
                                   } else {
                                       LCAlertView *alert = [[LCAlertView alloc]initWithTitle:@"Oops~" message:@"LogIn Error: username and password dismatch." delegate:self cancelButtonTitle:@"Try Again" otherButtonTitles:@"OK",nil];
                                       [alert show];
                                   }
                               }];
}


-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{

    if([segue.identifier isEqual:@"SignInSuccess"]) {
        UserMainPageViewController *destVC = segue.destinationViewController;
        destVC.recipeDesc = self.apiDesc;
        destVC.userToken = responseToken;
    }

}



@end
