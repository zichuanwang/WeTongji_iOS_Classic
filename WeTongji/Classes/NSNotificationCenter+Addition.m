//
//  NSNotificationCenter+Addition.m
//  SocialFusion
//
//  Created by 王紫川 on 12-1-24.
//  Copyright (c) 2012年 Tongji Apple Club. All rights reserved.
//

#import "NSNotificationCenter+Addition.h"

#define kChangeCurrentUserNotification @"kChangeCurrentUserNotification"
#define kCoreChangeCurrentUserNotification @"kCoreChangeCurrentUserNotification"
#define kChangeCurrentUIStyleNotification @"kChangeCurrentUIStyleNotification"

@implementation NSNotificationCenter (Addition)

+ (void)postChangeCurrentUserNotification {
    [[NSNotificationCenter defaultCenter] postNotificationName:kChangeCurrentUserNotification object:nil userInfo:nil];
}

+ (void)registerChangeCurrentUserNotificationWithSelector:(SEL)aSelector target:(id)aTarget {
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserver:aTarget selector:aSelector
                   name:kChangeCurrentUserNotification 
                 object:nil];
}

+ (void)postCoreChangeCurrentUserNotification {
    [[NSNotificationCenter defaultCenter] postNotificationName:kCoreChangeCurrentUserNotification object:nil userInfo:nil];
}

+ (void)registerCoreChangeCurrentUserNotificationWithSelector:(SEL)aSelector target:(id)aTarget {
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserver:aTarget selector:aSelector
                   name:kCoreChangeCurrentUserNotification 
                 object:nil];
}

+ (void)postChangeCurrentUIStyleNotification:(UIStyle)style {
    [[NSNotificationCenter defaultCenter] postNotificationName:kChangeCurrentUIStyleNotification object:[NSNumber numberWithInt:style] userInfo:nil];
}

+ (void)registerChangeCurrentUIStyleNotificationWithSelector:(SEL)aSelector target:(id)aTarget {
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserver:aTarget selector:aSelector
                   name:kChangeCurrentUIStyleNotification 
                 object:nil];
}

@end
