//
//  Course.h
//  WeTongji
//
//  Created by 紫川 王 on 12-5-15.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "Event.h"

@class Teacher;

@interface Course : Event

@property (nonatomic, retain) NSNumber * credit_points;
@property (nonatomic, retain) NSNumber * credit_hours;
@property (nonatomic, retain) NSString * course_id;
@property (nonatomic, retain) NSString * teacher_name;
@property (nonatomic, retain) NSString * require_type;
@property (nonatomic, retain) NSNumber * week_day;
@property (nonatomic, retain) NSString * week_type;
@property (nonatomic, retain) NSNumber * begin_section;
@property (nonatomic, retain) NSNumber * end_section;
@property (nonatomic, retain) Teacher *teachedBy;

@end
