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
@synthesize contentVerticalOffset = _contentVerticalOffset;

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

- (void)setContentVerticalOffset:(CGFloat)contentVerticalOffset {
    _contentVerticalOffset = contentVerticalOffset;
}

@end
