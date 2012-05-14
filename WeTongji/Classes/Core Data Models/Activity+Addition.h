//
//  Activity+Addition.h
//  WeTongji
//
//  Created by 紫川 王 on 12-4-26.
//  Copyright (c) 2012年 Tongji Apple Club. All rights reserved.
//

#import "Activity.h"

@interface Activity (Addition)

+ (Activity *)insertActivity:(NSDictionary *)dict inManagedObjectContext:(NSManagedObjectContext *)context;
+ (Activity *)activityWithID:(NSString *)channelID inManagedObjectContext:(NSManagedObjectContext *)context;
+ (NSArray *)allActivitiesInManagedObjectContext:(NSManagedObjectContext *)context;

@end
