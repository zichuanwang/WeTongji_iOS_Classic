//
//  RootViewController.m
//  WeTongji
//
//  Created by 紫川 王 on 12-3-6.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "RootViewController.h"
#import "MetroViewController.h"
#import "UserInfoViewController.h"

@interface RootViewController ()

@property (strong, nonatomic) MetroViewController *metroViewController;
@property (strong, nonatomic) UserInfoViewController *userInfoViewController;

@end

@implementation RootViewController

@synthesize defaultImageView = _defaultImageView;
@synthesize metroViewController = _metroViewController;
@synthesize userInfoViewController = _userInfoViewController;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if(self) {
        self.userInfoViewController = [[UserInfoViewController alloc] init];
        self.metroViewController = [[MetroViewController alloc] init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    [self.view insertSubview:self.userInfoViewController.view belowSubview:self.defaultImageView];
    [self.view insertSubview:self.metroViewController.view belowSubview:self.defaultImageView];
    
    //[self.view insertSubview:self.rootMetroViewController.view belowSubview:self.defaultImageView];
    
    self.defaultImageView.alpha = 1.0f;
    [UIView animateWithDuration:0.3f delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        self.defaultImageView.alpha = 0;
    } completion:nil];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    self.defaultImageView = nil;
}

@end
