//
//  NSNotificationCenter+Addition.h
//  SocialFusion
//
//  Created by 王紫川 on 12-1-24.
//  Copyright (c) 2012年 Tongji Apple Club. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSNotificationCenter (Addition)

+ (void)postChangeCurrentUserNotification;

+ (void)registerChangeCurrentUserNotificationWithSelector:(SEL)aSelector target:(id)aTarget;

@end
