//
//  Activity+Addition.m
//  WeTongji
//
//  Created by 紫川 王 on 12-4-26.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "Activity+Addition.h"

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
    result.activity_description = [NSString stringWithFormat:@"%@", [dict objectForKey:@"Description"]];
    result.location = [NSString stringWithFormat:@"%@", [dict objectForKey:@"Location"]];
    result.organizer = [NSString stringWithFormat:@"%@", [dict objectForKey:@"Organizer"]];
    result.status = [NSString stringWithFormat:@"%@", [dict objectForKey:@"Status"]];
    
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
