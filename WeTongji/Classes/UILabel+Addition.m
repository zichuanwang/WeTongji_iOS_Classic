//
//  UILabel+Addition.m
//  WeTongji
//
//  Created by 紫川 王 on 12-4-25.
//  Copyright (c) 2012年 Tongji Apple Club. All rights reserved.
//

#import "UILabel+Addition.h"

@implementation UILabel (Addition)

+ (UILabel *)getNavBarTitleLabel:(NSString *)text {
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 44)];
    titleLabel.text = text;
    titleLabel.font = [UIFont boldSystemFontOfSize:20];
    titleLabel.minimumFontSize = 13;
    titleLabel.textColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.8];
    titleLabel.shadowColor = [UIColor darkGrayColor];
    titleLabel.shadowOffset = CGSizeMake(0, 1);
    [titleLabel sizeToFit];
    titleLabel.backgroundColor = [UIColor clearColor];
    return titleLabel;
}

@end
