//
//  ChannelSettingTableViewCell.m
//  WeTongji
//
//  Created by 紫川 王 on 12-4-23.
//  Copyright (c) 2012年 Tongji Apple Club. All rights reserved.
//

#import "ChannelSettingTableViewCell.h"

@implementation ChannelSettingTableViewCell

@synthesize categoryLabel = _categoryLabel;
@synthesize itemSwitch = _itemSwitch;
@synthesize delegate = _delegate;

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

- (void)awakeFromNib {
    self.categoryLabel.text = @"";
    
    UIView *tempView = [[UIView alloc] init];
    [self setBackgroundView:tempView];
}

#pragma mark -
#pragma mark IBActions

- (IBAction)didCLickSwitch:(UISwitch *)sender {
    if([self.delegate respondsToSelector:@selector(channelSettingCellDidClickSwitch:)]) {
        [self.delegate channelSettingCellDidClickSwitch:self];
    }
}

@end
