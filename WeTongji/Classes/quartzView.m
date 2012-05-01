//
//  quartzView.m
//  WeTongji
//
//  Created by M.K.Rain on 12-4-28.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "quartzView.h"

#define kCELL_X 60
#define kCELLWIDTH 240

@interface quartzView ()

@end

@implementation quartzView

@synthesize currentDate = _currentDate;
@synthesize firstRect = _firstRect;

@synthesize datesIndexArray = _datesIndexArray;
@synthesize dateSourceDictionary = _dateSourceDictionary;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.datesIndexArray = [NSMutableArray arrayWithCapacity:10];
        self.dateSourceDictionary = [NSMutableDictionary dictionaryWithCapacity:10];
        [self setupData];
        self.backgroundColor = [UIColor clearColor];
        
        self.firstRect = CGRectMake(0, 0, kCELLWIDTH, 1);
    }
    return self;
}

- (void)setupData{
    //set up the course data
    NSDictionary *course1 = [[NSDictionary alloc] initWithObjectsAndKeys:@"操作系统",@"Name",
                             @"9",@"startHour",@"00",@"startMin",
                             @"10",@"endHour",@"00",@"endMin",
                             @"A301",@"Location", nil];
    NSDictionary *course2 = [[NSDictionary alloc] initWithObjectsAndKeys:@"组成原理",@"Name",
                             @"10",@"startHour",@"00",@"startMin",
                             @"12",@"endHour",@"00",@"endMin",
                             @"B410",@"Location", nil];
    NSDictionary *course3 = [[NSDictionary alloc] initWithObjectsAndKeys:@"未来剧场",@"Name",
                             @"17",@"startHour",@"00",@"startMin",
                             @"19",@"endHour",@"00",@"endMin",
                             @"A310",@"Location", nil];
    NSDictionary *course4 = [[NSDictionary alloc] initWithObjectsAndKeys:@"flash",@"Name",
                             @"16",@"startHour",@"00",@"startMin",
                             @"17",@"endHour",@"00",@"endMin",
                             @"F210",@"Location", nil];
    NSDictionary *course5 = [[NSDictionary alloc] initWithObjectsAndKeys:@"平面设计",@"Name",
                             @"20",@"startHour",@"00",@"startMin",
                             @"22",@"endHour",@"00",@"endMin",
                             @"F301",@"Location", nil];
    NSDictionary *course6 = [[NSDictionary alloc] initWithObjectsAndKeys:@"数据库",@"Name",
                             @"13",@"startHour",@"00",@"startMin",
                             @"14",@"endHour",@"00",@"endMin",
                             @"AG301",@"Location", nil];
    
    [self.datesIndexArray addObject:[NSString stringWithString:@"3月1日"]];
    [self.datesIndexArray addObject:[NSString stringWithString:@"3月2日"]];
    [self.datesIndexArray addObject:[NSString stringWithString:@"3月3日"]];
    [self.datesIndexArray addObject:[NSString stringWithString:@"3月4日"]];
    [self.datesIndexArray addObject:[NSString stringWithString:@"3月5日"]];
    [self.datesIndexArray addObject:[NSString stringWithString:@"3月6日"]];
    NSArray *day1 = [NSArray arrayWithObjects:course1, nil];
    NSArray *day2 = [NSArray arrayWithObjects:course2, course3, nil];
    NSArray *day3 = [NSArray arrayWithObjects:course4, course5, course6, nil];
    NSArray *day4 = [NSArray arrayWithObjects:course1, course3, nil];
    NSArray *day5 = [NSArray arrayWithObjects:course2, course4, nil];
    NSArray *day6 = [NSArray arrayWithObjects:course4, course2, course6, nil];
    
    [self.dateSourceDictionary setValue:day1 forKey:[self.datesIndexArray objectAtIndex:0]];
    [self.dateSourceDictionary setValue:day2 forKey:[self.datesIndexArray objectAtIndex:1]];
    [self.dateSourceDictionary setValue:day3 forKey:[self.datesIndexArray objectAtIndex:2]];
    [self.dateSourceDictionary setValue:day4 forKey:[self.datesIndexArray objectAtIndex:3]];
    [self.dateSourceDictionary setValue:day5 forKey:[self.datesIndexArray objectAtIndex:4]];
    [self.dateSourceDictionary setValue:day6 forKey:[self.datesIndexArray objectAtIndex:5]];
    
}

- (void)updateCourses{
    for(UIView *subview in [self subviews]) {
    if([subview isKindOfClass:[UILabel class]]) 
        [subview removeFromSuperview];
    } 
    [self clearsContextBeforeDrawing];
    [self setNeedsDisplay];
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect{
    CGContextRef context=UIGraphicsGetCurrentContext();
    
    NSArray *currentDay = [self.dateSourceDictionary objectForKey:self.currentDate];
    for (int i = 0; i<currentDay.count; i++) {
        
        NSDictionary *tmpCourse = [currentDay objectAtIndex:i];
        NSString *startHour = [tmpCourse objectForKey:@"startHour"];
        NSString *startMin = [tmpCourse objectForKey:@"startMin"];
        NSString *endHour = [tmpCourse objectForKey:@"endHour"];
        NSString *endMin = [tmpCourse objectForKey:@"endMin"];
        
        NSInteger length = ([endHour intValue]*60+[endMin intValue]) - ([startHour intValue]*60+[startMin intValue]);
        length = (CGFloat)length*43/60;
        CGFloat startPosition =  17.0f + ([startHour intValue]*60 + [startMin intValue])*43/60;
        
        addRoundedRectToPath(context, CGRectMake(kCELL_X, startPosition, kCELLWIDTH, length), 4.0f, 4.0f);
        
        UILabel *currentCourseInfo = [[UILabel alloc] initWithFrame:CGRectMake(kCELL_X+20, startPosition, kCELLWIDTH-40, length)];
        [self addSubview:currentCourseInfo];
        NSString *name = [tmpCourse objectForKey:@"Name"];
        NSString *location = [tmpCourse objectForKey:@"Location"];
        currentCourseInfo.text = [NSString stringWithFormat:@"%@\n%@",name,location];
        currentCourseInfo.font = [UIFont fontWithName:@"Arial" size:12];
        currentCourseInfo.textColor = [UIColor blackColor];
        currentCourseInfo.textAlignment = UITextAlignmentLeft;
        currentCourseInfo.backgroundColor = [UIColor clearColor];
        currentCourseInfo.numberOfLines = 2;
        currentCourseInfo.userInteractionEnabled = YES;
        
        if (self.firstRect.origin.y == 0){
            self.firstRect = CGRectMake(kCELL_X, startPosition, kCELLWIDTH, length);
        } else if(startPosition < self.firstRect.origin.y){
                self.firstRect = CGRectMake(kCELL_X, startPosition, kCELLWIDTH, length);
        }
    }
    
    CGContextSetRGBStrokeColor(context, 0.0, 0.0, 0.0, 1.0);
    CGContextSetLineWidth(context, 0.5f);
    CGContextSetRGBFillColor(context, 85.0/256, 198.0/256, 54.0/256, 0.8f);
    CGContextDrawPath(context, kCGPathEOFillStroke);
    
}

static void addRoundedRectToPath(CGContextRef context, CGRect rect,
                                  float ovalWidth,float ovalHeight)
{
    float fw, fh;
    if (ovalWidth == 0 || ovalHeight == 0) { // 1
        CGContextAddRect(context, rect);
        return;
    }
    CGContextSaveGState(context); // 2
    CGContextTranslateCTM (context, CGRectGetMinX(rect), // 3
                           CGRectGetMinY(rect));
    CGContextScaleCTM (context, ovalWidth, ovalHeight); // 4
    fw = CGRectGetWidth (rect) / ovalWidth; // 5
    fh = CGRectGetHeight (rect) / ovalHeight; // 6
    CGContextMoveToPoint(context, fw, fh/2); // 7
    CGContextAddArcToPoint(context, fw, fh, fw/2, fh, 1); // 8
    CGContextAddArcToPoint(context, 0, fh, 0, fh/2, 1); // 9
    CGContextAddArcToPoint(context, 0, 0, fw/2, 0, 1); // 10
    CGContextAddArcToPoint(context, fw, 0, fw, fh/2, 1); // 11
    CGContextClosePath(context); // 12
    CGContextRestoreGState(context); // 13
}

@end
