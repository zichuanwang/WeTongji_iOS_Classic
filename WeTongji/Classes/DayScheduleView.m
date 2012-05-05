//
//  DayScheduleView.m
//  WeTongji
//
//  Created by M.K.Rain on 12-4-30.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#define kCELL_X 60
#define kCELLWIDTH 240

#import <QuartzCore/QuartzCore.h>
#import "DayScheduleView.h"
#import "quartzView.h"

const float dayHeadHeight=44;
const float dayItemHeight=35;
const float dayPrevNextButtonSize=20;
const float dayPrevNextButtonSpaceWidth=15;
const float dayPrevNextButtonSpaceHeight=12;

@implementation DayScheduleView

@synthesize sv = _sv;
@synthesize currentView = _currentView;
@synthesize viewImageView = _viewImageView;

@synthesize currentMonthDate;
@synthesize currentSelectDate;
@synthesize currentTime;
@synthesize firstRect = _firstRect;

- (id)initWithCoder:(NSCoder *)coder {
    if (self = [super initWithCoder:coder]) {
        self.sv = [[UIScrollView alloc]initWithFrame:CGRectMake(0, dayHeadHeight, 320, 334)];
        self.sv.contentSize = CGSizeMake(320, 1060);
        self.sv.delaysContentTouches = YES;
        self.sv.backgroundColor = [UIColor grayColor];
        [self addSubview:self.sv];
        UIImageView *back = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"DaySchedule.jpg"]];
        [self.sv addSubview:back];
        
        self.currentView = [[quartzView alloc] initWithFrame:CGRectMake(0, 0, 320, 1060)];
        [self.sv addSubview:self.currentView];
        self.currentView.currentDate = @"3月3日";
        
        currentTime=CFAbsoluteTimeGetCurrent();
        currentMonthDate=CFAbsoluteTimeGetGregorianDate(currentTime,CFTimeZoneCopyDefault());
        
        self.firstRect = CGRectMake(0, 0, kCELLWIDTH, 1);
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
	
	size_t num_locations = 2;
	CGFloat locations[2] = { 0.0, 1.0};
	CGFloat components[8] = {  
		1.0, 1.0, 1.0, 1.0,
		0.7, 0.7, 0.7, 0.85 
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
            tmp = @"日";
            break;
        default:
            break;
    }
    NSString *date=[NSString stringWithFormat:@"星期%@",tmp];
    [date drawAtPoint:CGPointMake(dayPrevNextButtonSize + dayPrevNextButtonSpaceWidth+10,dayPrevNextButtonSpaceHeight) withFont:dateFont];
    date = [NSString stringWithFormat:@"%d %d %d",currentMonthDate.year,currentMonthDate.month,currentMonthDate.day];
    [date drawAtPoint:CGPointMake(self.frame.size.width-dayPrevNextButtonSpaceWidth-dayPrevNextButtonSize-86,dayPrevNextButtonSpaceHeight) withFont:dateFont];
}

- (void)moveToToday{
    CGRect tmp;
    NSLog(@"sv:  %f",self.sv.contentOffset.y);
    NSLog(@"firstRec:  %f",self.currentView.firstRect.origin.y);
    if (self.currentView.firstRect.origin.y>291+self.sv.contentOffset.y ) {
        tmp = CGRectMake(self.currentView.firstRect.origin.x, self.currentView.firstRect.origin.y+280, self.currentView.firstRect.size.width, self.currentView.firstRect.size.height);
        [self.sv scrollRectToVisible:tmp animated:YES];
    }else {
        tmp = CGRectMake(self.currentView.firstRect.origin.x, self.currentView.firstRect.origin.y-10, self.currentView.firstRect.size.width, self.currentView.firstRect.size.height);
        [self.sv scrollRectToVisible:tmp animated:YES];
    }
}

- (int)getDayCountOfaMonth:(CFGregorianDate)date{
	switch (date.month) {
		case 1:
		case 3:
		case 5:
		case 7:
		case 8:
		case 10:
		case 12:
			return 31;
		case 2:
			if(date.year%4==0 && date.year%100!=0)
				return 29;
			else
				return 28;
		case 4:
		case 6:
		case 9:		
		case 11:
			return 30;
		default:
			return 31;
	}
}

- (int)getMonthWeekday:(CFGregorianDate)date
{
	CFTimeZoneRef tz = CFTimeZoneCopyDefault();
	CFGregorianDate month_date;
	month_date.year=date.year;
	month_date.month=date.month;
	month_date.day=1;
	month_date.hour=0;
	month_date.minute=0;
	month_date.second=1;
	return (int)CFAbsoluteTimeGetDayOfWeek(CFGregorianDateGetAbsoluteTime(month_date,tz),tz);
}

- (void) movePrevNext:(int)isPrev{
	currentSelectDate.year=0;
	//[calendarViewDelegate beforeMonthChange:self willto:currentMonthDate];
	int width=self.frame.size.width;
	int posX;
	if(isPrev==1)
	{
		posX=width;
	}
	else
	{
		posX=-width;
	}
	
	UIImage *viewImage;
	
	UIGraphicsBeginImageContext(self.bounds.size);
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
	//[self.layer renderInContext:UIGraphicsGetCurrentContext()];	
	viewImage= UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	if(self.viewImageView==nil)
	{
		self.viewImageView=[[UIImageView alloc] initWithImage:viewImage];
		
		self.viewImageView.center=self.center;
		[[self superview] addSubview:self.viewImageView];
	}
	else
	{
		self.viewImageView.image=viewImage;
	}
	
	self.viewImageView.hidden=NO;
	self.viewImageView.transform=CGAffineTransformMakeTranslation(0, 0);
	self.hidden=YES;
	[self setNeedsDisplay];
	self.transform=CGAffineTransformMakeTranslation(posX,0);
    
	self.hidden=NO;
	[UIView beginAnimations:nil	context:nil];
	[UIView setAnimationDuration:0.5];
	self.transform=CGAffineTransformMakeTranslation(0,0);
	self.viewImageView.transform=CGAffineTransformMakeTranslation(-posX, 0);
	[UIView commitAnimations];
	//[calendarViewDelegate monthChanged:currentMonthDate viewLeftTop:self.frame.origin height:height];
	
}

- (void)movePrevDay{
	if(currentMonthDate.day>1)
		currentMonthDate.day-=1;
	else
	{
        if (currentMonthDate.month>1) {
            currentMonthDate.month-=1;
        }else {
            currentMonthDate.month=12;
            currentMonthDate.year-=1;
        }
        currentMonthDate.day = [self getDayCountOfaMonth:currentMonthDate];
	}
	[self movePrevNext:0];
}

- (void)moveNextDay{
	if(currentMonthDate.day<[self getDayCountOfaMonth:currentMonthDate])
		currentMonthDate.day+=1;
	else
	{
        if (currentMonthDate.month<12) {
            currentMonthDate.month+=1;
        }else {
            currentMonthDate.month=1;
            currentMonthDate.year+=1;
        }
        currentMonthDate.day = 1;
	}
	[self movePrevNext:1];	
}

- (void) touchAtDate:(CGPoint) touchPoint{
	//judge which course is touched 
    //and push a new detail view
    
}

- (void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {

	int width=self.frame.size.width;
	UITouch* touch=[touches anyObject];
	CGPoint touchPoint=[touch locationInView:self];
	if(touchPoint.x<40 && touchPoint.y<dayHeadHeight)
		[self movePrevDay];
	else if(touchPoint.x>width-40 && touchPoint.y<dayHeadHeight)
		[self moveNextDay];
	else if(touchPoint.y>dayHeadHeight)
	{
		//[self touchAtDate:touchPoint];
	}
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
