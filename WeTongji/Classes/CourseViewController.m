//
//  CourseViewController.m
//  WeTongji
//
//  Created by 紫川 王 on 12-5-16.
//  Copyright (c) 2012年 Tongji Apple Club. All rights reserved.
//

#import "CourseViewController.h"
#import "NSString+Addition.h"

#define COURSE_NAME_LABEL_MAX_HEIGHT 38

@interface CourseViewController ()

@property (nonatomic, strong) Course *course;

@end

@implementation CourseViewController

@synthesize courseNameLabel = _courseNameLabel;
@synthesize teacherNameLabel = _teacherNameLabel;
@synthesize whenLabel = _whenLabel;
@synthesize whereLabel = _whereLabel;
@synthesize creditPointsLabel = _creditPointsLabel;
@synthesize creditHoursLabel = _creditHoursLabel;
@synthesize courseTypeLabel = _courseTypeLabel;
@synthesize middleView = _middleView;
@synthesize scrollView = _scrollView;
@synthesize courseIDLabel = _courseIDLabel;
@synthesize titleView = _titleView;

@synthesize course = _course;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self configureIBOutlets];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    self.courseNameLabel = nil;
    self.teacherNameLabel = nil;
    self.whenLabel = nil;
    self.whereLabel = nil;
    self.creditPointsLabel = nil;
    self.creditHoursLabel = nil;
    self.courseTypeLabel = nil;
    self.middleView = nil;
    self.scrollView = nil;
    self.courseIDLabel = nil;
    self.titleView = nil;
}

- (id)initWithCourse:(Course *)course {
    self = [super init];
    if(self) {
        self.course = course;
    }
    return self;
}

#pragma mark - 
#pragma mark UI methods 

- (void)configreTitleView {
    self.courseNameLabel.text = self.course.what;
    [self.courseNameLabel sizeToFit];
    self.teacherNameLabel.text = self.course.teacher_name;
    [self.teacherNameLabel sizeToFit];
    
    CGFloat courseNameLabelHeight = self.courseNameLabel.frame.size.height;
    courseNameLabelHeight = courseNameLabelHeight > COURSE_NAME_LABEL_MAX_HEIGHT ?  COURSE_NAME_LABEL_MAX_HEIGHT : courseNameLabelHeight;
    CGRect courseNameFrame = self.courseNameLabel.frame;
    courseNameFrame.size.height = courseNameLabelHeight;
    self.courseNameLabel.frame = courseNameFrame;
    
    CGRect teacherNameFrame = self.teacherNameLabel.frame;
    
    CGRect titleViewFrame = self.titleView.frame;
    if(titleViewFrame.size.height < courseNameFrame.size.height + teacherNameFrame.size.height) {
        titleViewFrame.size.height = courseNameFrame.size.height + teacherNameFrame.size.height + 3;
        self.titleView.frame = titleViewFrame;
    }
    
    teacherNameFrame.origin.y = titleViewFrame.size.height - teacherNameFrame.size.height;
    self.teacherNameLabel.frame = teacherNameFrame;
}

- (void)configureIBOutlets {
    //self.middleView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"paper_main"]];
    self.middleView.image = [[UIImage imageNamed:@"paper_main"] resizableImageWithCapInsets:UIEdgeInsetsZero];
    self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width, self.scrollView.frame.size.height + 1);
    
    [self configreTitleView];

    self.whenLabel.text = [NSString timeConvertFromBeginDate:self.course.begin_time endDate:self.course.end_time];
    self.courseIDLabel.text = self.course.course_id;
    self.whereLabel.text = self.course.where;
    self.creditPointsLabel.text = [NSString stringWithFormat:@"%0.1f", self.course.credit_points.floatValue];
    self.creditHoursLabel.text = [self.course.credit_hours stringValue];
    self.courseTypeLabel.text = self.course.require_type;
}

@end
