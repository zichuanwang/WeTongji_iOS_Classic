
//
//  ScheduleDayTableViewCell.m
//  WeTongji
//
//  Created by 紫川 王 on 12-5-12.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ScheduleDayTableViewCell.h"

@implementation ScheduleDayTableViewCell

@synthesize whenLabel = _whenLabel;
@synthesize whereLabel = _whereLabel;
@synthesize whatLabel = _whatLabel;
@synthesize pointImageView = _pointImageView;

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

- (void)setActivityType:(ActivityType)type {
    if(type == ActivityTypeActivity) {
        self.pointImageView.image = [UIImage imageNamed:@"to_do_list_point_blue"];
    } else if(type == ActivityTypeCurriculum) {
        self.pointImageView.image = [UIImage imageNamed:@"to_do_list_point_green"];
    }
}

@end
