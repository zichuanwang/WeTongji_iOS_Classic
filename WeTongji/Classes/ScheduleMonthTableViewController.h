//
//  ScheduleMonthTableViewController.h
//  WeTongji
//
//  Created by 紫川 王 on 12-5-17.
//  Copyright (c) 2012年 Tongji Apple Club. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoreDataTableViewController.h"

@protocol ScheduleDayTableViewControllerDelegate;

@interface ScheduleMonthTableViewController : CoreDataTableViewController

@property (nonatomic, strong) NSDate *selectedDate;
@property (nonatomic, weak) id<ScheduleDayTableViewControllerDelegate> delegate;

@end
