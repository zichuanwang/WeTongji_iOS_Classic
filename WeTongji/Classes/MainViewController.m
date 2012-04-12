//
//  MainViewController.m
//  WeTongji
//
//  Created by 紫川 王 on 12-3-7.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "MainViewController.h"
#import "UserInfoTableViewController.h"

@interface MainViewController ()

@property (strong, nonatomic) UserInfoTableViewController *userInfoViewController;

- (void)configureNavigationBar;
- (void)configureTabBarButtons;

@end

@implementation MainViewController

@synthesize userInfoButton = _userInfoButton;
@synthesize checkButton = _checkButton;
@synthesize settingButton = _settingButton;

@synthesize userInfoViewController = _userInfoViewController;

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    //self.navigationController.navigationBar.hidden = NO;
    
    [self configureNavigationBar];
    [self configureTabBarButtons];
    [self configureUserInfo];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)configureNavigationBar {
    if([self.navigationController.navigationBar respondsToSelector:@selector(setBackgroundImage:forBarMetrics:)] ) {
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navigation_bar_bg.png"] forBarMetrics:UIBarMetricsDefault];
    }
    UIImageView *logoImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    logoImageView.image = [UIImage imageNamed:@"navigation_bar_logo.png"];
    [self.navigationController.view addSubview:logoImageView];
}

- (void)configureTabBarButtons {
    self.userInfoButton.highlightedImageView.image = [UIImage imageNamed:@"main_tab_bar_btn_user_hl"];
    self.checkButton.highlightedImageView.image = [UIImage imageNamed:@"main_tab_bar_btn_check_hl"];
    self.settingButton.highlightedImageView.image = [UIImage imageNamed:@"main_tab_bar_btn_setting_hl"];
    
    [self.userInfoButton setSelected:YES];
}

- (void)configureUserInfo {
    UserInfoTableViewController *vc = [[UserInfoTableViewController alloc] init];
    CGRect frame =  vc.view.frame;
    frame.origin = CGPointMake(0, 44);
    vc.view.frame = frame;
    self.userInfoViewController = vc;
    [self.view addSubview:vc.view];
}

#pragma mark - 
#pragma mark IBActions 

- (IBAction)didClickTabBarButton:(UIButton *)sender {
    NSArray *buttonArray = [NSArray arrayWithObjects:self.userInfoButton, self.checkButton, self.settingButton, nil];
    [buttonArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        UIButton *btn = obj;
        if(btn == sender) {
            [btn setSelected:YES];
        }
        else {
            [btn setSelected:NO];
        }
    }];
}

@end
