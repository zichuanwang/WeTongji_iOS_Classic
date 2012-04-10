//
//  UIImageView+Addition.m
//  WeTongji
//
//  Created by 紫川 王 on 12-4-10.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "UIImageView+Addition.h"

@implementation UIImageView (Addition)

- (void)fadeIn {
    self.alpha = 0;
    [UIView animateWithDuration:0.3f animations:^{
        self.alpha = 1;
    }];
}

- (void)fadeOut {
    self.alpha = 1;
    [UIView animateWithDuration:0.3f animations:^{
        self.alpha = 0;
    }];
}

@end
