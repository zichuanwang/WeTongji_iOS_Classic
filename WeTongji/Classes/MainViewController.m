//
//  MainViewController.m
//  WeTongji
//
//  Created by 紫川 王 on 12-3-7.
//  Copyright (c) 2012年 Tongji Apple Club. All rights reserved.
//

#import "MainViewController.h"
#import "UserInfoTableViewController.h"
#import "ToDoListTableViewController.h"
#import "UIView+Addition.h"
#import "UIBarButtonItem+WTBarButtonItem.h"
#import "SettingTableViewController.h"
#import "WTClient.h"
#import "PromoteLoginViewController.h"
#import "NSNotificationCenter+Addition.h"

typedef enum {
    UserInfoTabBarViewController,
    ToDoListTabBarViewController,
    SettingTabBarViewController,
} TabBarViewControllerName;

@interface MainViewController ()

@property (nonatomic, assign) TabBarViewControllerName currentTabBarSubViewControllerName;
@property (nonatomic, strong) UserInfoTableViewController *userInfoViewController;
@property (nonatomic, strong) ToDoListTableViewController *toDoListTableViewController;
@property (nonatomic, strong) SettingTableViewController *settingViewController;
@property (nonatomic, strong) PromoteLoginViewController *promoteLoginViewController;

- (void)configureNavigationBar;
- (void)configureTabBarButtons;

@end

@implementation MainViewController

@synthesize userInfoButton = _userInfoButton;
@synthesize checkButton = _checkButton;
@synthesize settingButton = _settingButton;
@synthesize tabBarView = _tabBarView;
@synthesize headerCoverImageView = _headerCoverImageView;
@synthesize tabBarContentView = _tabBarContentView;
@synthesize tabBarBgImageView = _tabBarBgImageView;
@synthesize tabBarSeperatorImageView = _tabBarSeperatorImageView;

@synthesize currentTabBarSubViewControllerName = _currentTabBarSubViewControllerName;
@synthesize userInfoViewController = _userInfoViewController;
@synthesize toDoListTableViewController = _toDoListTableViewController;
@synthesize settingViewController = _settingViewController;
@synthesize promoteLoginViewController = _promoteLoginViewController;

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    //self.navigationController.navigationBar.hidden = NO;
    [self configureNavigationBar];
    [self configureTabBarButtons];
    [self configureUserInfoTabBarViewController];
    [self configureTabBarUIStyle];
    [self updateUIAccordingToCurrentUserStatus];
    [NSNotificationCenter registerChangeCurrentUserNotificationWithSelector:@selector(handleChangeCurrentUserNotification:) target:self]; 
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
    self.tabBarContentView = nil;
    self.tabBarBgImageView = nil;
    self.tabBarSeperatorImageView = nil;
    [self clearAllTabBarSubview];
}

#pragma mark -
#pragma mark Logic methods 

- (void)updateUIAccordingToCurrentUserStatus {
    if(self.currentUser == nil) {
        if(self.promoteLoginViewController == nil) {
            [self configurePromoteLoginView];
        }
        self.tabBarContentView.hidden = YES;
    } else {
        [self.promoteLoginViewController.view removeFromSuperview];
        self.promoteLoginViewController = nil;
        self.tabBarContentView.hidden = NO;
    }
}

#pragma mark -
#pragma mark UI methods

- (void)configureTabBarUIStyle {
    UIStyle style = [NSUserDefaults getCurrentUIStyle];
    if(style == UIStyleBlackChocolate){
        self.tabBarBgImageView.image = [UIImage imageNamed:@"main_tab_bar_bg"];
        self.tabBarSeperatorImageView.image = [UIImage imageNamed:@"main_tab_bar_three_interval_seperator"];
        [self.userInfoButton setImage:[UIImage imageNamed:@"main_tab_bar_btn_user"] forState:UIControlStateNormal];
        [self.checkButton setImage:[UIImage imageNamed:@"main_tab_bar_btn_check"] forState:UIControlStateNormal];
        [self.settingButton setImage:[UIImage imageNamed:@"main_tab_bar_btn_setting"] forState:UIControlStateNormal];
    } else if(style == UIStyleWhiteChocolate) {
        self.tabBarBgImageView.image = [UIImage imageNamed:@"main_tab_bar_bg_white"];
        self.tabBarSeperatorImageView.image = [UIImage imageNamed:@"main_tab_bar_three_interval_seperator_white"];
        [self.userInfoButton setImage:[UIImage imageNamed:@"main_tab_bar_btn_user_white"] forState:UIControlStateNormal];
        [self.checkButton setImage:[UIImage imageNamed:@"main_tab_bar_btn_check_white"] forState:UIControlStateNormal];
        [self.settingButton setImage:[UIImage imageNamed:@"main_tab_bar_btn_setting_white"] forState:UIControlStateNormal];
    }
}

- (void)configureNavigationBar {
    UIImageView *logoImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    logoImageView.image = [UIImage imageNamed:@"nav_bar_logo.png"];    
    self.navigationItem.titleView = logoImageView;
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
    if(self.userInfoViewController) {
        self.userInfoViewController.view.hidden = NO;
        return;
    }
    UserInfoTableViewController *vc = [[UserInfoTableViewController alloc] init];
    CGRect frame =  vc.view.frame;
    frame.origin = CGPointMake(0, 44);
    vc.view.frame = frame;
    self.userInfoViewController = vc;
    [self.tabBarContentView insertSubview:vc.view belowSubview:self.tabBarView];
}

- (void)configureToDoListTabBarViewController {
    if(self.toDoListTableViewController) {
        [self.toDoListTableViewController refresh];
        self.toDoListTableViewController.view.hidden = NO;
        return;
    }
    ToDoListTableViewController *vc = [[ToDoListTableViewController alloc] init];
    CGRect frame =  vc.view.frame;
    frame.origin = CGPointMake(0, 44);
    vc.view.frame = frame;
    self.toDoListTableViewController = vc;
    [self.tabBarContentView insertSubview:vc.view belowSubview:self.tabBarView];
}

- (void)configureSettingTabBarViewController {
    if(self.settingViewController) {
        self.settingViewController.view.hidden = NO;
        return;
    }
    SettingTableViewController *vc = [[SettingTableViewController alloc] init];
    CGRect frame =  vc.view.frame;
    frame.origin = CGPointMake(0, 44);
    vc.view.frame = frame;
    self.settingViewController = vc;
    self.settingViewController.delegate = self;
    [self.tabBarContentView insertSubview:vc.view belowSubview:self.tabBarView];
}

- (void)clearCurrentTabBarSubViewController {
    self.userInfoViewController.view.hidden = YES;
    self.toDoListTableViewController.view.hidden = YES;
    self.settingViewController.view.hidden = YES;
}

- (void)clearAllTabBarSubview {
    [self.userInfoViewController.view removeFromSuperview];
    self.userInfoViewController = nil;
    [self.toDoListTableViewController.view removeFromSuperview];
    self.toDoListTableViewController = nil;
    [self.settingViewController.view removeFromSuperview];
    self.settingViewController = nil;
}

- (void)configurePromoteLoginView {
    self.promoteLoginViewController = [[PromoteLoginViewController alloc] init];
    [self.view insertSubview:self.promoteLoginViewController.view belowSubview:self.navBarShadowImageView];
    self.promoteLoginViewController.view.hidden = NO;
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

#pragma mark - 
#pragma mark SettingTableViewController delegate

- (void)settingTableViewController:(SettingTableViewController *)vc pushViewController:(UIViewController *)pushVc {
    [self.navigationController pushViewController:pushVc animated:YES];
}

#pragma mark -
#pragma mark Handle notifications

- (void)handleChangeCurrentUserNotification:(NSNotification *)notification {
    [self updateUIAccordingToCurrentUserStatus];
}

- (void)handleChangeCurrentUIStyleNotification:(NSNotification *)notification {
    [super handleChangeCurrentUIStyleNotification:notification];
    [self configureTabBarUIStyle];
}

@end