//
//  News+Addition.m
//  WeTongji
//
//  Created by 紫川 王 on 12-5-3.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
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
    result.category = [NSString stringWithFormat:@"%@", [dict objectForKey:@"Category"]];
    result.create_at = [[NSString stringWithFormat:@"%@", [dict objectForKey:@"CreatedAt"]] convertToDate];
    NSString *readCountStr = [NSString stringWithFormat:@"%@", [dict objectForKey:@"Read"]];
    if(readCountStr)
        result.read_count = [NSNumber numberWithInt:[readCountStr intValue]]; 
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

@end
