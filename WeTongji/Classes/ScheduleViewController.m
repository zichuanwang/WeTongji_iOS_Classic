//
//  ScheduleViewController.m
//  WeTongji
//
//  Created by 紫川 王 on 12-4-8.
//  Copyright (c) 2012年 Tongji Apple Club. All rights reserved.
//

#import "ScheduleViewController.h"
#import "NSUserDefaults+Addition.h"

@interface ScheduleViewController ()

@end

@implementation ScheduleViewController

@synthesize dayButton = _dayButton;
@synthesize weekButton = _weekButton;
@synthesize monthButton = _monthButton;
@synthesize todayButton = _todayButton;
@synthesize tabBarBgImageView = _tabBarBgImageView;
@synthesize tabBarSeperatorImageView = _tabBarSeperatorImageView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self configureNavBar];
    [self configureTabBar];
    [self configureTabBarUIStyle];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    self.todayButton = nil;
    self.dayButton = nil;
    self.weekButton = nil;
    self.monthButton = nil;
    self.tabBarSeperatorImageView = nil;
    self.tabBarBgImageView = nil;
}

#pragma mark -
#pragma mark UI methods

- (void)configureTabBarUIStyle {
    UIStyle style = [NSUserDefaults getCurrentUIStyle];
    if(style == UIStyleBlackChocolate){
        self.tabBarBgImageView.image = [UIImage imageNamed:@"main_tab_bar_bg"];
        self.tabBarSeperatorImageView.image = [UIImage imageNamed:@"main_tab_bar_four_interval_seperator"];
        [self.todayButton setImage:[UIImage imageNamed:@"schedule_btn_today"] forState:UIControlStateNormal];
        [self.dayButton setImage:[UIImage imageNamed:@"schedule_btn_day"] forState:UIControlStateNormal];
        [self.weekButton setImage:[UIImage imageNamed:@"schedule_btn_week"] forState:UIControlStateNormal];
        [self.monthButton setImage:[UIImage imageNamed:@"schedule_btn_month"] forState:UIControlStateNormal];
    } else if(style == UIStyleWhiteChocolate) {
        self.tabBarBgImageView.image = [UIImage imageNamed:@"main_tab_bar_bg_white"];
        self.tabBarSeperatorImageView.image = [UIImage imageNamed:@"main_tab_bar_four_interval_seperator_white"];
        [self.todayButton setImage:[UIImage imageNamed:@"schedule_btn_today_white"] forState:UIControlStateNormal];
        [self.dayButton setImage:[UIImage imageNamed:@"schedule_btn_day_white"] forState:UIControlStateNormal];
        [self.weekButton setImage:[UIImage imageNamed:@"schedule_btn_week_white"] forState:UIControlStateNormal];
        [self.monthButton setImage:[UIImage imageNamed:@"schedule_btn_month_white"] forState:UIControlStateNormal];
    }
}

- (void)configureNavBar {
    UILabel *titleLabel = [UILabel getNavBarTitleLabel:@"日程"];
    self.navigationItem.titleView = titleLabel;
    
    UIBarButtonItem *finishButton = [UIBarButtonItem getFunctionButtonItemWithTitle:@"完成" target:self action:@selector(didClickfinishButton)];
    self.navigationItem.leftBarButtonItem = finishButton;
}

- (void)configureTabBar {
    self.todayButton.highlightedImageView.image = [UIImage imageNamed:@"schedule_btn_today_hl"];
    self.dayButton.highlightedImageView.image = [UIImage imageNamed:@"schedule_btn_day_hl"];
    self.weekButton.highlightedImageView.image = [UIImage imageNamed:@"schedule_btn_week_hl"];
    self.monthButton.highlightedImageView.image = [UIImage imageNamed:@"schedule_btn_month_hl"];
}

#pragma mark -
#pragma mark IBActions 

- (void)didClickfinishButton {
    [self.parentViewController dismissModalViewControllerAnimated:YES];
}

@end
