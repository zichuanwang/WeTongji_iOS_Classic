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

@interface MainViewController ()

@property (strong, nonatomic) UserInfoTableViewController *userInfoViewController;
@property (strong, nonatomic) ToDoListTableViewController *toDoListTableViewController;
@property (weak, nonatomic) UIViewController *currentViewController;
@property (strong, nonatomic) LoginTableViewController *loginUserListViewController;

- (void)configureNavigationBar;
- (void)configureTabBarButtons;

@end

@implementation MainViewController

@synthesize userInfoButton = _userInfoButton;
@synthesize checkButton = _checkButton;
@synthesize settingButton = _settingButton;
@synthesize tabBarView = _tabBarView;
@synthesize headerCoverImageView = _headerCoverImageView;

@synthesize currentViewController = _currentViewController;
@synthesize userInfoViewController = _userInfoViewController;
@synthesize toDoListTableViewController = _toDoListTableViewController;
@synthesize loginUserListViewController = _loginUserListViewController;

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    //self.navigationController.navigationBar.hidden = NO;
    
    [self configureNavigationBar];
    [self configureTabBarButtons];
    [self configureUserInfo];
    [self configureToDoList];
    [self configureLoginUserList];
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

- (void)configureUserInfo {
    UserInfoTableViewController *vc = [[UserInfoTableViewController alloc] init];
    CGRect frame =  vc.view.frame;
    frame.origin = CGPointMake(0, 45);
    vc.view.frame = frame;
    self.userInfoViewController = vc;
    [self.view insertSubview:vc.view belowSubview:self.tabBarView];
    self.currentViewController = vc;
}

- (void)configureToDoList {
    ToDoListTableViewController *vc = [[ToDoListTableViewController alloc] init];
    CGRect frame =  vc.view.frame;
    frame.origin = CGPointMake(0, 45);
    vc.view.frame = frame;
    vc.view.alpha = 0;
    self.toDoListTableViewController = vc;
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

#pragma mark - 
#pragma mark IBActions 

- (void)hideMainViewWithCompletion:(void (^)(void))completion {
    [UIView animateWithDuration:0.3f animations:^{
        self.tabBarView.alpha = 0;
        self.currentViewController.view.alpha = 0;
    } completion:^(BOOL finished) {
        if(completion)
            completion();
    }];
}

- (void)showMainViewWithCompletion:(void (^)(void))completion {
    [UIView animateWithDuration:0.3f animations:^{
        self.tabBarView.alpha = 1;
        self.currentViewController.view.alpha = 1;
    } completion:^(BOOL finished) {
        if(completion)
            completion();
    }];
}

- (void)hideLoginViewWithCompletion:(void (^)(void))completion {
    CGRect frame = self.loginUserListViewController.view.frame;
    frame.origin.y = 0;
    self.loginUserListViewController.view.frame = frame;
    [UIView animateWithDuration:0.3f animations:^{
        CGRect frame = self.loginUserListViewController.view.frame;
        frame.origin.y = 416;
        self.loginUserListViewController.view.frame = frame;
    } completion:^(BOOL finished) {
        self.loginUserListViewController.view.alpha = 0;
        [self showMainViewWithCompletion:completion];
    }];
    
    
}

- (void)showLoginViewWithCompletion:(void (^)(void))completion {
    self.loginUserListViewController.view.alpha = 1;
    CGRect frame = self.loginUserListViewController.view.frame;
    frame.origin.y = 416;
    self.loginUserListViewController.view.frame = frame;
    [self hideMainViewWithCompletion:^{
        [UIView animateWithDuration:0.3f animations:^{
            CGRect frame = self.loginUserListViewController.view.frame;
            frame.origin.y = 0;
            self.loginUserListViewController.view.frame = frame;
        } completion:^(BOOL finished) {
            if(completion)
                completion();
        }];
    }];
}

#pragma mark - 
#pragma mark IBActions 

- (IBAction)didClickTabBarButton:(UIButton *)sender {
    NSArray *buttonArray = [NSArray arrayWithObjects:self.userInfoButton, self.checkButton, self.settingButton, nil];
    NSArray *viewControllerArray = [NSArray arrayWithObjects:self.userInfoViewController, self.toDoListTableViewController, nil];
    [buttonArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        UIButton *btn = obj;
        if(btn == sender) {
            [btn setSelected:YES];
            UIViewController *vc = [viewControllerArray objectAtIndex:idx];
            if(vc.view.alpha != 1)
                [vc.view transitionFadeIn];
            self.currentViewController = vc;
        }
        else {
            [btn setSelected:NO];
            if(idx < viewControllerArray.count) {
                UIViewController *vc = [viewControllerArray objectAtIndex:idx];
                if(vc.view.alpha != 0)
                    [vc.view transitionFadeOut];
            }
        }
    }];
}

- (void)didClickLogoutButton {
    self.navigationItem.rightBarButtonItem.enabled = NO;
    [self showLoginViewWithCompletion:^{
        UIBarButtonItem *loginButton = [UIBarButtonItem getFunctionButtonItemWithTitle:@"登录" target:self   action:@selector(didClickLoginButton)];
        self.navigationItem.rightBarButtonItem = loginButton;
        self.navigationItem.rightBarButtonItem.enabled = YES;
    }];
}

- (void)didClickLoginButton {
    self.navigationItem.rightBarButtonItem.enabled = NO;
    [self hideLoginViewWithCompletion:^{
        UIBarButtonItem *logoutButton = [UIBarButtonItem getFunctionButtonItemWithTitle:@"登出" target:self   action:@selector(didClickLogoutButton)];
        self.navigationItem.rightBarButtonItem = logoutButton;
        self.navigationItem.rightBarButtonItem.enabled = YES;
    }];
}

@end
