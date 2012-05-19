//
//  ScheduleMonthViewController.h
//  WeTongji
//
//  Created by 紫川 王 on 12-5-12.
//  Copyright (c) 2012年 Tongji Apple Club. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TKCalendarMonthViewController.h"
#import "ScheduleMonthTableViewController.h"

@interface ScheduleMonthViewController : TKCalendarMonthViewController

@property (nonatomic, strong) ScheduleMonthTableViewController *tableViewController;

- (void)didClickTodayButton;

@end
