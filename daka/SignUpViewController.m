//
//  SignUpViewController.m
//  daka
//
//  Created by Luming Nie on 7/27/14.
//  Copyright (c) 2014 bobatea. All rights reserved.
//

#import "SignUpViewController.h"
#import "NetWorkApi.h"
#import "LCAlertView.h"
#import <QuartzCore/QuartzCore.h>

#define HEXCOLOR(c) [UIColor colorWithRed:((c>>24)&0xFF)/255.0 green:((c>>16)&0xFF)/255.0 blue:((c>>8)&0xFF)/255.0 alpha:((c)&0xFF)/255.0]

@interface SignUpViewController ()
@property (weak, nonatomic) IBOutlet UITextField *userName;
@property (weak, nonatomic) IBOutlet UITextField *password1;
@property (weak, nonatomic) IBOutlet UITextField *password2;
@property (weak, nonatomic) IBOutlet UISegmentedControl *gender;
@property (weak, nonatomic) IBOutlet UIButton *SignUpButton;
@property (weak, nonatomic) IBOutlet UIButton *BackToSignInButton;

@property NSString *genderSelect;

@end

@implementation SignUpViewController
@synthesize SignUpButton;
@synthesize BackToSignInButton;


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
    [self.view addGestureRecognizer:tap];
    
    self.view.backgroundColor = HEXCOLOR(0xDADAC8FF);
    
    self.userName.backgroundColor = HEXCOLOR(0xCC9900FF);
    self.password1.backgroundColor = HEXCOLOR(0xCC9900FF);
    self.password2.backgroundColor = HEXCOLOR(0xCC9900FF);
    [self.userName setReturnKeyType:UIReturnKeyDone];
    [self.password1 setReturnKeyType:UIReturnKeyDone];
    [self.password2 setReturnKeyType:UIReturnKeyDone];
    self.userName.layer.cornerRadius = 10;
    self.password1.layer.cornerRadius = 10;
    self.password2.layer.cornerRadius = 10;
    
    self.userName.delegate = self;
    self.password1.delegate = self;
    self.password1.secureTextEntry = YES;
    self.password2.delegate = self;
    self.password2.secureTextEntry = YES;
    
    SignUpButton.backgroundColor = HEXCOLOR(0x205081FF);
    SignUpButton.layer.cornerRadius = 10;
    SignUpButton.clipsToBounds = YES;
    
    BackToSignInButton.backgroundColor = HEXCOLOR(0x0099CCFF);
    BackToSignInButton.layer.cornerRadius = 10;
    BackToSignInButton.clipsToBounds = YES;
    
    //Default value for gender is "male"
    self.genderSelect = @"male";
    
}

- (IBAction)genderSelect:(UISegmentedControl *)sender {
    switch (self.gender.selectedSegmentIndex) {
        case 0:
            self.genderSelect = @"male";
            NSLog(@"%@", self.genderSelect);
            break;
        case 1:
            self.genderSelect = @"female";
            NSLog(@"%@", self.genderSelect);
            break;
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
} //make "Done" button on keyboards work

-(void) showAlert:(NSString *)title message:(NSString*) message{
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle: title
                                                    message: message
                                                   delegate:self
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
    //[alert release];
}


- (IBAction)signUp:(id)sender {
    if([_userName.text isEqual:@""] || [_password1.text isEqual:@""] || [_password2.text isEqual:@""] ){
        LCAlertView *alert = [[LCAlertView alloc]initWithTitle:@"Oops~" message:@"Plase fill all fields." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:@"Cancel",nil];
        [alert show];
    }else if(![_password1.text isEqualToString: _password2.text] ){
        LCAlertView *alert = [[LCAlertView alloc]initWithTitle:@"Oops~" message:@"Password dissmatch, please try again." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:@"Cancel",nil];
        [alert show];
    }else if(_password1.text.length < 6){
        LCAlertView *alert = [[LCAlertView alloc]initWithTitle:@"Oops~" message:@"Password needs at least 6 characters." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:@"Cancel",nil];
        [alert show];
    }else{
        NSLog(@"sign up a new user: @%@, password:@%@, gender:@%d",_userName.text,_password1.text, _gender.selectedSegmentIndex);
        [NetWorkApi signUpAccountWithUserName:_userName.text
                                     password:_password1.text
                                       gender:self.genderSelect
                                   completion:^(BOOL success, id info) {
                                       if (success) {
                                           NSLog(@"%@", info);
                                           [self performSegueWithIdentifier:@"signUpSuccess" sender:self];
                                           LCAlertView *alert = [[LCAlertView alloc]initWithTitle:@"Hum~" message:@"Password needs at least 6 characters." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:@"PicPic Now!",nil];
                                           [alert show];
                                       } else {
                                           [self showAlert:@"Error!" message: info];
                                       }
                                   }];
    }
}

- (IBAction)backToSignIn:(id)sender {
    [self dismissModalViewControllerAnimated:YES];
}

-(void)dismissKeyboard {
    [self.view endEditing:YES];
} //make the view end editing!


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
