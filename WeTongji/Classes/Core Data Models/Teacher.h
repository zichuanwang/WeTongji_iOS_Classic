//
//  Teacher.h
//  WeTongji
//
//  Created by 紫川 王 on 12-5-15.
//  Copyright (c) 2012年 Tongji Apple Club. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "User.h"

@class Course;

@interface Teacher : User

@property (nonatomic, retain) NSSet *teach;
@end

@interface Teacher (CoreDataGeneratedAccessors)

- (void)addTeachObject:(Course *)value;
- (void)removeTeachObject:(Course *)value;
- (void)addTeach:(NSSet *)values;
- (void)removeTeach:(NSSet *)values;

@end
