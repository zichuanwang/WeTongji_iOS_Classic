//
//  UserInfoTableViewCell.m
//  WeTongji
//
//  Created by 紫川 王 on 12-4-13.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "UserInfoTableViewCell.h"

@interface UserInfoTableViewCell ()

@end

@implementation UserInfoTableViewCell

@synthesize categoryLabel = _categoryLabel;
@synthesize contentLabel = _contentLabel;

- (void)awakeFromNib {
    self.categoryLabel.text = @"";
    self.contentLabel.text = @"";
    
    UIView *tempView = [[UIView alloc] init];
    [self setBackgroundView:tempView];
}

@end
