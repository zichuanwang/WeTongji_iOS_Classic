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

@property (nonatomic, weak) IBOutlet WTButton *todayButton;
@property (nonatomic, weak) IBOutlet WTButton *dayButton;
@property (nonatomic, weak) IBOutlet WTButton *weekButton;
@property (nonatomic, weak) IBOutlet WTButton *monthButton;
@property (nonatomic, weak) IBOutlet UIImageView *tabBarBgImageView;
@property (nonatomic, weak) IBOutlet UIImageView *tabBarSeperatorImageView;
@property (nonatomic, weak) IBOutlet UIView *tabBarView;

- (IBAction)didClickTabBarButton:(UIButton *)sender;
- (IBAction)didClickTodayButton:(UIButton *)sender;

@end
