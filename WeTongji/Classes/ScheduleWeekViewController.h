//
//  ScheduleWeekViewController.h
//  WeTongji
//
//  Created by 紫川 王 on 12-5-12.
//  Copyright (c) 2012年 Tongji Apple Club. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoreDataViewController.h"

#define BEGIN_HOUR  7
#define END_HOUR    22
#define LEFT_TABLE_VIEW_ROW_COUNT   (END_HOUR - BEGIN_HOUR + 1)

@interface ScheduleWeekViewController : CoreDataViewController<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) IBOutlet UITableView *rightTableView;
@property (nonatomic, strong) IBOutlet UITableView *leftTableView;

- (void)didClickTodayButton;

@end
