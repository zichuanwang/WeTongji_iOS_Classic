//
//  Activity+Addition.m
//  WeTongji
//
//  Created by 紫川 王 on 12-4-26.
//  Copyright (c) 2012年 Tongji Apple Club. All rights reserved.
//

#import "Activity+Addition.h"
#import "NSString+Addition.h"

@implementation Activity (Addition)

+ (Activity *)insertActivity:(NSDictionary *)dict inManagedObjectContext:(NSManagedObjectContext *)context
{
    NSString *activityID = [NSString stringWithFormat:@"%@", [dict objectForKey:@"Id"]];

    if (!activityID || [activityID isEqualToString:@""]) {
        return nil;
    }
    
    Activity *result = [Activity activityWithID:activityID inManagedObjectContext:context];
    if (!result) {
        result = [NSEntityDescription insertNewObjectForEntityForName:@"Activity" inManagedObjectContext:context];
    }
    
    result.activity_id = activityID;
    result.title = [NSString stringWithFormat:@"%@", [dict objectForKey:@"Title"]];
    result.content = [NSString stringWithFormat:@"%@", [dict objectForKey:@"Description"]];
    result.location = [NSString stringWithFormat:@"%@", [dict objectForKey:@"Location"]];
    result.organizer = [NSString stringWithFormat:@"%@", [dict objectForKey:@"Organizer"]];
    result.sub_organizer = [NSString stringWithFormat:@"%@", [dict objectForKey:@"SubOrganizer"]];
    result.status = [NSString stringWithFormat:@"%@", [dict objectForKey:@"Status"]];
    result.begin_time = [[NSString stringWithFormat:@"%@", [dict objectForKey:@"Begin"]] convertToDate];
    result.begin_day = [NSString yearMonthDayConvertFromDate:result.begin_time];
    NSLog(@"begin_day:%@", result.begin_day);
    result.end_time = [[NSString stringWithFormat:@"%@", [dict objectForKey:@"End"]] convertToDate];
    result.channel_id = [NSNumber numberWithInt:[[dict objectForKey:@"Channel_Id"] intValue] - 1];
    result.like_count = [NSNumber numberWithInt:[[dict objectForKey:@"Like"] intValue]];
    result.hot_count = [NSNumber numberWithInt:[[dict objectForKey:@"Hot"] intValue]];
    result.follow_count = [NSNumber numberWithInt:[[dict objectForKey:@"Follow"] intValue]];
    return result;
}

+ (Activity *)activityWithID:(NSString *)channelID inManagedObjectContext:(NSManagedObjectContext *)context
{
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    
    [request setEntity:[NSEntityDescription entityForName:@"Activity" inManagedObjectContext:context]];
    [request setPredicate:[NSPredicate predicateWithFormat:@"activity_id == %@", channelID]];
    
    Activity *result = [[context executeFetchRequest:request error:NULL] lastObject];
    
    return result;
}

@end
