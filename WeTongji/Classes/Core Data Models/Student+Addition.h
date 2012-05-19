//
//  Student+Addition.h
//  WeTongji
//
//  Created by 紫川 王 on 12-5-6.
//  Copyright (c) 2012年 Tongji Apple Club. All rights reserved.
//

#import "Student.h"

@interface Student (Addition)

+ (Student *)insertStudent:(NSDictionary *)dict inManagedObjectContext:(NSManagedObjectContext *)context;
+ (Student *)studentWithID:(NSString *)userID inManagedObjectContext:(NSManagedObjectContext *)context;

@end
