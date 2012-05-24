//
//  ScheduleWeekLeftTableView.h
//  WeTongji
//
//  Created by 紫川 王 on 12-5-24.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ScheduleWeekLeftTableViewDelegate;

@interface ScheduleWeekLeftTableView : UITableView {
    NSTimer *_timer;
    CGFloat _speedX, _speedY;
    CGFloat _distanceX, _distanceY;
    NSInteger _timeCountX, _timeCountY;
    NSInteger _freezeCountX, _freezeCountY;
}

@property (nonatomic, weak) IBOutlet id<ScheduleWeekLeftTableViewDelegate> swipeDelegate;
@property (nonatomic, assign) CGFloat speedX;
@property (nonatomic, assign) CGFloat speedY;

@end

@protocol ScheduleWeekLeftTableViewDelegate <NSObject>

- (void)scheduleWeekLeftTableView:(ScheduleWeekLeftTableView *)tableView didSwipeHorizontally:(CGFloat)x swipeVertically:(CGFloat)y;

@end
