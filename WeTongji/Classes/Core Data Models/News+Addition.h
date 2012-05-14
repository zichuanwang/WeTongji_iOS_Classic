//
//  News+Addition.h
//  WeTongji
//
//  Created by 紫川 王 on 12-5-3.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "News.h"

@interface News (Addition)

+ (News *)insertNews:(NSDictionary *)dict inManagedObjectContext:(NSManagedObjectContext *)context;
+ (News *)newsWithID:(NSString *)newsID inManagedObjectContext:(NSManagedObjectContext *)context;
+ (NSArray *)allNewsInManagedObjectContext:(NSManagedObjectContext *)context;
+ (void)deleteAllObjectsInManagedObjectContext:(NSManagedObjectContext *)context;

@end
