//
//  ScheduleWeekRightTableViewCell.h
//  WeTongji
//
//  Created by 紫川 王 on 12-5-19.
//  Copyright (c) 2012年 Tongji Apple Club. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ScheduleWeekRightTableViewCellContentView.h"

@interface ScheduleWeekRightTableViewCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UILabel *weekDayLabel;
@property (nonatomic, weak) IBOutlet ScheduleWeekRightTableViewCellContentView *drawView;

- (void)setDrawViewVerticalOffset:(CGFloat)offset row:(NSInteger)row dataArray:(NSArray *)array;
- (void)setDrawViewVerticalOffset:(CGFloat)offset;

@end
