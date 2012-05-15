//
//  ScheduleViewController.h
//  WeTongji
//
//  Created by 紫川 王 on 12-4-8.
//  Copyright (c) 2012年 Tongji Apple Club. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WTNavigationViewController.h"
#import "WTButton.h"
#import "ScheduleDayTableViewController.h"

@interface ScheduleViewController : WTNavigationViewController<ScheduleDayTableViewControllerDelegate>

@property (nonatomic, strong) IBOutlet WTButton *todayButton;
@property (nonatomic, strong) IBOutlet WTButton *dayButton;
@property (nonatomic, strong) IBOutlet WTButton *weekButton;
@property (nonatomic, strong) IBOutlet WTButton *monthButton;
@property (nonatomic, strong) IBOutlet UIImageView *tabBarBgImageView;
@property (nonatomic, strong) IBOutlet UIImageView *tabBarSeperatorImageView;
@property (nonatomic, strong) IBOutlet UIView *tabBarView;

- (IBAction)didClickTabBarButton:(UIButton *)sender;
- (IBAction)didClickTodayButton:(UIButton *)sender;

@end
