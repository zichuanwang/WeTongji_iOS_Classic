//
//  UIBarButtonItem+WTBarButtonItem.h
//  WeTongji
//
//  Created by 紫川 王 on 12-4-17.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//



@interface UIBarButtonItem (WTBarButtonItem)

+ (UIBarButtonItem *)getFunctionButtonItemWithTitle:(NSString *)title target:(id)target action:(SEL)action;

+ (UIBarButtonItem *)getBackButtonItemWithTitle:(NSString *)title target:(id)target action:(SEL)action;

@end
