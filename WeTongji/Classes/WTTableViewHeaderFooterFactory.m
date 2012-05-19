
//
//  WTTableViewHeaderFooterFactory.m
//  WeTongji
//
//  Created by 紫川 王 on 12-5-12.
//  Copyright (c) 2012年 Tongji Apple Club. All rights reserved.
//

#import "WTTableViewHeaderFooterFactory.h"

@implementation WTTableViewHeaderFooterFactory

+ (UIView *)getWideWTTableViewHeader {
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 30)];
    UIImageView *headerImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"paper_wide_header.png"]];
    headerImageView.center = CGPointMake(160, 10);
    UIImageView *lineImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"paper_wide_single_line.png"]];
    lineImageView.center = CGPointMake(160, 10);
    lineImageView.center = headerImageView.center;
    [headerView addSubview:headerImageView];
    [headerView addSubview:lineImageView];
    return headerView;
}

+ (UIView *)getWideWTTableViewEmptyFooter {
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 30)];
    UIImageView *footerImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"paper_wide_footer.png"]];
    footerImageView.center = CGPointMake(160, 20);
    [footerView addSubview:footerImageView];
    return footerView;
}

+ (UIView *)getWideWTTableViewFooterWithBlank {
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, TABLE_VIEW_CELL_HEIGHT + 30)];
    UIImageView *footerImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"paper_wide_footer.png"]];
    footerImageView.frame = CGRectMake(0, TABLE_VIEW_CELL_HEIGHT, footerImageView.frame.size.width, footerImageView.frame.size.height);
    UIImageView *mainImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"paper_wide_main.png"]];
    mainImageView.frame = CGRectMake(0, 0, 320, TABLE_VIEW_CELL_HEIGHT);
    UIImageView *lineImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"paper_wide_single_line.png"]];
    lineImageView.frame = CGRectMake(0, TABLE_VIEW_CELL_HEIGHT - lineImageView.frame.size.height, lineImageView.frame.size.width, lineImageView.frame.size.height);
    
    [footerView addSubview:footerImageView];
    [footerView addSubview:mainImageView];
    [footerView addSubview:lineImageView];
    
    return footerView;
}

+ (UILabel *)getWideWTTableViewHintLabel:(NSString *)text {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, TABLE_VIEW_CELL_HEIGHT)];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont boldSystemFontOfSize:14.0f];
    label.textColor = [UIColor colorWithRed:0.2f green:0.2f blue:0.2f alpha:1];
    label.shadowColor = [UIColor whiteColor];
    label.shadowOffset = CGSizeMake(0, 1);
    label.text = text;
    label.textAlignment = UITextAlignmentCenter;
    
    return label;
}

+ (UIView *)getWideWTTableViewFooterWithHint:(NSString *)hint {
    UIView *footerView = [WTTableViewHeaderFooterFactory getWideWTTableViewFooterWithBlank];
    UILabel *hintLabel = [WTTableViewHeaderFooterFactory getWideWTTableViewHintLabel:hint];
    [footerView addSubview:hintLabel];
    return footerView;
}

+ (UIView *)getWideWTTableViewFooterWithNoDataHint {
    UIView *footerView = [WTTableViewHeaderFooterFactory getWideWTTableViewFooterWithHint:@"无内容。"];
    return footerView;
    
}

@end
