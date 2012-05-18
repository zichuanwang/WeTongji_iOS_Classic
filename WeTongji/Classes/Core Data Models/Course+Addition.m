//
//  Course+Addition.m
//  WeTongji
//
//  Created by 紫川 王 on 12-5-15.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "Course+Addition.h"
#import "NSString+Addition.h"

#define DAY_TIME_INTERVAL (60 * 60 * 24)
#define HOUR_TIME_INTERVAL (60 * 60)
#define MINUTE_TIME_INTERVAL 60

@implementation Course (Addition)

+ (NSTimeInterval)getDayTimeIntervalFromSection:(NSInteger)section {
    NSTimeInterval result = 0;
    switch (section) {
        case 1:
            result = 8 * HOUR_TIME_INTERVAL;
            break;
        case 2:
            result = 9 * HOUR_TIME_INTERVAL + 40 * MINUTE_TIME_INTERVAL;
            break;
        case 3:
            result = 10 * HOUR_TIME_INTERVAL;
            break;
        case 4:
            result = 11 * HOUR_TIME_INTERVAL + 40 * MINUTE_TIME_INTERVAL;
            break;
        case 5:
            result = 13 * HOUR_TIME_INTERVAL + 30 * MINUTE_TIME_INTERVAL;
            break;
        case 6:
            result = 15 * HOUR_TIME_INTERVAL + 5 * MINUTE_TIME_INTERVAL;
            break;
        case 7:
            result = 15 * HOUR_TIME_INTERVAL + 25 * MINUTE_TIME_INTERVAL;
            break;
        case 8:
            result = 17 * HOUR_TIME_INTERVAL;
            break;
        case 9:
            result = 18 * HOUR_TIME_INTERVAL + 30 * MINUTE_TIME_INTERVAL;
            break;
        case 10:
            result = 20 * HOUR_TIME_INTERVAL + 10 * MINUTE_TIME_INTERVAL;
            break;
        case 11:
            result = 21 * HOUR_TIME_INTERVAL + 5 * MINUTE_TIME_INTERVAL;
            break;
        default:
            break;
    }
    return result;
}

+ (NSSet *)insertCourse:(NSDictionary *)dict withSemesterBeginTime:(NSDate *)semesterBeginTime semesterWeekCount:(NSInteger)semesterWeekCount inManagedObjectContext:(NSManagedObjectContext *)context {
    NSString *courseID = [NSString stringWithFormat:@"%@", [dict objectForKey:@"NO"]];
    NSNumber *beginSection = [NSNumber numberWithInt:[[NSString stringWithFormat:@"%@", [dict objectForKey:@"SectionStart"]] intValue]];
    NSNumber *endSection = [NSNumber numberWithInt:[[NSString stringWithFormat:@"%@", [dict objectForKey:@"SectionEnd"]] intValue]];
    NSString *weekType = [NSString stringWithFormat:@"%@", [dict objectForKey:@"WeekType"]];
    NSNumber *weekDay = [[NSString stringWithFormat:@"%@", [dict objectForKey:@"WeekDay"]] weekDayStringCovertToNumber];
    
    [Course clearCoursesWithID:courseID beginSection:beginSection endSection:endSection weekDay:weekDay weekType:weekType inManagedObjectContext:context];
    
    NSMutableSet *result = [NSMutableSet set];
    for(int i = 0; i < semesterWeekCount; i++) {
        if(i % 2 == 1 && [weekType isEqualToString:@"单"])
            continue;
        if(i % 2 == 0 && [weekType isEqualToString:@"双"])
            continue;
        Course *course = [NSEntityDescription insertNewObjectForEntityForName:@"Course" inManagedObjectContext:context];
        course.begin_section = beginSection;
        course.end_section = endSection;
        
        course.begin_time = [semesterBeginTime dateByAddingTimeInterval:DAY_TIME_INTERVAL * (7 * i + weekDay.integerValue) + [Course getDayTimeIntervalFromSection:course.begin_section.integerValue]];      
        course.begin_day = [NSString yearMonthDayWeekConvertFromDate:course.begin_time];
        course.end_time = [semesterBeginTime dateByAddingTimeInterval:DAY_TIME_INTERVAL * (7 * i + weekDay.integerValue) + [Course getDayTimeIntervalFromSection:course.end_section.integerValue]];  
        
        course.course_id = courseID;
        course.week_day = weekDay;
        
        course.credit_hours = [NSNumber numberWithInt:[[NSString stringWithFormat:@"%@", [dict objectForKey:@"Hours"]] intValue]];
        course.credit_points = [NSNumber numberWithFloat:[[NSString stringWithFormat:@"%@", [dict objectForKey:@"Point"]] floatValue]];
        course.require_type = [NSString stringWithFormat:@"%@", [dict objectForKey:@"Required"]];
        course.teacher_name = [NSString stringWithFormat:@"%@", [dict objectForKey:@"Teacher"]];
        course.week_type = weekType;
        
        course.what = [NSString stringWithFormat:@"%@", [dict objectForKey:@"Name"]];
        course.where = [NSString stringWithFormat:@"%@", [dict objectForKey:@"Location"]];
        
        [result addObject:course];
    }
    return result;
}

+ (void)clearCoursesWithID:(NSString *)courseID beginSection:(NSNumber *)beginSection endSection:(NSNumber *)endSection weekDay:(NSNumber *)weekDay weekType:(NSString *)weekType inManagedObjectContext:(NSManagedObjectContext *)context {
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:[NSEntityDescription entityForName:@"Course" inManagedObjectContext:context]];
    NSPredicate *courseIDPredicate = [NSPredicate predicateWithFormat:@"course_id == %@", courseID];
    NSPredicate *beginPredicate = [NSPredicate predicateWithFormat:@"begin_section == %@", beginSection];
    NSPredicate *endPredicate = [NSPredicate predicateWithFormat:@"end_section == %@", endSection];
    NSPredicate *weekDayPredicate = [NSPredicate predicateWithFormat:@"week_day == %@", weekDay];
    NSPredicate *weekTypePredicate = [NSPredicate predicateWithFormat:@"week_type == %@", weekType];
    [request setPredicate:[NSCompoundPredicate andPredicateWithSubpredicates:[NSArray arrayWithObjects:courseIDPredicate, beginPredicate, endPredicate, weekDayPredicate, weekTypePredicate, nil]]];
    
    NSArray *items = [context executeFetchRequest:request error:NULL];
    for(Course *course in items) {
        [context deleteObject:course];
    }

}

@end
