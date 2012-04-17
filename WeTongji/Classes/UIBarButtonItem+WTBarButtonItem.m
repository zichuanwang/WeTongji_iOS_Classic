//
//  UIBarButtonItem+WTBarButtonItem.m
//  WeTongji
//
//  Created by 紫川 王 on 12-4-17.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "UIBarButtonItem+WTBarButtonItem.h"

@implementation UIBarButtonItem (WTBarButtonItem)

+ (UIBarButtonItem *)getFunctionButtonItemWithTitle:(NSString *)title target:(id)target action:(SEL)action {
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 60, 44)];
    [button setBackgroundImage:[UIImage imageNamed:@"nav_bar_btn_finish.png"] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:@"nav_bar_btn_finish_hl.png"] forState:UIControlStateHighlighted];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor colorWithRed:1 green:1 blue:1 alpha:0.8] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor colorWithRed:1 green:1 blue:1 alpha:0.8f] forState:UIControlStateHighlighted];
    [button setTitleShadowColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont boldSystemFontOfSize:13];
    button.titleLabel.shadowOffset = CGSizeMake(0, 1);
    if(target && action)
        [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *result = [[UIBarButtonItem alloc] initWithCustomView:button];
    return result;
}

@end
