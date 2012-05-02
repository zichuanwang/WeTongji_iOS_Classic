//
//  WTNavigationViewController.m
//  WeTongji
//
//  Created by 紫川 王 on 12-4-14.
//  Copyright (c) 2012年 Tongji Apple Club. All rights reserved.
//

#import "WTNavigationViewController.h"

@interface WTNavigationViewController ()

@end

@implementation WTNavigationViewController

@synthesize navBarShadowImageView = _navBarShadowImageView;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    if([self.navigationController.navigationBar respondsToSelector:@selector(setBackgroundImage:forBarMetrics:)] ) {
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"nav_bar_bg.png"] forBarMetrics:UIBarMetricsDefault];
    }
}

- (void)viewDidUnload {
    self.navBarShadowImageView = nil;
}

@end
