//
//  UIView+Addition.m
//  WeTongji
//
//  Created by 紫川 王 on 12-4-10.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "UIView+Addition.h"

@implementation UIView (Addition)

- (void)fadeIn {
    self.alpha = 0;
    [UIView animateWithDuration:0.3f delay:0 options:UIViewAnimationCurveLinear animations:^{
        self.alpha = 1;
    } completion:nil];
}

- (void)fadeOut {
    self.alpha = 1;
    [UIView animateWithDuration:0.3f delay:0 options:UIViewAnimationCurveLinear animations:^{
        self.alpha = 0;
    } completion:nil];
}

@end
