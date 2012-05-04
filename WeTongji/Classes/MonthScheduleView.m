//
//  CalendarView.m
//  ZhangBen
//
//  Created by tinyfool on 08-10-26.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import "MonthScheduleView.h"
#import <QuartzCore/QuartzCore.h>

const float headHeight=60;
const float itemHeight=35;
const float prevNextButtonSize=20;
const float prevNextButtonSpaceWidth=15;
const float prevNextButtonSpaceHeight=12;
const float titleFontSize=22;
const int	weekFontSize=10;

@implementation MonthScheduleView

@synthesize currentMonthDate;
@synthesize currentSelectDate;
@synthesize currentTime;
@synthesize viewImageView;

- (void)initCalView{
	currentTime=CFAbsoluteTimeGetCurrent();
	currentMonthDate=CFAbsoluteTimeGetGregorianDate(currentTime,CFTimeZoneCopyDefault());
	currentMonthDate.day=1;
	currentSelectDate.year=0;
	monthFlagArray=malloc(sizeof(int)*31);
	[self clearAllDayFlag];	
}

- (id)initWithCoder:(NSCoder *)coder {
    if (self = [super initWithCoder:coder]) {
		[self initCalView];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame {
	
	if (self = [super initWithFrame:frame]) {
		[self initCalView];
	}
	return self;
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

- (void)drawPrevButton:(CGPoint)leftTop
{
	CGContextRef ctx=UIGraphicsGetCurrentContext();
	CGContextSetGrayStrokeColor(ctx,0,1);
	CGContextMoveToPoint	(ctx,  0 + leftTop.x, prevNextButtonSize/2 + leftTop.y);
	CGContextAddLineToPoint	(ctx, prevNextButtonSize + leftTop.x,  0 + leftTop.y);
	CGContextAddLineToPoint	(ctx, prevNextButtonSize + leftTop.x,  prevNextButtonSize + leftTop.y);
	CGContextAddLineToPoint	(ctx,  0 + leftTop.x,  prevNextButtonSize/2 + leftTop.y);
	CGContextFillPath(ctx);
}

- (void)drawNextButton:(CGPoint)leftTop
{
	CGContextRef ctx=UIGraphicsGetCurrentContext();
	CGContextSetGrayStrokeColor(ctx,0,1);
	CGContextMoveToPoint	(ctx,  0 + leftTop.x,  0 + leftTop.y);
	CGContextAddLineToPoint	(ctx, prevNextButtonSize + leftTop.x,  prevNextButtonSize/2 + leftTop.y);
	CGContextAddLineToPoint	(ctx,  0 + leftTop.x,  prevNextButtonSize + leftTop.y);
	CGContextAddLineToPoint	(ctx,  0 + leftTop.x,  0 + leftTop.y);
	CGContextFillPath(ctx);
}

- (int)getDayFlag:(int)day
{
	if(day>=1 && day<=31)
	{
		return *(monthFlagArray+day-1);
	}
	else 
		return 0;
}

- (void)clearAllDayFlag
{
	memset(monthFlagArray,0,sizeof(int)*31);
}

- (void)setDayFlag:(int)day flag:(int)flag
{
	if(day>=1 && day<=31)
	{
		if(flag>0)
			*(monthFlagArray+day-1)=1;
		else if(flag<0)
			*(monthFlagArray+day-1)=-1;
	}
	
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
	myStartPoint.x = headHeight;
	myStartPoint.y = 0.0;
	myEndPoint.x = headHeight;
	myEndPoint.y = headHeight;
	
	CGContextDrawLinearGradient(ctx,myGradient,myStartPoint, myEndPoint, 0);
	CGGradientRelease(myGradient);

	[self drawPrevButton:CGPointMake(prevNextButtonSpaceWidth,prevNextButtonSpaceHeight)];
	[self drawNextButton:CGPointMake(self.frame.size.width-prevNextButtonSpaceWidth-prevNextButtonSize,prevNextButtonSpaceHeight)];
}

- (void)drawTopBarWords{
	int width=self.frame.size.width;
	int s_width=width/7;

	[[UIColor blackColor] set];
	NSString *title_Month   = [[NSString alloc] initWithFormat:@"%d年%d月",currentMonthDate.year,currentMonthDate.month];
	
	int fontsize=[UIFont buttonFontSize];
    UIFont   *font    = [UIFont fontWithName:@"Arial-BoldMT" size:titleFontSize];
	CGPoint  location = CGPointMake(width/2 -2.5*titleFontSize, 10);
    [title_Month drawAtPoint:location withFont:font];
	
	
	UIFont *weekfont=[UIFont fontWithName:@"Georgia" size:weekFontSize];
	fontsize+=26;
	
	[@"周一" drawAtPoint:CGPointMake(s_width*1+9,fontsize) withFont:weekfont];
	[@"周二" drawAtPoint:CGPointMake(s_width*2+9,fontsize) withFont:weekfont];
	[@"周三" drawAtPoint:CGPointMake(s_width*3+9,fontsize) withFont:weekfont];
	[@"周四" drawAtPoint:CGPointMake(s_width*4+9,fontsize) withFont:weekfont];
	[@"周五" drawAtPoint:CGPointMake(s_width*5+9,fontsize) withFont:weekfont];
	[@"周六" drawAtPoint:CGPointMake(s_width*6+9,fontsize) withFont:weekfont];
	[@"周日" drawAtPoint:CGPointMake(s_width*0+9,fontsize) withFont:weekfont];
	[[UIColor blackColor] set];
	
}

- (void)drawGirdLines{
	
	CGContextRef ctx=UIGraphicsGetCurrentContext();
	int width=self.frame.size.width;
    int row_Count = 0;
    if ([self getMonthWeekday:currentMonthDate] != 7) {
        row_Count=([self getDayCountOfaMonth:currentMonthDate]+[self getMonthWeekday:currentMonthDate]-1)/7+1;
    }else {
        row_Count=([self getDayCountOfaMonth:currentMonthDate])/7+1;
    }
    /*CGContextSetGrayFillColor(ctx, 0.7, 0.85);
    CGContextAddRect(ctx, CGRectMake(0, headHeight, self.frame.size.width, row_Count*itemHeight));
    CGContextFillPath(ctx);*/
    size_t num_locations = 2;
	CGFloat locations[2] = { 0.0,1.0};
	CGFloat components[8] = { 
        0.85, 0.85, 0.85, 0.9, 
		0.75, 0.75, 0.75, 0.9
	};
	
	CGGradientRef myGradient;
	CGColorSpaceRef myColorspace = CGColorSpaceCreateDeviceRGB();
	myGradient = CGGradientCreateWithColorComponents (myColorspace, components,
													  locations, num_locations);
	CGPoint myStartPoint, myEndPoint;
	myStartPoint.x = headHeight;
	myStartPoint.y = headHeight;
	myEndPoint.x = headHeight;
	myEndPoint.y = headHeight+row_Count*itemHeight;
	
	CGContextDrawLinearGradient(ctx,myGradient,myStartPoint, myEndPoint, 0);
	CGGradientRelease(myGradient);
	
	int s_width=width/7;
	int tabHeight=row_Count*itemHeight+headHeight;

	CGContextSetGrayStrokeColor(ctx,0,1);
	//CGContextMoveToPoint	(ctx,0,headHeight);
	//CGContextAddLineToPoint	(ctx,0,tabHeight);
	//CGContextStrokePath		(ctx);
	//CGContextMoveToPoint	(ctx,width,headHeight);
	//CGContextAddLineToPoint	(ctx,width,tabHeight);
	//CGContextStrokePath		(ctx);
	
	for(int i=1;i<7;i++){
		CGContextSetGrayStrokeColor(ctx,0.9,1);
		CGContextMoveToPoint(ctx, i*s_width-1, headHeight);
        CGContextSetLineWidth(ctx, 0.6);
		CGContextAddLineToPoint( ctx, i*s_width-1,tabHeight);
		CGContextStrokePath(ctx);
     
        CGContextSetGrayStrokeColor(ctx,0,1);
        CGContextMoveToPoint(ctx, i*s_width, headHeight);
        CGContextSetLineWidth(ctx, 0.3);
        CGContextAddLineToPoint( ctx, i*s_width,tabHeight);
        CGContextStrokePath(ctx);
     }
	
	for(int i=0;i<row_Count+1;i++){
		CGContextSetGrayStrokeColor(ctx,0.9,1);
		CGContextMoveToPoint(ctx, 0, i*itemHeight+headHeight+1);
        CGContextSetLineWidth(ctx, 0.6);
		CGContextAddLineToPoint( ctx, width,i*itemHeight+headHeight+1);
		CGContextStrokePath(ctx);
		
		CGContextSetGrayStrokeColor(ctx,0,1);
		CGContextMoveToPoint(ctx, 0, i*itemHeight+headHeight);
        CGContextSetLineWidth(ctx, 0.3);
		CGContextAddLineToPoint( ctx, width,i*itemHeight+headHeight);
		CGContextStrokePath(ctx);
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

- (void)drawDateWords{
	CGContextRef ctx=UIGraphicsGetCurrentContext();

	int width=self.frame.size.width;
	
	int dayCount=[self getDayCountOfaMonth:currentMonthDate];
	int day=0;
	int x=0;
	int y=0;
	int s_width=width/7;
	int curr_Weekday=[self getMonthWeekday:currentMonthDate];
    UIFont *weekfont = [UIFont fontWithName:@"Arial-BoldMT" size:14];

	for(int i=1;i<dayCount+1;i++)
	{
		day=i+curr_Weekday-1;
        x=day % 7;
        if (curr_Weekday != 7) {
            y=day / 7;
        }else {
            y =day / 7 - 1;
        }
		NSString *date=[[NSString alloc] initWithFormat:@"%2d",i] ;
		[date drawAtPoint:CGPointMake(x*s_width+15,y*itemHeight+headHeight+4) withFont:weekfont];
		if([self getDayFlag:i]==1)
		{
			CGContextSetRGBFillColor(ctx, 1, 0, 0, 1);
			[@"." drawAtPoint:CGPointMake(x*s_width+19,y*itemHeight+headHeight+6) withFont:[UIFont boldSystemFontOfSize:25]];
		}
		else if([self getDayFlag:i]==-1)
		{
			CGContextSetRGBFillColor(ctx, 0, 8.5, 0.3, 1);
			[@"." drawAtPoint:CGPointMake(x*s_width+19,y*itemHeight+headHeight+6) withFont:[UIFont boldSystemFontOfSize:25]];
		}
			
		CGContextSetRGBFillColor(ctx, 0, 0, 0, 1);
	}
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
	viewImage= UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	if(viewImageView==nil)
	{
		viewImageView=[[UIImageView alloc] initWithImage:viewImage];
		
		viewImageView.center=self.center;
		[[self superview] addSubview:viewImageView];
	}
	else
	{
		viewImageView.image=viewImage;
	}
	
	viewImageView.hidden=NO;
	viewImageView.transform=CGAffineTransformMakeTranslation(0, 0);
	self.hidden=YES;
	[self setNeedsDisplay];
	self.transform=CGAffineTransformMakeTranslation(posX,0);
	
	
	//float height;
	//int row_Count=([self getDayCountOfaMonth:currentMonthDate]+[self getMonthWeekday:currentMonthDate]-2)/7+1;
	//height=row_Count*itemHeight+headHeight;
	//self.frame=CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, height);
	self.hidden=NO;
	[UIView beginAnimations:nil	context:nil];
	[UIView setAnimationDuration:0.5];
	self.transform=CGAffineTransformMakeTranslation(0,0);
	viewImageView.transform=CGAffineTransformMakeTranslation(-posX, 0);
	[UIView commitAnimations];
	//[calendarViewDelegate monthChanged:currentMonthDate viewLeftTop:self.frame.origin height:height];
	
}

- (void)movePrevMonth{
	if(currentMonthDate.month>1)
		currentMonthDate.month-=1;
	else
	{
		currentMonthDate.month=12;
		currentMonthDate.year-=1;
	}
	[self movePrevNext:0];
}

- (void)moveNextMonth{
	if(currentMonthDate.month<12)
		currentMonthDate.month+=1;
	else
	{
		currentMonthDate.month=1;
		currentMonthDate.year+=1;
	}
	[self movePrevNext:1];	
}

- (void) drawToday{
	int x;
	int y;
	int day;
	CFGregorianDate today=CFAbsoluteTimeGetGregorianDate(currentTime, CFTimeZoneCopyDefault());
	if(today.month==currentMonthDate.month && today.year==currentMonthDate.year)
	{
		int width=self.frame.size.width;
		int swidth=width/7;
		int weekday=[self getMonthWeekday:currentMonthDate];
		day=today.day+weekday-1;
		x=day%7;
        if (weekday != 7) {
            y=day / 7;
        }else {
            y =day / 7 - 1;
        }
		CGContextRef ctx=UIGraphicsGetCurrentContext(); 
		CGContextSetRGBFillColor(ctx, 0.5, 0.5, 0.5, 1);
		CGContextMoveToPoint(ctx, x*swidth+1, y*itemHeight+headHeight+1);
		CGContextAddLineToPoint(ctx, x*swidth+swidth-1, y*itemHeight+headHeight+1);
		CGContextAddLineToPoint(ctx, x*swidth+swidth-1, y*itemHeight+headHeight+itemHeight-1);
		CGContextAddLineToPoint(ctx, x*swidth+1, y*itemHeight+headHeight+itemHeight-1);
		CGContextFillPath(ctx);

		CGContextSetRGBFillColor(ctx, 1, 1, 1, 1);
		UIFont *weekfont=[UIFont boldSystemFontOfSize:12];
		NSString *date=[[NSString alloc] initWithFormat:@"%2d",today.day];
		[date drawAtPoint:CGPointMake(x*swidth+15,y*itemHeight+headHeight+4) withFont:weekfont];
		if([self getDayFlag:today.day]==1)
		{
			CGContextSetRGBFillColor(ctx, 1, 0, 0, 1);
			[@"." drawAtPoint:CGPointMake(x*swidth+19,y*itemHeight+headHeight+6) withFont:[UIFont boldSystemFontOfSize:25]];
		}
		else if([self getDayFlag:today.day]==-1)
		{
			CGContextSetRGBFillColor(ctx, 0, 8.5, 0.3, 1);
			[@"." drawAtPoint:CGPointMake(x*swidth+19,y*itemHeight+headHeight+6) withFont:[UIFont boldSystemFontOfSize:25]];
		}
		
	}
}

- (void) drawCurrentSelectDate{
	int x;
	int y;
	int day;
	int todayFlag;
	if(currentSelectDate.year!=0)
	{
		CFGregorianDate today=CFAbsoluteTimeGetGregorianDate(currentTime, CFTimeZoneCopyDefault());

		if(today.year==currentSelectDate.year && today.month==currentSelectDate.month && today.day==currentSelectDate.day)
			todayFlag=1;
		else
			todayFlag=0;
		
		int width=self.frame.size.width;
		int swidth=width/7;
		int weekday=[self getMonthWeekday:currentMonthDate];
		day=currentSelectDate.day+weekday-1;
		x=day%7;
        if (weekday != 7) {
            y=day / 7;
        }else {
            y =day / 7 - 1;
        }
		CGContextRef ctx=UIGraphicsGetCurrentContext();
		
		if(todayFlag==1)
			CGContextSetRGBFillColor(ctx, 0, 0, 0.7, 1);
		else
			CGContextSetRGBFillColor(ctx, 0, 0, 1, 1);
		CGContextMoveToPoint(ctx, x*swidth+1, y*itemHeight+headHeight+1);
		CGContextAddLineToPoint(ctx, x*swidth+swidth-1, y*itemHeight+headHeight+1);
		CGContextAddLineToPoint(ctx, x*swidth+swidth-1, y*itemHeight+headHeight+itemHeight-1);
		CGContextAddLineToPoint(ctx, x*swidth+1, y*itemHeight+headHeight+itemHeight-1);
		CGContextFillPath(ctx);	
		
		if(todayFlag==1)
		{
			CGContextSetRGBFillColor(ctx, 0, 0, 1, 1);
			CGContextMoveToPoint	(ctx, x*swidth+4,			y*itemHeight+headHeight+3);
			CGContextAddLineToPoint	(ctx, x*swidth+swidth-1,	y*itemHeight+headHeight+3);
			CGContextAddLineToPoint	(ctx, x*swidth+swidth-1,	y*itemHeight+headHeight+itemHeight-3);
			CGContextAddLineToPoint	(ctx, x*swidth+4,			y*itemHeight+headHeight+itemHeight-3);
			CGContextFillPath(ctx);	
		}
		
		CGContextSetRGBFillColor(ctx, 1, 1, 1, 1);

		UIFont *weekfont=[UIFont boldSystemFontOfSize:12];
		NSString *date=[[NSString alloc] initWithFormat:@"%2d",currentSelectDate.day];
		[date drawAtPoint:CGPointMake(x*swidth+15,y*itemHeight+headHeight+4) withFont:weekfont];
		if([self getDayFlag:currentSelectDate.day]!=0)
		{
			[@"." drawAtPoint:CGPointMake(x*swidth+19,y*itemHeight+headHeight) withFont:[UIFont boldSystemFontOfSize:25]];
		}		
	}
}

- (void) touchAtDate:(CGPoint) touchPoint{
	int x;
	int y;
	int width=self.frame.size.width;
	int firstMonthday=[self getMonthWeekday:currentMonthDate];
    if (firstMonthday == 7) {
        firstMonthday = 0;
    }
	int monthDayCount=[self getDayCountOfaMonth:currentMonthDate];
	x=touchPoint.x*7/width+1;
	y=(touchPoint.y-headHeight)/itemHeight+1;
    int monthday = (y-1)*7+x - firstMonthday;
	if(monthday>0 && monthday<monthDayCount+1)
	{
		currentSelectDate.year=currentMonthDate.year;
		currentSelectDate.month=currentMonthDate.month;
		currentSelectDate.day=monthday;
		currentSelectDate.hour=0;
		currentSelectDate.minute=0;
		currentSelectDate.second=1;
		//[calendarViewDelegate selectDateChanged:currentSelectDate];
		[self setNeedsDisplay];
	}
}

- (void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
	int width=self.frame.size.width;
	UITouch* touch=[touches anyObject];
	CGPoint touchPoint=[touch locationInView:self];
	//UIView* theview=[self hitTest:touchPoint withEvent:event];
	if(touchPoint.x<40 && touchPoint.y<headHeight)
		[self movePrevMonth];
	else if(touchPoint.x>width-40 && touchPoint.y<headHeight)
		[self moveNextMonth];
	else if(touchPoint.y>headHeight)
	{
		[self touchAtDate:touchPoint];
	}
}

- (void)drawRect:(CGRect)rect{

	static int once=0;
	currentTime=CFAbsoluteTimeGetCurrent();
	
	[self drawTopGradientBar];
	[self drawTopBarWords];
	[self drawGirdLines];
	
	if(once==0)
	{
		once=1;
		float height;
		int row_Count=([self getDayCountOfaMonth:currentMonthDate]+[self getMonthWeekday:currentMonthDate]-2)/7+1;
		height=row_Count*itemHeight+headHeight;
		//[calendarViewDelegate monthChanged:currentMonthDate viewLeftTop:self.frame.origin height:height];
		//[calendarViewDelegate beforeMonthChange:self willto:currentMonthDate];

	}
	[self drawDateWords];
	[self drawToday];
	[self drawCurrentSelectDate];
	
}

- (void)dealloc {
    //[super dealloc];
	free(monthFlagArray);
}


@end
