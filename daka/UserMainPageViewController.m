//
//  UserMainPageViewController.m
//  daka
//
//  Created by Luming Nie on 8/3/14.
//  Copyright (c) 2014 bobatea. All rights reserved.
//

#import "UserMainPageViewController.h"
#import "RandomPicPageViewController.h"
#import "NetWorkApi.h"
#import "LCAlertView.h"

@interface UserMainPageViewController ()

@property (weak, nonatomic) IBOutlet UIButton *LogOutButton;
@property (weak, nonatomic) IBOutlet UIButton *UploadPicture;

//image collection
@property (weak, nonatomic) IBOutlet UIImageView *picture1;
@property (weak, nonatomic) IBOutlet UIImageView *picture2;
@property (weak, nonatomic) IBOutlet UIImageView *picture3;


@end

@implementation UserMainPageViewController

@synthesize desc;
@synthesize recipeDesc;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


-(void)viewDidAppear:(BOOL)animated{
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.desc.text = self.recipeDesc;

    UISwipeGestureRecognizer *leftRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(leftSwipeHandle:)];
    leftRecognizer.direction = UISwipeGestureRecognizerDirectionLeft;
    [leftRecognizer setNumberOfTouchesRequired:1];
    [self.view addGestureRecognizer:leftRecognizer];
    
    if (![QBImagePickerController isAccessible]) {
        NSLog(@"Error: Source is not accessible.");
    }
}

- (IBAction)SelectUploadPic:(id)sender {
    
    QBImagePickerController *imagePickerController = [[QBImagePickerController alloc] init];
    imagePickerController.delegate = self;
    imagePickerController.allowsMultipleSelection = true;
    
    imagePickerController.maximumNumberOfSelection = 3;
    
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:imagePickerController];
    [self presentViewController:navigationController animated:YES completion:NULL];
}

- (void)dismissImagePickerController
{
    if (self.presentedViewController) {
        [self dismissViewControllerAnimated:YES completion:NULL];
    } else {
        [self.navigationController popToViewController:self animated:YES];
    }
}


#pragma mark - QBImagePickerControllerDelegate

- (void)qb_imagePickerController:(QBImagePickerController *)imagePickerController didSelectAsset:(ALAsset *)asset
{
    NSLog(@"*** qb_imagePickerController:didSelectAsset as a single ALAsset:");
    NSLog(@"%@", asset);
    
    [self dismissImagePickerController];
}

- (void)qb_imagePickerController:(QBImagePickerController *)imagePickerController didSelectAssets:(NSArray *)assets
{
    //helper functions to get image from libray - result block and failure block
    ALAssetsLibraryAssetForURLResultBlock resultblock = ^(ALAsset *myasset)
    {
        ALAssetRepresentation *rep = [myasset defaultRepresentation];
        CGImageRef iref = [rep fullResolutionImage];
        if (iref) {
            UIImage *largeimage = [UIImage imageWithCGImage:iref];
            self.picture1.image = largeimage;
        }
    };
    
    ALAssetsLibraryAccessFailureBlock failureblock = ^(NSError *myerror)
    {
        NSLog(@"Can't get image - %@",[myerror localizedDescription]);
    };
    
    NSLog(@"*** qb_imagePickerController:didSelectAssets as an NSArray of assets:");
    
    for (ALAsset *asset in assets) {
        NSLog(@"%@", asset.defaultRepresentation.url);
        NSURL *asseturl = asset.defaultRepresentation.url;
         ALAssetsLibrary* assetslibrary = [[ALAssetsLibrary alloc] init];
         [assetslibrary assetForURL:asseturl
                        resultBlock:resultblock
                       failureBlock:failureblock];
    }
    
    NSLog(@"%@", assets);
    
    [self dismissImagePickerController];
}

- (void)qb_imagePickerControllerDidCancel:(QBImagePickerController *)imagePickerController
{
    NSLog(@"*** qb_imagePickerControllerDidCancel:");
    
    [self dismissImagePickerController];
}

- (IBAction)UploadButtonClick:(id)sender {
    UIImage *image = [UIImage imageNamed:@"PicPicLogo.png"];
    NSData *imageData = UIImageJPEGRepresentation(image, 0.5);
    
    [NetWorkApi uploadPictureWithHeader:self.userToken
                                  image:imageData
                             completion:^(BOOL success, id info) {
                                 if (success) {
                                     NSLog(@"upload success");
                                 } else
                                     NSLog(@"upload fail");
                             }];
}

- (IBAction)LogOutButtonClick:(id)sender {
    //customized alert view
    LCAlertView *alert = [[LCAlertView alloc]initWithTitle:@"LogOut" message:@"Are you sure to logout?" delegate:self cancelButtonTitle:@"Cancle" otherButtonTitles:@"Sure",nil];
        [alert show];
}

- (void)alertView:(LCAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{

    NSLog(@"alert:%li", (long)buttonIndex);
    //if click "sure", do SignOut
    if (buttonIndex==1) {
        [NetWorkApi signOutAccountWithHeader:self.userToken
                                  completion:^(BOOL success, id info){
                                      if (success) {
                                          //delete user defaults
                                          [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"username"];
                                          [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"password"];
                                          [[NSUserDefaults standardUserDefaults] synchronize];
                                          [self performSegueWithIdentifier:@"SignOut" sender: self];
                                          NSLog(@"Logout Success");
                                      } else {
                                          NSLog(@"Logout Failed");
                                      }
                                  }];
    }
}


- (void)leftSwipeHandle:(UISwipeGestureRecognizer*)gestureRecognizer
{
    //Do moving
    [self performSegueWithIdentifier:@"swipToRandomPicPage" sender:self];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
