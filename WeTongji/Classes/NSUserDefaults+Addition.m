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

#define kUserDefaultsInitialized @"kUserDefaultsInitialized"

@implementation NSUserDefaults (Addition)

+ (void)initialize {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    BOOL hasInit = [userDefaults boolForKey:kUserDefaultsInitialized];
    if(hasInit)
        return;
    [userDefaults setBool:YES forKey:kUserDefaultsInitialized];
    for(int i = 0; i < 4; i++) {
        NSString *channelKey = [NSString stringWithFormat:@"follow_channel_%d", i];
        [userDefaults setBool:YES forKey:channelKey];
    }
    for(int i = 0; i < 2; i++) {
        NSString *channelSortKey = [NSString stringWithFormat:@"sort_channel_%d", i];
        [userDefaults setBool:NO forKey:channelSortKey];
    }
    [userDefaults setBool:YES forKey:@"sort_channel_0"];
    
    [userDefaults synchronize];
}

+ (void)setChannelFollowStatus:(NSArray *)channelsStatus {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    for(int i = 0; i < channelsStatus.count; i++) {
        NSNumber *channelStatus = [channelsStatus objectAtIndex:i];
        NSString *channelKey = [NSString stringWithFormat:@"follow_channel_%d", i];
        [userDefaults setBool:channelStatus.boolValue forKey:channelKey];
    }
    [userDefaults synchronize];
}

+ (NSArray *)getChannelFollowStatusArray {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSMutableArray *result = [NSMutableArray arrayWithCapacity:4];
    for(int i = 0; i < 4; i++) {
        NSString *channelKey = [NSString stringWithFormat:@"follow_channel_%d", i];
        [result addObject:[NSNumber numberWithBool:[userDefaults boolForKey:channelKey]]];
    }
    return result;
}

+ (NSArray *)getFollowedChannelArray {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSMutableArray *result = [NSMutableArray arrayWithCapacity:4];
    for(int i = 0; i < 4; i++) {
        NSString *channelKey = [NSString stringWithFormat:@"follow_channel_%d", i];
        if([userDefaults boolForKey:channelKey])
            [result addObject:[NSNumber numberWithInt:i]];
    }
    return result;
}

+ (NSString *)getChannelFollowStatusString {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSMutableString *result = nil;
    for(int i = 0; i < 4; i++) {
        NSString *channelKey = [NSString stringWithFormat:@"follow_channel_%d", i];
        if([userDefaults boolForKey:channelKey]) {
            if(result)
                [result appendFormat:@",%d", i + 1];
            else 
                result = [NSMutableString stringWithFormat:@"%d", i + 1];
        }
    }
    NSLog(@"channel follow str:%@", result);
    return result;
}

+ (void)setChannelSortMethodArray:(NSArray *)sortMethods {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    for(int i = 0; i < sortMethods.count; i++) {
        NSNumber *channelStatus = [sortMethods objectAtIndex:i];
        NSString *channelKey = [NSString stringWithFormat:@"sort_channel_%d", i];
        [userDefaults setBool:channelStatus.boolValue forKey:channelKey];
    }
    [userDefaults synchronize];
}

+ (NSArray *)getChannelSortMethodArray {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSMutableArray *result = [NSMutableArray arrayWithCapacity:2];
    for(int i = 0; i < 2; i++) {
        NSString *channelSortKey = [NSString stringWithFormat:@"sort_channel_%d", i];
        [result addObject:[NSNumber numberWithBool:[userDefaults boolForKey:channelSortKey]]];
    }
    return result;
}

+ (ChannelSortMethod)getChannelSortMethod {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    for(int i = 0; i < 2; i++) {
        NSString *channelSortKey = [NSString stringWithFormat:@"sort_channel_%d", i];
        if([userDefaults boolForKey:channelSortKey])
            return i;
    }
    return 0;
}

+ (NSArray *)getChannelNameArray {
    return [NSArray arrayWithObjects:@"学术讲座", @"赛事信息", @"文娱活动", @"企业招聘", nil];
}

@end
