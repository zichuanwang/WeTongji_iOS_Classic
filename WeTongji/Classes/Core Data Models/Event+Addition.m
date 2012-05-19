//
//  Event+Addition.m
//  WeTongji
//
//  Created by 紫川 王 on 12-5-16.
//  Copyright (c) 2012年 Tongji Apple Club. All rights reserved.
//

#import "Event+Addition.h"
#import "NSString+Addition.h"

@implementation Event (Addition)

+ (void)clearEmptyEventInManagedObjectContext:(NSManagedObjectContext *)context {
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:[NSEntityDescription entityForName:@"Event" inManagedObjectContext:context]];
    NSPredicate *whatPredicate = [NSPredicate predicateWithFormat:@"what == nil"];
    NSPredicate *wherePredicate = [NSPredicate predicateWithFormat:@"where == nil"];
    [request setPredicate:[NSCompoundPredicate andPredicateWithSubpredicates:[NSArray arrayWithObjects:whatPredicate, wherePredicate, nil]]];
    NSArray *items = [context executeFetchRequest:request error:NULL];
    for(NSManagedObject *item in items) {
        [context deleteObject:item];
    }

}

@end
