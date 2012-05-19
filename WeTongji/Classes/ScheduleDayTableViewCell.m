
//
//  ScheduleDayTableViewCell.m
//  WeTongji
//
//  Created by 紫川 王 on 12-5-12.
//  Copyright (c) 2012年 Tongji Apple Club. All rights reserved.
//

#import "ScheduleDayTableViewCell.h"
#import "Course+Addition.h"
#import "Activity+Addition.h"
#import "NSString+Addition.h"

@implementation ScheduleDayTableViewCell

@synthesize whenLabel = _whenLabel;
@synthesize whereLabel = _whereLabel;
@synthesize whatLabel = _whatLabel;
@synthesize pointImageView = _pointImageView;
@synthesize mainView = _mainView;
@synthesize noDataHintLabel = _noDataHintLabel;

- (void)awakeFromNib {
    self.whenLabel.text = @"";
    self.whereLabel.text = @"";
    self.whatLabel.text = @"";
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setEventType:(EventType)type {
    if(type == EventTypeActivity) {
        self.pointImageView.image = [UIImage imageNamed:@"to_do_list_point_yellow"];
    } else if(type == EventTypeRequiredCurriculum) {
        self.pointImageView.image = [UIImage imageNamed:@"to_do_list_point_blue"];
    } else if(type == EventTypeOptionalCurriculum) {
        self.pointImageView.image = [UIImage imageNamed:@"to_do_list_point_green"];
    }
}

- (void)setAsNormalCell {
    self.mainView.hidden = NO;
    self.noDataHintLabel.hidden = YES;
    self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
}

- (void)setAsTodayTempCell {
    self.mainView.hidden = YES;
    self.noDataHintLabel.hidden = NO;
    self.accessoryType = UITableViewCellAccessoryNone;
}

- (void)configureCell:(Event *)event {
    if(event.what != nil) {
        [self setAsNormalCell];
        self.whatLabel.text = event.what;
        self.whenLabel.text = [NSString timeConvertFromDate:event.begin_time];
        self.whereLabel.text = event.where;
        if([event isMemberOfClass:[Course class]]) {
            Course *course = (Course *)event;
            if([course.require_type isEqualToString:@"必修"]) {
                [self setEventType:EventTypeRequiredCurriculum];
            } else {
                [self setEventType:EventTypeOptionalCurriculum];
            }
        } else if([event isMemberOfClass:[Activity class]]) {
            [self setEventType:EventTypeActivity];
        }
    } else {
        [self setAsTodayTempCell];
    }
}

@end
