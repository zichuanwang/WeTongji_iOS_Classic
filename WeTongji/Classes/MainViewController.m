//
//  MainViewController.m
//  WeTongji
//
//  Created by 紫川 王 on 12-3-7.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "MainViewController.h"
#import "UserInfoTableViewController.h"
#import "ToDoListTableViewController.h"
#import "UIView+Addition.h"
#import "UIBarButtonItem+WTBarButtonItem.h"
#import "LoginTableViewController.h"
#import "SettingTableViewController.h"
#import "WTClient.h"

typedef enum {
    UserInfoTabBarViewController,
    ToDoListTabBarViewController,
    SettingTabBarViewController,
} TabBarViewControllerName;

@interface MainViewController ()

@property (nonatomic, assign) TabBarViewControllerName currentTabBarSubViewControllerName;
@property (nonatomic, strong) UserInfoTableViewController *userInfoViewController;
@property (nonatomic, strong) ToDoListTableViewController *toDoListTableViewController;
@property (nonatomic, strong) LoginTableViewController *loginUserListViewController;
@property (nonatomic, strong) SettingTableViewController *settingViewController;

- (void)configureNavigationBar;
- (void)configureTabBarButtons;

@end

@implementation MainViewController

@synthesize userInfoButton = _userInfoButton;
@synthesize checkButton = _checkButton;
@synthesize settingButton = _settingButton;
@synthesize tabBarView = _tabBarView;
@synthesize headerCoverImageView = _headerCoverImageView;

@synthesize currentTabBarSubViewControllerName = _currentTabBarSubViewControllerName;
@synthesize userInfoViewController = _userInfoViewController;
@synthesize toDoListTableViewController = _toDoListTableViewController;
@synthesize loginUserListViewController = _loginUserListViewController;
@synthesize settingViewController = _settingViewController;

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    //self.navigationController.navigationBar.hidden = NO;
    [self configureNavigationBar];
    [self configureTabBarButtons];
    [self configureUserInfoTabBarViewController];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    self.tabBarView = nil;
    self.userInfoButton = nil;
    self.settingButton = nil;
    self.checkButton = nil;
    self.headerCoverImageView = nil;
}

- (void)configureNavigationBar {
    UIImageView *logoImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    logoImageView.image = [UIImage imageNamed:@"nav_bar_logo.png"];
    [self.navigationController.view addSubview:logoImageView];
    
    UIBarButtonItem *logoutButton = [UIBarButtonItem getFunctionButtonItemWithTitle:@"登出" target:self   action:@selector(didClickLogoutButton)];
    self.navigationItem.rightBarButtonItem = logoutButton;
    self.navigationItem.rightBarButtonItem.enabled = YES;
}

- (void)configureTabBarButtons {
    self.userInfoButton.highlightedImageView.image = [UIImage imageNamed:@"main_tab_bar_btn_user_hl"];
    self.checkButton.highlightedImageView.image = [UIImage imageNamed:@"main_tab_bar_btn_check_hl"];
    self.settingButton.highlightedImageView.image = [UIImage imageNamed:@"main_tab_bar_btn_setting_hl"];
    
    [self.userInfoButton setSelected:YES];
}

- (void)configureTabBarSubViewController:(TabBarViewControllerName)viewControllerName {
    if(self.currentTabBarSubViewControllerName == viewControllerName)
        return;
    [self clearCurrentTabBarSubViewController];
    self.currentTabBarSubViewControllerName = viewControllerName;
    if(viewControllerName == UserInfoTabBarViewController) {
        [self configureUserInfoTabBarViewController];
    }
    else if(viewControllerName == ToDoListTabBarViewController) {
        [self configureToDoListTabBarViewController];
    }
    else if(viewControllerName == SettingTabBarViewController) {
        [self configureSettingTabBarViewController];
    }
}

- (void)configureUserInfoTabBarViewController {
    UserInfoTableViewController *vc = [[UserInfoTableViewController alloc] init];
    CGRect frame =  vc.view.frame;
    frame.origin = CGPointMake(0, 44);
    vc.view.frame = frame;
    self.userInfoViewController = vc;
    [self.view insertSubview:vc.view belowSubview:self.tabBarView];
}

- (void)configureToDoListTabBarViewController {
    ToDoListTableViewController *vc = [[ToDoListTableViewController alloc] init];
    CGRect frame =  vc.view.frame;
    frame.origin = CGPointMake(0, 44);
    vc.view.frame = frame;
    self.toDoListTableViewController = vc;
    [self.view insertSubview:vc.view belowSubview:self.tabBarView];
}

- (void)configureSettingTabBarViewController {
    SettingTableViewController *vc = [[SettingTableViewController alloc] init];
    CGRect frame =  vc.view.frame;
    frame.origin = CGPointMake(0, 44);
    vc.view.frame = frame;
    self.settingViewController = vc;
    [self.view insertSubview:vc.view belowSubview:self.tabBarView];
}

- (void)configureLoginUserList {
    LoginTableViewController *vc = [[LoginTableViewController alloc] init];
    CGRect frame =  vc.view.frame;
    frame.origin = CGPointMake(0, 0);
    vc.view.frame = frame;
    vc.view.alpha = 0;
    self.loginUserListViewController = vc;
    [self.view insertSubview:vc.view belowSubview:self.tabBarView];
}

- (void)clearCurrentTabBarSubViewController {
    if(self.currentTabBarSubViewControllerName == UserInfoTabBarViewController) {
        [self.userInfoViewController.view removeFromSuperview];
        self.userInfoViewController = nil;
    }
    else if(self.currentTabBarSubViewControllerName == ToDoListTabBarViewController) {
        [self.toDoListTableViewController.view removeFromSuperview];
        self.toDoListTableViewController = nil;
    }
    else if(self.currentTabBarSubViewControllerName == SettingTabBarViewController) {
        [self.settingViewController.view removeFromSuperview];
        self.settingViewController = nil;
    }
}

#pragma mark - 
#pragma mark IBActions 

- (IBAction)didClickTabBarButton:(UIButton *)sender {
    
    NSArray *buttonArray = [NSArray arrayWithObjects:self.userInfoButton, self.checkButton, self.settingButton, nil];
    [buttonArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        UIButton *btn = obj;
        if(btn == sender) {
            [btn setSelected:YES];
            [self configureTabBarSubViewController:idx];
        }
        else {
            [btn setSelected:NO];
        }
    }];
}

@end
