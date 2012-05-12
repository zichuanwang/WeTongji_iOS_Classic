//
//  RootView.m
//  WeTongji
//
//  Created by 紫川 王 on 12-3-7.
//  Copyright (c) 2012年 Tongji Apple Club. All rights reserved.
//

#import "RootView.h"

@implementation RootView

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    __block UIView *subview = [super hitTest:point withEvent:event];
    if(subview.tag == ROOT_METRO_SCROLL_HEADER_VIEW_TAG) {
        //NSLog(@"touch x:%f, touch y:%f", point.x, point.y);
        [[self subviews] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            UIView *view = obj;
            if(view.tag == ROOT_MAIN_VIEW_TAG) {
                subview = view;
                *stop = YES;
            }
        }];
        subview = [subview hitTest:point withEvent:event];
    }
    return subview;
}

@end
