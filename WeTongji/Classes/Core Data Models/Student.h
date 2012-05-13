//
//  Student.h
//  WeTongji
//
//  Created by 紫川 王 on 12-5-14.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "User.h"


@interface Student : User

@property (nonatomic, retain) NSString * department;
@property (nonatomic, retain) NSNumber * enroll_year;
@property (nonatomic, retain) NSString * major;
@property (nonatomic, retain) NSNumber * plan;
@property (nonatomic, retain) NSString * student_number;

@end
