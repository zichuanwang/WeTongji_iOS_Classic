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
    result.what = [NSString stringWithFormat:@"%@", [dict objectForKey:@"Title"]];
    result.content = [NSString stringWithFormat:@"%@", [dict objectForKey:@"Description"]];
    result.where = [NSString stringWithFormat:@"%@", [dict objectForKey:@"Location"]];
    result.avatar_link = [NSString stringWithFormat:@"%@", [dict objectForKey:@"Avatar"]];
    result.image_link = [NSString stringWithFormat:@"%@", [dict objectForKey:@"Image"]];
    result.organizer = [NSString stringWithFormat:@"%@", [dict objectForKey:@"Organizer"]];
    result.sub_organizer = [NSString stringWithFormat:@"%@", [dict objectForKey:@"SubOrganizer"]];
    result.status = [NSString stringWithFormat:@"%@", [dict objectForKey:@"Status"]];
    result.begin_time = [[NSString stringWithFormat:@"%@", [dict objectForKey:@"Begin"]] convertToDate];
    result.begin_day = [NSString yearMonthDayWeekConvertFromDate:result.begin_time];
    result.end_time = [[NSString stringWithFormat:@"%@", [dict objectForKey:@"End"]] convertToDate];
    result.channel_id = [NSNumber numberWithInt:[[dict objectForKey:@"Channel_Id"] intValue] - 1];
    result.like_count = [NSNumber numberWithInt:[[dict objectForKey:@"Like"] intValue]];
    result.favorite_count = [NSNumber numberWithInt:[[dict objectForKey:@"Favorite"] intValue]];
    result.schedule_count = [NSNumber numberWithInt:[[dict objectForKey:@"Schedule"] intValue]];
    result.can_favorite = [NSNumber numberWithInt:[[dict objectForKey:@"CanFavorite"] intValue]];
    result.can_like = [NSNumber numberWithInt:[[dict objectForKey:@"CanLike"] intValue]];
    result.can_schedule = [NSNumber numberWithInt:[[dict objectForKey:@"CanSchedule"] intValue]];
    
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

+ (NSArray *)allActivitiesInManagedObjectContext:(NSManagedObjectContext *)context {
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:[NSEntityDescription entityForName:@"Activity" inManagedObjectContext:context]];
    NSArray *result = [context executeFetchRequest:request error:NULL];
    return result;
}

@end
