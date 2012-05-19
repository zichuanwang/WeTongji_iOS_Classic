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
@synthesize row = _row;
@synthesize dataArray = _dataArray;

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
    if (self.row % 2) {
        [[UIColor colorWithRed:0 green:0 blue:0 alpha:0.04f] setFill];
        UIRectFill(rect); 
    }
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetRGBStrokeColor(context, 0.8f, 0.8f, 0.8f, 0.7f);
    CGContextSetLineWidth(context, 1.0f);
    for (int i = 1; i <= LEFT_TABLE_VIEW_ROW_COUNT; i++) {
        //draw horizontal lines
        CGFloat leftCellHeight = 40.0f;
        CGFloat rightCellWidth = 85.0f;
        CGFloat verticalPos = i * leftCellHeight - self.verticalOffset;
        if (verticalPos >= 0 && verticalPos <=  self.frame.size.height) {
            CGContextMoveToPoint(context, 0, verticalPos);
            CGContextAddLineToPoint(context, rightCellWidth, verticalPos);
        }
    }
    CGContextStrokePath(context);
    
    //draw vertical line
    CGContextSetLineWidth(context, 2.0f);
    CGContextMoveToPoint(context, 85.0, 0);
    CGContextAddLineToPoint(context, 85.0, self.frame.size.height); 
    if(self.row == 0) {
        CGContextMoveToPoint(context, 0, 0);
        CGContextAddLineToPoint(context, 0, self.frame.size.height);
    }
    CGContextStrokePath(context);
}

- (void)drawEvents:(CGContextRef)context {
    //draw events rect
    CGContextSetRGBStrokeColor(context, 0.0, 0.0, 0.0, 1.0);
    CGContextSetRGBFillColor(context, 85 / 255., 198.0 / 255., 54 / 255., 0.8f);
    float startPosition = 280.0f;
    float height = 80.0f;
    if (startPosition >= -height && startPosition <=  self.frame.size.height) {
        addRoundedRectToPath(context, CGRectMake(0, startPosition - self.verticalOffset, 85.0f, height), 6.0f, 6.0f);
    }
    CGContextDrawPath(context, kCGPathEOFillStroke);
    
    [[UIColor whiteColor] set];
    NSString *courseName = @"操作系统操作系统操作系统操作系统操作系统操作系统操作系统";
	//[courseName drawAtPoint:CGPointMake(5, startPosition - self.verticalOffset + 7) withFont:weekfont];
    [courseName drawInRect:CGRectMake(0, startPosition - self.verticalOffset, 85, height) withFont:[UIFont boldSystemFontOfSize:14] lineBreakMode:UILineBreakModeTailTruncation alignment:UITextAlignmentCenter];
}

- (void)setVerticalOffset:(CGFloat)verticalOffset {
    _verticalOffset = verticalOffset;
    [self setNeedsDisplay];
}

static void addRoundedRectToPath(CGContextRef context, CGRect rect, float ovalWidth, float ovalHeight) {
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
    
    return (hour - 7) * 60 + minute;
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
    
    return (endHour - beginHour) * 60 + (endMinute - beginMinute);
}


@end
