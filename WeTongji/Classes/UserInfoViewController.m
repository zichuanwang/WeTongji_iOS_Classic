//
//  UserInfoViewController.m
//  WeTongji
//
//  Created by 紫川 王 on 12-3-7.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "UserInfoViewController.h"

@interface UserInfoViewController ()

@end

@implementation UserInfoViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    //self.navigationController.navigationBar.hidden = NO;
    if([self.navigationController.navigationBar respondsToSelector:@selector(setBackgroundImage:forBarMetrics:)] ) {
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navigation_bar_bg.png"] forBarMetrics:UIBarMetricsDefault];
    }
    UIImageView *logoImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    logoImageView.image = [UIImage imageNamed:@"navigation_bar_logo@2x.png"];
    [self.navigationController.view addSubview:logoImageView];
    
    NSLog(@"frame y:%f", self.view.frame.origin.y);
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

@end
