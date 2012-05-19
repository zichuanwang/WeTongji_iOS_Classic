//
//  ScheduleWeekViewController.h
//  WeTongji
//
//  Created by 紫川 王 on 12-5-12.
//  Copyright (c) 2012年 Tongji Apple Club. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoreDataViewController.h"

#define BEGIN_TIME  7
#define END_TIME    22
#define LEFT_TABLE_VIEW_ROW_COUNT   (END_TIME - BEGIN_TIME + 1)

@interface ScheduleWeekViewController : CoreDataViewController<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) IBOutlet UITableView *rightTableView;
@property (nonatomic, strong) IBOutlet UITableView *leftTableView;

- (void)didClickTodayButton;

@end
