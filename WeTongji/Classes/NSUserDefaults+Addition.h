//
//  NSUserDefaults+Addition.h
//  WeTongji
//
//  Created by 紫川 王 on 12-4-28.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    ChannelSortByActivityBeginTime = 0,
    ChannelSortByLikeCount = 1,
} ChannelSortMethod;

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

@end
