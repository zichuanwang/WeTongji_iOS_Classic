//
//  DayScheduleView.m
//  WeTongji
//
//  Created by M.K.Rain on 12-4-30.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "DayScheduleView.h"

const float dayHeadHeight=44;
const float dayItemHeight=35;
const float dayPrevNextButtonSize=20;
const float dayPrevNextButtonSpaceWidth=15;
const float dayPrevNextButtonSpaceHeight=12;

@implementation DayScheduleView

@synthesize sv = _sv;

@synthesize currentMonthDate;
@synthesize currentSelectDate;
@synthesize currentTime;

- (id)initWithCoder:(NSCoder *)coder {
    if (self = [super initWithCoder:coder]) {
        self.sv = [[UIScrollView alloc]initWithFrame:CGRectMake(0, dayHeadHeight, 320, 328)];
        self.sv.contentSize = CGSizeMake(320, 1056);
        self.sv.backgroundColor = [UIColor grayColor];
        [self addSubview:self.sv];
        
        UIImageView *back = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"DaySchedule.jpg"]];
        [self.sv addSubview:back];
        
        currentTime=CFAbsoluteTimeGetCurrent();
        currentMonthDate=CFAbsoluteTimeGetGregorianDate(currentTime,CFTimeZoneCopyDefault());
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)drawPrevButton:(CGPoint)leftTop
{
	CGContextRef ctx=UIGraphicsGetCurrentContext();
	CGContextSetGrayStrokeColor(ctx,0,1);
	CGContextMoveToPoint	(ctx,  0 + leftTop.x, dayPrevNextButtonSize/2 + leftTop.y);
	CGContextAddLineToPoint	(ctx, dayPrevNextButtonSize + leftTop.x,  0 + leftTop.y);
	CGContextAddLineToPoint	(ctx, dayPrevNextButtonSize + leftTop.x,  dayPrevNextButtonSize + leftTop.y);
	CGContextAddLineToPoint	(ctx,  0 + leftTop.x,  dayPrevNextButtonSize/2 + leftTop.y);
	CGContextFillPath(ctx);
}

- (void)drawNextButton:(CGPoint)leftTop
{
	CGContextRef ctx=UIGraphicsGetCurrentContext();
	CGContextSetGrayStrokeColor(ctx,0,1);
	CGContextMoveToPoint	(ctx,  0 + leftTop.x,  0 + leftTop.y);
	CGContextAddLineToPoint	(ctx, dayPrevNextButtonSize + leftTop.x,  dayPrevNextButtonSize/2 + leftTop.y);
	CGContextAddLineToPoint	(ctx,  0 + leftTop.x,  dayPrevNextButtonSize + leftTop.y);
	CGContextAddLineToPoint	(ctx,  0 + leftTop.x,  0 + leftTop.y);
	CGContextFillPath(ctx);
}

- (void)drawTopGradientBar{
	
	CGContextRef ctx=UIGraphicsGetCurrentContext();
	
	size_t num_locations = 3;
	CGFloat locations[3] = { 0.0, 0.5, 1.0};
	CGFloat components[12] = {  
		0.8, 0.8, 0.8, 1.0,
		0.5, 0.5, 0.5, 1.0,
		0.8, 0.8, 0.8, 1.0 
	};
	
	
	CGGradientRef myGradient;
	CGColorSpaceRef myColorspace = CGColorSpaceCreateDeviceRGB();
	myGradient = CGGradientCreateWithColorComponents (myColorspace, components,
													  locations, num_locations);
	CGPoint myStartPoint, myEndPoint;
	myStartPoint.x = dayHeadHeight;
	myStartPoint.y = 0.0;
	myEndPoint.x = dayHeadHeight;
	myEndPoint.y = dayHeadHeight;
	
	CGContextDrawLinearGradient(ctx,myGradient,myStartPoint, myEndPoint, 0);
	CGGradientRelease(myGradient);
    
	[self drawPrevButton:CGPointMake(dayPrevNextButtonSpaceWidth,dayPrevNextButtonSpaceHeight)];
	[self drawNextButton:CGPointMake(self.frame.size.width-dayPrevNextButtonSpaceWidth-dayPrevNextButtonSize,dayPrevNextButtonSpaceHeight)];
}

- (void)drawToday{
	CFTimeZoneRef tz = CFTimeZoneCopyDefault();
    
    //CGContextRef ctx=UIGraphicsGetCurrentContext(); 
    UIFont *dateFont=[UIFont boldSystemFontOfSize:18];
    int day = CFAbsoluteTimeGetDayOfWeek(CFGregorianDateGetAbsoluteTime(currentMonthDate,tz),tz);
    NSString *tmp = [[NSString alloc]init];
    switch (day) {
        case 1:
            tmp = @"一";
            break;
        case 2:
            tmp = @"二";
            break;
        case 3:
            tmp = @"三";
            break;
        case 4:
            tmp = @"四";
            break;
        case 5:
            tmp = @"五";
            break;
        case 6:
            tmp = @"六";
            break;
        case 7:
            tmp = @"七";
            break;
        default:
            break;
    }
    NSString *date=[NSString stringWithFormat:@"星期%@",tmp];
    [date drawAtPoint:CGPointMake(dayPrevNextButtonSize + dayPrevNextButtonSpaceWidth+7,dayPrevNextButtonSpaceHeight) withFont:dateFont];
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    [self drawTopGradientBar];
    [self drawToday];
}


@end
