//
//  ScheduleWeekLeftTableView.h
//  WeTongji
//
//  Created by 紫川 王 on 12-5-24.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ScheduleWeekLeftTableViewDelegate;

@interface ScheduleWeekLeftTableView : UITableView

@property (nonatomic, weak) IBOutlet id<ScheduleWeekLeftTableViewDelegate> swipeDelegate;

@end

@protocol ScheduleWeekLeftTableViewDelegate <NSObject>

- (void)scheduleWeekLeftTableView:(ScheduleWeekLeftTableView *)tableView didSwipeHorizontally:(CGFloat)x swipeVertically:(CGFloat)y;

@end
