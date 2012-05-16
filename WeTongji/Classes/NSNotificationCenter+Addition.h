//
//  NSNotificationCenter+Addition.h
//  SocialFusion
//
//  Created by 王紫川 on 12-1-24.
//  Copyright (c) 2012年 Tongji Apple Club. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSUserDefaults+Addition.h"

@interface NSNotificationCenter (Addition)

+ (void)postChangeCurrentUserNotification;
+ (void)postCoreChangeCurrentUserNotification;

+ (void)registerCoreChangeCurrentUserNotificationWithSelector:(SEL)aSelector target:(id)aTarget;
+ (void)registerChangeCurrentUserNotificationWithSelector:(SEL)aSelector target:(id)aTarget;

+ (void)postChangeCurrentUIStyleNotification:(UIStyle)style;
+ (void)registerChangeCurrentUIStyleNotificationWithSelector:(SEL)aSelector target:(id)aTarget;

+ (void)postChangeScheduleNotification;
+ (void)registerChangeScheduleNotificationWithSelector:(SEL)aSelector target:(id)aTarget; 

@end
