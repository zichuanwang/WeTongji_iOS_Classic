//
//  CourseViewController.h
//  WeTongji
//
//  Created by 紫川 王 on 12-5-16.
//  Copyright (c) 2012年 Tongji Apple Club. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Course+Addition.h"

@interface CourseViewController : UIViewController

@property (nonatomic, strong) IBOutlet UILabel *courseNameLabel;
@property (nonatomic, strong) IBOutlet UILabel *teacherNameLabel;
@property (nonatomic, strong) IBOutlet UILabel *whenLabel;
@property (nonatomic, strong) IBOutlet UILabel *whereLabel;
@property (nonatomic, strong) IBOutlet UILabel *creditPointsLabel;
@property (nonatomic, strong) IBOutlet UILabel *creditHoursLabel;
@property (nonatomic, strong) IBOutlet UILabel *courseTypeLabel;
@property (nonatomic, strong) IBOutlet UIImageView *middleView;
@property (nonatomic, strong) IBOutlet UIScrollView *scrollView;

- (id)initWithCourse:(Course *)course;

@end
