//
//  EditAvatarViewController.m
//  WeTongji
//
//  Created by 紫川 王 on 12-5-9.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "EditAvatarViewController.h"
#import "UIImageView+Addition.h"
#import "UIImage+Addition.h"
#import "UIImage+ProportionalFill.h"

@interface EditAvatarViewController ()

@property (nonatomic, strong) UIImage *originImage;

@end

@implementation EditAvatarViewController

@synthesize cropImageView = _cropImageView;
@synthesize cropImageBgView = _cropImageBgView;
@synthesize delegate = _delegate;
@synthesize originImage = _originImage;

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
    // Do any additional setup after loading the view from its nib.
    [UIApplication sharedApplication].statusBarHidden = NO;
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleBlackOpaque;
    self.navigationController.navigationBarHidden = YES;
    self.cropImageBgView.image = self.originImage;
    
    CGSize cropImageSize = CGSizeMake(self.cropImageBgView.contentScaleFactor * self.originImage.size.width, self.cropImageBgView.contentScaleFactor * self.originImage.size.height);
    [self.cropImageView setCropImageInitSize:cropImageSize center:self.cropImageBgView.center];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    self.cropImageView = nil;
    self.cropImageBgView = nil;
}

- (id)initWithImage:(UIImage *)image {
    self = [super init];
    if(self) {
        self.originImage = [image rotateAdjustImage];
    }
    return self;
}

#pragma mark -
#pragma mark IBActions

- (IBAction)didClickFinishCropButton:(UIButton *)sender {
    CGRect cropImageRect = self.cropImageView.cropImageRect;
    CGFloat factor = 1 / self.cropImageBgView.contentScaleFactor;
    cropImageRect = CGRectMake(cropImageRect.origin.x * factor, cropImageRect.origin.y * factor, cropImageRect.size.width * factor, cropImageRect.size.height * factor);
    UIImage *croppedImage = [UIImage imageWithCGImage:CGImageCreateWithImageInRect(self.cropImageBgView.image.CGImage, cropImageRect)];
    //self.cropImageBgView.frame = self.cropImageView.cropEditRect;
    croppedImage = [croppedImage imageScaledToFitSize:CGSizeMake(100, 100)];
    [self.delegate editAvatarViewDidFinishEdit:croppedImage];
}

- (IBAction)didClickCancelButton:(UIButton *)sender {
    [self.delegate editAvatarViewDidCancelEdit];
}

@end
