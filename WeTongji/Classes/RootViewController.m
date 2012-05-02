//
//  RootViewController.m
//  WeTongji
//
//  Created by 紫川 王 on 12-3-6.
//  Copyright (c) 2012年 Tongji Apple Club. All rights reserved.
//

#import "RootViewController.h"
#import "MetroViewController.h"
#import "MainViewController.h"
#import "RootView.h"

@interface RootViewController ()

@property (nonatomic, strong) MetroViewController *metroViewController;
@property (nonatomic, strong) MainViewController *MainViewController;
@property (nonatomic, strong) UINavigationController *navigationController;

@end

@implementation RootViewController

@synthesize defaultImageView = _defaultImageView;
@synthesize metroViewController = _metroViewController;
@synthesize MainViewController = _MainViewController;
@synthesize navigationController = _navigationController;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if(self) {
        self.MainViewController = [[MainViewController alloc] init];
        self.metroViewController = [[MetroViewController alloc] init];
        UINavigationController *aNavigationController = [[UINavigationController alloc] initWithRootViewController:self.MainViewController];
        self.navigationController = aNavigationController;
        self.navigationController.view.tag = ROOT_USER_INFO_VIEW_TAG;
        self.navigationController.view.frame = CGRectMake(0, 0, 320, 460);
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    [self.view insertSubview:self.navigationController.view belowSubview:self.defaultImageView];
    [self.view insertSubview:self.metroViewController.view belowSubview:self.defaultImageView];

    self.defaultImageView.alpha = 1.0f;
    [UIView animateWithDuration:0.6f delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
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
