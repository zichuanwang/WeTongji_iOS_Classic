//
//  WTNavigationViewController.m
//  WeTongji
//
//  Created by 紫川 王 on 12-4-14.
//  Copyright (c) 2012年 Tongji Apple Club. All rights reserved.
//

#import "WTNavigationViewController.h"
#import "NSUserDefaults+Addition.h"
#import "NSNotificationCenter+Addition.h"

@interface WTNavigationViewController ()

@end

@implementation WTNavigationViewController

@synthesize navBarShadowImageView = _navBarShadowImageView;
@synthesize bgImageView = _bgImageView;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    if([self.navigationController.navigationBar respondsToSelector:@selector(setBackgroundImage:forBarMetrics:)] ) {
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"nav_bar_bg.png"] forBarMetrics:UIBarMetricsDefault];
    }
    [self configureBgImageView];
    [NSNotificationCenter registerChangeCurrentUIStyleNotificationWithSelector:@selector(handleChangeCurrentUIStyleNotification:) target:self];
}

- (void)viewDidUnload {
    self.navBarShadowImageView = nil;
    self.bgImageView = nil;
}

#pragma mark -
#pragma mark UI methods

- (void)configureBgImageView {
    UIStyle style = [NSUserDefaults getCurrentUIStyle];
    if(style == UIStyleBlackChocolate){
        self.bgImageView.image = [UIImage imageNamed:@"main_bg.png"];
    } else if(style == UIStyleWhiteChocolate) {
        self.bgImageView.image = [UIImage imageNamed:@"main_bg_white.png"];
    }
}

#pragma mark -
#pragma mark Handle notifications

- (void)handleChangeCurrentUIStyleNotification:(NSNotification *)notification {
    [self configureBgImageView];
}

@end
