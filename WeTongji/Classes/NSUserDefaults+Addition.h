//
//  NSUserDefaults+Addition.h
//  WeTongji
//
//  Created by 紫川 王 on 12-4-28.
//  Copyright (c) 2012年 Tongji Apple Club. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    ChannelSortByActivityBeginTime = 0,
    ChannelSortByLikeCount = 1,
} ChannelSortMethod;

typedef enum {
    UIStyleBlackChocolate = 0,
    UIStyleWhiteChocolate = 1,
} UIStyle;

@interface NSUserDefaults (Addition)

+ (void)initialize;

+ (void)setChannelFollowStatus:(NSArray *)channels;
+ (NSArray *)getChannelFollowStatusArray;
+ (NSString *)getChannelFollowStatusString;
+ (NSArray *)getFollowedChannelArray;
+ (void)setChannelSortMethodArray:(NSArray *)sortMethods;
+ (NSArray *)getChannelSortMethodArray;
+ (ChannelSortMethod)getChannelSortMethod;
+ (NSArray *)getChannelNameArray;
+ (void)setShowExpireActivitiesParam:(BOOL)ignore;
+ (BOOL)getShowExpireActivitiesParam;

+ (void)setCurrentUserID:(NSString *)userID session:(NSString *)session;
+ (NSString *)getCurrentUserID;
+ (NSString *)getCurrentUserSession;

+ (UIStyle)getCurrentUIStyle;
+ (void)setCurrentUIStyle:(UIStyle)style;

+ (void)setCurrentSemesterBeginTime:(NSDate *)begin endTime:(NSDate *)end;
+ (NSDate *)getCurrentSemesterBeginDate;
+ (NSDate *)getCurrentSemesterEndDate;

@end
