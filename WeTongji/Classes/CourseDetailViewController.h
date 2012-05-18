//
//  CourseDetailViewController.h
//  WeTongji
//
//  Created by 紫川 王 on 12-5-16.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EventDetailViewController.h"
#import "Course+Addition.h"

@interface CourseDetailViewController : EventDetailViewController

- (id)initWithCourse:(Course *)course;

@end
