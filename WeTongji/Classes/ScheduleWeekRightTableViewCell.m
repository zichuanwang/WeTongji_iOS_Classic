//
//  ScheduleWeekRightTableViewCell.m
//  WeTongji
//
//  Created by 紫川 王 on 12-5-19.
//  Copyright (c) 2012年 Tongji Apple Club. All rights reserved.
//

#import "ScheduleWeekRightTableViewCell.h"

@implementation ScheduleWeekRightTableViewCell

@synthesize weekDayLabel = _weekDayLabel;
@synthesize drawView = _drawView;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib {
    self.transform = CGAffineTransformMakeRotation(M_PI_2);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setDrawViewVerticalOffset:(CGFloat)offset row:(NSInteger)row dataArray:(NSArray *)array {
    self.drawView.row = row;
    self.drawView.dataArray = array;
    self.drawView.verticalOffset = offset;
}

- (void)setDrawViewVerticalOffset:(CGFloat)offset {
    self.drawView.verticalOffset = offset;
}

@end
