//
//  Student.h
//  WeTongji
//
//  Created by 紫川 王 on 12-5-3.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "User.h"


@interface Student : User

@property (nonatomic, retain) NSString * major;
@property (nonatomic, retain) NSString * student_number;

@end
