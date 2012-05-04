//
//  Channel+Addition.m
//  WeTongji
//
//  Created by 紫川 王 on 12-4-26.
//  Copyright (c) 2012年 Tongji Apple Club. All rights reserved.
//

#import "Channel+Addition.h"

@implementation Channel (Addition)

+ (Channel *)insertChannel:(NSDictionary *)dict inManagedObjectContext:(NSManagedObjectContext *)context
{
    NSString *channelID = [NSString stringWithFormat:@"@",[dict objectForKey:@"Id"]];
    
    if (!channelID || [channelID isEqualToString:@""]) {
        return nil;
    }
    
    Channel *result = [Channel channelWithID:channelID inManagedObjectContext:context];
    if (!result) {
        result = [NSEntityDescription insertNewObjectForEntityForName:@"Channel" inManagedObjectContext:context];
    }
    
    
    //result.updateDate = [NSDate date];
    
    result.channel_id = channelID;
    result.title = [NSString stringWithFormat:@"%@", [dict objectForKey:@"Title"]];
    result.content = [NSString stringWithFormat:@"%@", [dict objectForKey:@"Description"]];
    //result.name = [NSString stringWithFormat:@"%@", [dict objectForKey:@"screen_name"]];
    
    return result;
}

+ (Channel *)channelWithID:(NSString *)channelID inManagedObjectContext:(NSManagedObjectContext *)context
{
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    
    [request setEntity:[NSEntityDescription entityForName:@"Channel" inManagedObjectContext:context]];
    [request setPredicate:[NSPredicate predicateWithFormat:@"channel_id == %@", channelID]];
    
    Channel *result = [[context executeFetchRequest:request error:NULL] lastObject];
    
    return result;
}

+ (NSArray *)allChannelsInManagedObjectContext:(NSManagedObjectContext *)context {
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    
    [request setEntity:[NSEntityDescription entityForName:@"Channel" inManagedObjectContext:context]];
    NSArray *result = [context executeFetchRequest:request error:NULL];
    
    return result;
}

+ (void)deleteAllObjectsInManagedObjectContext:(NSManagedObjectContext *)context
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Channel" inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    
    NSArray *items = [context executeFetchRequest:fetchRequest error:NULL];
    
    for (NSManagedObject *managedObject in items) {
        [context deleteObject:managedObject];
    }
}

- (BOOL)isEqualToChannel:(Channel *)channel
{
    return [self.channel_id isEqualToString:channel.channel_id];
}

@end
