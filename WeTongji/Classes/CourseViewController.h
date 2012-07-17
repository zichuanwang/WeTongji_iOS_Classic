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

@property (nonatomic, weak) IBOutlet UILabel *courseNameLabel;
@property (nonatomic, weak) IBOutlet UILabel *teacherNameLabel;
@property (nonatomic, weak) IBOutlet UILabel *whenLabel;
@property (nonatomic, weak) IBOutlet UILabel *whereLabel;
@property (nonatomic, weak) IBOutlet UILabel *courseIDLabel;
@property (nonatomic, weak) IBOutlet UILabel *creditPointsLabel;
@property (nonatomic, weak) IBOutlet UILabel *creditHoursLabel;
@property (nonatomic, weak) IBOutlet UILabel *courseTypeLabel;
@property (nonatomic, weak) IBOutlet UIImageView *middleView;
@property (nonatomic, weak) IBOutlet UIScrollView *scrollView;
@property (nonatomic, weak) IBOutlet UIView *titleView;

- (id)initWithCourse:(Course *)course;

@end
