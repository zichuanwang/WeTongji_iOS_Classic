//
//  UserInfoTableViewCell.m
//  WeTongji
//
//  Created by 紫川 王 on 12-4-13.
//  Copyright (c) 2012年 Tongji Apple Club. All rights reserved.
//

#import "LoginListTableViewCell.h"

@interface LoginListTableViewCell ()

@end

@implementation LoginListTableViewCell

@synthesize userNameLabel = _userNameLabel;
@synthesize avatarImageView = _avatarImageView;

- (void)awakeFromNib {
    self.userNameLabel.text = @"";
}

@end
