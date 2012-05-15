//
//  Course+Addition.h
//  WeTongji
//
//  Created by 紫川 王 on 12-5-15.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "Course.h"

@interface Course (Addition)

+ (NSSet *)insertCourse:(NSDictionary *)dict withSemesterBeginTime:(NSDate *)semesterBeginTime inManagedObjectContext:(NSManagedObjectContext *)context;

@end
