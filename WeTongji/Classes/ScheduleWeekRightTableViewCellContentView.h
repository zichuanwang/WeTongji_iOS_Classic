//
//  ScheduleWeekRightTableViewCellContentView.h
//  WeTongji
//
//  Created by 紫川 王 on 12-5-19.
//  Copyright (c) 2012年 Tongji Apple Club. All rights reserved.
//

#import <UIKit/UIKit.h>

#define LEFT_CELL_HEIGHT 30

@interface ScheduleWeekRightTableViewCellContentView : UIView

@property (nonatomic, assign) NSInteger row;
@property (nonatomic, strong) NSArray *dataArray;

+ (int)startPosConvertFromDate:(NSDate *)date;
+ (int)heightConvertFromTime:(NSDate *)beginTime ToTime:(NSDate *)endTime;

@end
