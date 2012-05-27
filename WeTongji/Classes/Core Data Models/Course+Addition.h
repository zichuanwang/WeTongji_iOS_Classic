//
//  Course+Addition.h
//  WeTongji
//
//  Created by 紫川 王 on 12-5-15.
//  Copyright (c) 2012年 Tongji Apple Club. All rights reserved.
//

#import "Course.h"
#import "User.h"

@interface Course (Addition)

+ (NSSet *)insertCourse:(NSDictionary *)dict withSemesterBeginTime:(NSDate *)semesterBeginTime semesterWeekCount:(NSInteger)semesterWeekCount owner:(User *)owner inManagedObjectContext:(NSManagedObjectContext *)context;

+ (Course *)insertExam:(NSDictionary *)dict inManagedObjectContext:(NSManagedObjectContext *)context;

@end
