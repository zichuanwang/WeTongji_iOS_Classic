//
//  News+Addition.m
//  WeTongji
//
//  Created by 紫川 王 on 12-5-3.
//  Copyright (c) 2012年 Tongji Apple Club. All rights reserved.
//

#import "News+Addition.h"
#import "NSString+Addition.h"

@implementation News (Addition)

+ (News *)insertNews:(NSDictionary *)dict inManagedObjectContext:(NSManagedObjectContext *)context
{
    NSString *newsID = [NSString stringWithFormat:@"%@", [dict objectForKey:@"Id"]];
    
    if (!newsID || [newsID isEqualToString:@""]) {
        return nil;
    }
    
    News *result = [News newsWithID:newsID inManagedObjectContext:context];
    if (!result) {
        result = [NSEntityDescription insertNewObjectForEntityForName:@"News" inManagedObjectContext:context];
    }
    
    result.news_id = newsID;
    result.title = [NSString stringWithFormat:@"%@", [dict objectForKey:@"Title"]];
    result.content = [NSString stringWithFormat:@"%@", [dict objectForKey:@"Context"]];
    result.image_link = [NSString stringWithFormat:@"%@", [dict objectForKey:@"Image"]];
    result.category = [NSString stringWithFormat:@"%@", [dict objectForKey:@"Category"]];
    result.create_at = [[NSString stringWithFormat:@"%@", [dict objectForKey:@"CreatedAt"]] convertToDate];
    NSString *readCountStr = [NSString stringWithFormat:@"%@", [dict objectForKey:@"Read"]];
    if(readCountStr)
        result.read_count = [NSNumber numberWithInt:[readCountStr intValue]]; 
    result.update_date = [NSDate date];
    return result;
}

+ (News *)newsWithID:(NSString *)newsID inManagedObjectContext:(NSManagedObjectContext *)context
{
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    
    [request setEntity:[NSEntityDescription entityForName:@"News" inManagedObjectContext:context]];
    [request setPredicate:[NSPredicate predicateWithFormat:@"news_id == %@", newsID]];
    
    News *result = [[context executeFetchRequest:request error:NULL] lastObject];
    
    return result;
}

+ (NSArray *)allNewsInManagedObjectContext:(NSManagedObjectContext *)context {
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:[NSEntityDescription entityForName:@"News" inManagedObjectContext:context]];
    NSArray *result = [context executeFetchRequest:request error:NULL];
    return result;
}

+ (void)deleteAllObjectsInManagedObjectContext:(NSManagedObjectContext *)context
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"News" inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    
    NSArray *items = [context executeFetchRequest:fetchRequest error:NULL];
    
    for (NSManagedObject *managedObject in items) {
        [context deleteObject:managedObject];
    }
}

@end
