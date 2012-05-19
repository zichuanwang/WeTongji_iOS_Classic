//
//  ScheduleWeekRightTableViewCellContentView.m
//  WeTongji
//
//  Created by 紫川 王 on 12-5-19.
//  Copyright (c) 2012年 Tongji Apple Club. All rights reserved.
//

#import "ScheduleWeekRightTableViewCellContentView.h"
#import "ScheduleWeekViewController.h"

@implementation ScheduleWeekRightTableViewCellContentView

@synthesize verticalOffset = _verticalOffset;
@synthesize isOdd = _isOdd;

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetRGBStrokeColor(context, 0.0, 0.0, 0.0, 1.0);
    CGContextSetLineWidth(context, 1.0f);
    
    for (int i = 0; i < LEFT_TABLE_VIEW_ROW_COUNT; i++) {
        if (!self.isOdd) {
            //CGContextAddRect(context, CGRectMake(10.0, 30.0, 100.0, 100.0));  
        }
        
        //draw horizontal lines
        if ((i*40.0 - self.verticalOffset) >= 0 && (i*40.0 - self.verticalOffset) <=  self.frame.size.height) {
            CGContextMoveToPoint(context, 0, i*40.0-self.verticalOffset);
            CGContextAddLineToPoint(context, 85.0, i*40.0-self.verticalOffset);
        }
        
        //draw vertical lines
        CGContextSetRGBStrokeColor(context, 0.0, 0.0, 0.0, 1.0);
        CGContextSetLineWidth(context, 0.5f);
        CGContextMoveToPoint(context, 85.0, i*40.0);
        CGContextAddLineToPoint(context, 85.0, self.frame.size.height); 
        CGContextStrokePath(context);
    }
    
    //draw course rects
    CGContextSetRGBStrokeColor(context, 0.0, 0.0, 0.0, 1.0);
    CGContextSetRGBFillColor(context, 85.0/256, 198.0/256, 54.0/256, 0.8f);
    float startPosition = 280.0f;
    float height = 80.0f;
    if (startPosition >= -height && startPosition <=  self.frame.size.height) {
        addRoundedRectToPath(context, CGRectMake(0, startPosition - self.verticalOffset, 85.0f, height), 6.0f, 6.0f);
    }
    CGContextDrawPath(context, kCGPathEOFillStroke);
    
    [[UIColor whiteColor] set];
    NSString *courseName = @"操作系统dafdasf";
	UIFont *weekfont=[UIFont boldSystemFontOfSize:14];
	[courseName drawAtPoint:CGPointMake(5, startPosition - self.verticalOffset + 7) withFont:weekfont];
    
}

- (void)setVerticalOffset:(CGFloat)verticalOffset {
    _verticalOffset = verticalOffset;
    [self setNeedsDisplay];
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

- (int)startTimeConvertFromDate:(NSDate *)date {
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];  
    NSInteger unitFlags = NSHourCalendarUnit | NSMinuteCalendarUnit;
    NSDateComponents *comps  = [calendar components:unitFlags fromDate:date];
    int hour = [comps hour];  
    int minute = [comps minute];
    
    return (hour-7)*60 + minute;
}

- (int)heightConvertFromTime:(NSDate *)beginTime ToTime:(NSDate *)endTime {
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];  
    NSInteger unitFlags = NSHourCalendarUnit | NSMinuteCalendarUnit;
    NSDateComponents *comps  = [calendar components:unitFlags fromDate:beginTime];
    int beginHour = [comps hour];  
    int beginMinute = [comps minute];
    
    comps  = [calendar components:unitFlags fromDate:endTime];
    int endHour = [comps hour];  
    int endMinute = [comps minute];
    
    return (endHour - beginHour)*60 + (endMinute - beginMinute);
}


@end
