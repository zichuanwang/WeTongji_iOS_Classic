//
//  NSUserDefaults+Addition.m
//  WeTongji
//
//  Created by 紫川 王 on 12-4-28.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "NSUserDefaults+Addition.h"

typedef enum {
    ChannelLecture = 0,
    ChannelEntertainment = 1,
    ChannelMatch = 2,
    ChannelEnterprise = 3,
} ChannelName;

@implementation NSUserDefaults (Addition)

- (void)setChannelFollowStatus:(NSArray *)channels {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    for(int i = 0; i < channels.count; i++) {
        NSNumber *channelStatus = [channels objectAtIndex:i];
        NSString *channelKey = [NSString stringWithFormat:@"follow_channel_%d", i];
        [userDefaults setObject:channelStatus forKey:channelKey];
    }
    [userDefaults synchronize];
}

- (NSArray *)getChannelFollowStatus {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSMutableArray *result = [NSMutableArray arrayWithCapacity:4];
    for(int i = 0; i < 4; i++) {
        NSString *channel_key = [NSString stringWithFormat:@"follow_channel_%d", i];
        NSNumber *status = [userDefaults objectForKey:channelKey];
        [result addObject:status];
    }
    return result;
}

@end
