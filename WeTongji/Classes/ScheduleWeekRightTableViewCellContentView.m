//
//  ScheduleWeekRightTableViewCellContentView.m
//  WeTongji
//
//  Created by 紫川 王 on 12-5-19.
//  Copyright (c) 2012年 Tongji Apple Club. All rights reserved.
//

#import "ScheduleWeekRightTableViewCellContentView.h"
#import "ScheduleWeekViewController.h"
#import "Course+Addition.h"
#import "Activity+Addition.h"

#define MINUTE_TO_HEIGHT_RATIO (LEFT_CELL_HEIGHT / 60.)

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
    [self drawHorizontalLines:context];
    [self drawVerticalLine:context];
    [self drawEvents:context];
}

- (void)drawHorizontalLines:(CGContextRef)context {
    CGContextSetRGBStrokeColor(context, 0.8f, 0.8f, 0.8f, 0.7f);
    CGContextSetLineWidth(context, 1.0f);
    for (int i = 1; i < LEFT_TABLE_VIEW_ROW_COUNT; i++) {
        //draw horizontal lines
        CGFloat leftCellHeight = LEFT_CELL_HEIGHT;
        CGFloat rightCellWidth = 85.0f;
        CGFloat verticalPos = i * leftCellHeight - self.verticalOffset;
        if (verticalPos >= 0 && verticalPos <= self.frame.size.height) {
            CGContextMoveToPoint(context, 0, verticalPos);
            CGContextAddLineToPoint(context, rightCellWidth, verticalPos);
        }
    }
    CGContextStrokePath(context);
}

- (void)drawVerticalLine:(CGContextRef)context {
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
    CGContextSetLineWidth(context, 1.0f);
    CGFloat alpha = 0.6f;
    for(Event * event in self.dataArray) {
        UIColor *strokeColor = nil;
        if([event isMemberOfClass:[Course class]]) {
            Course *course = (Course *)event;
            if([course.require_type isEqualToString:@"必修"]) {
                strokeColor = [UIColor colorWithRed:87 / 255. green:142 / 255. blue:195 / 255. alpha:1];
                CGContextSetRGBFillColor(context, 121 / 255., 181 / 255., 240 / 255., alpha);
            } else {
                strokeColor = [UIColor colorWithRed:79 / 255. green:178 / 255. blue:43 / 255. alpha:1];
                CGContextSetRGBFillColor(context, 135 / 255., 200 / 255., 76 / 255., alpha);
            }
        } else if([event isMemberOfClass:[Activity class]]) {
            strokeColor = [UIColor colorWithRed:253 / 255. green:186 / 255. blue:81 / 255. alpha:1];
            CGContextSetRGBFillColor(context, 255 / 255., 208 / 255., 52 / 255., alpha);
        } else 
            continue;
        
        CGContextSetStrokeColorWithColor(context, strokeColor.CGColor);
        
        //NSLog(@"event name:%@", event.what);
        float startPosition = [ScheduleWeekRightTableViewCellContentView startPosConvertFromDate:event.begin_time];
        float height = [ScheduleWeekRightTableViewCellContentView heightConvertFromTime:event.begin_time ToTime:event.end_time];
        
        if (startPosition - self.verticalOffset >= -height && startPosition - self.verticalOffset <= self.frame.size.height) {
            addRoundedRectToPath(context, CGRectMake(1, startPosition - self.verticalOffset, 82, height), 4.0f, 4.0f);
        }
        CGContextDrawPath(context, kCGPathEOFillStroke);
        
        [strokeColor set];
        
        CGFloat stringWidth = 77;
        CGFloat stringHorizontalOffset = (85 - stringWidth) / 2;
        CGFloat stringVerticalOffset = 3;
        
        CGSize whatStringSize = [event.what sizeWithFont:[UIFont boldSystemFontOfSize:12] constrainedToSize:CGSizeMake(stringWidth, height)];
        CGSize whereStringSize = [event.where sizeWithFont:[UIFont systemFontOfSize:12] constrainedToSize:CGSizeMake(stringWidth, height)];
        CGFloat minStringHeight = 15;
        whatStringSize.height = whatStringSize.height + whereStringSize.height + stringVerticalOffset > height ? height - whereStringSize.height - stringVerticalOffset : whatStringSize.height;
        whatStringSize.height = whatStringSize.height < minStringHeight ? minStringHeight : whatStringSize.height;
        whereStringSize.height = whereStringSize.height + whatStringSize.height + stringVerticalOffset > height ? height - whatStringSize.height - stringVerticalOffset : whereStringSize.height;
        if(whereStringSize.height < minStringHeight) {
            whereStringSize.height += stringVerticalOffset;
            stringVerticalOffset = 0;
        }
        
        [event.what drawInRect:CGRectMake(stringHorizontalOffset, startPosition - self.verticalOffset + stringVerticalOffset, stringWidth, whatStringSize.height) withFont:[UIFont boldSystemFontOfSize:12] lineBreakMode:UILineBreakModeTailTruncation alignment:UITextAlignmentLeft];
        
        [event.where drawInRect:CGRectMake(stringHorizontalOffset, startPosition - self.verticalOffset + whatStringSize.height + stringVerticalOffset, stringWidth, whereStringSize.height) withFont:[UIFont systemFontOfSize:12] lineBreakMode:UILineBreakModeTailTruncation alignment:UITextAlignmentLeft];
    }
}

- (void)setVerticalOffset:(CGFloat)verticalOffset {
    _verticalOffset = verticalOffset;
    [self setNeedsDisplay];
}

static void addRoundedRectToPath(CGContextRef context, CGRect rect, float ovalWidth, float ovalHeight) {
    float fw, fh;
    if (ovalWidth == 0 || ovalHeight == 0) {
        CGContextAddRect(context, rect);
        return;
    }
    CGContextSaveGState(context);
    CGContextTranslateCTM(context, CGRectGetMinX(rect), CGRectGetMinY(rect));
    CGContextScaleCTM(context, ovalWidth, ovalHeight);
    fw = CGRectGetWidth(rect) / ovalWidth;
    fh = CGRectGetHeight(rect) / ovalHeight;
    CGContextMoveToPoint(context, fw, fh / 2);
    CGContextAddArcToPoint(context, fw, fh, fw / 2, fh, 1);
    CGContextAddArcToPoint(context, 0, fh, 0, fh / 2, 1);
    CGContextAddArcToPoint(context, 0, 0, fw / 2, 0, 1);
    CGContextAddArcToPoint(context, fw, 0, fw, fh / 2, 1);
    CGContextClosePath(context);
    CGContextRestoreGState(context);
}

+ (int)startPosConvertFromDate:(NSDate *)date {
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];  
    NSInteger unitFlags = NSHourCalendarUnit | NSMinuteCalendarUnit;
    NSDateComponents *comps = [calendar components:unitFlags fromDate:date];
    int hour = [comps hour];
    int minute = [comps minute];
    int result = (hour - BEGIN_HOUR) * 60 + minute + 30;
    result *= MINUTE_TO_HEIGHT_RATIO;
    return result;
}

+ (int)heightConvertFromTime:(NSDate *)beginTime ToTime:(NSDate *)endTime {
    NSTimeInterval timeInterval = [endTime timeIntervalSinceDate:beginTime];   
    int result = timeInterval / 60 * MINUTE_TO_HEIGHT_RATIO;
    return result;
}


@end
