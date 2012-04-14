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

@interface MainViewController ()

@property (strong, nonatomic) UserInfoTableViewController *userInfoViewController;
@property (strong, nonatomic) ToDoListTableViewController *toDoListTableViewController;

- (void)configureNavigationBar;
- (void)configureTabBarButtons;

@end

@implementation MainViewController

@synthesize userInfoButton = _userInfoButton;
@synthesize checkButton = _checkButton;
@synthesize settingButton = _settingButton;
@synthesize tabBarView = _tabBarView;

@synthesize userInfoViewController = _userInfoViewController;
@synthesize toDoListTableViewController = _toDoListTableViewController;

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    //self.navigationController.navigationBar.hidden = NO;
    
    [self configureNavigationBar];
    [self configureTabBarButtons];
    [self configureUserInfo];
    [self configureToDoList];
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
}

- (void)configureNavigationBar {
    UIImageView *logoImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    logoImageView.image = [UIImage imageNamed:@"nav_bar_logo.png"];
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
    frame.origin = CGPointMake(0, 45);
    vc.view.frame = frame;
    self.userInfoViewController = vc;
    [self.view insertSubview:vc.view belowSubview:self.tabBarView];
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
                [vc.view fadeIn];
        }
        else {
            [btn setSelected:NO];
            if(idx < viewControllerArray.count) {
                UIViewController *vc = [viewControllerArray objectAtIndex:idx];
                if(vc.view.alpha != 0)
                    [vc.view fadeOut];
            }
        }
    }];
}

@end
