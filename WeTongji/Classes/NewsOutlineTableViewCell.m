//
//  NewsOutlineTableViewCell.m
//  WeTongji
//
//  Created by 紫川 王 on 12-5-3.
//  Copyright (c) 2012年 Tongji Apple Club. All rights reserved.
//

#import "NewsOutlineTableViewCell.h"

@implementation NewsOutlineTableViewCell

@synthesize titleLabel = _titleLabel;
@synthesize categoryLabel = _categoryLabel;
@synthesize timeLabel = _timeLabel;
@synthesize avatarImageView = _avatarImageView;

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

@end
