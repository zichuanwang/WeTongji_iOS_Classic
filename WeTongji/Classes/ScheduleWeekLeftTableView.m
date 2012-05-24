//
//  ScheduleWeekLeftTableView.m
//  WeTongji
//
//  Created by 紫川 王 on 12-5-24.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ScheduleWeekLeftTableView.h"
#import "ScheduleWeekRightTableViewCellContentView.h"

@implementation ScheduleWeekLeftTableView

@synthesize swipeDelegate = _swipeDelegate;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    [super drawRect:rect];
    CGContextRef context = UIGraphicsGetCurrentContext();
    [self drawCurrentTimeLine:context];
}

- (void)drawCurrentTimeLine:(CGContextRef)context {
    CGContextSetRGBStrokeColor(context, 253 / 255., 53 / 255., 71 / 255., 0.6f);
    CGContextSetLineWidth(context, 1.0f);
    CGFloat verticalPos = [ScheduleWeekRightTableViewCellContentView startPosConvertFromDate:[NSDate date]];
    NSLog(@"current line:%f", verticalPos);
    CGContextMoveToPoint(context, 65.0, verticalPos);
    CGContextAddLineToPoint(context, 320.0f, verticalPos);
    CGContextStrokePath(context);
}

- (BOOL)touchesShouldBegin:(NSSet *)touches withEvent:(UIEvent *)event inContentView:(UIView *)view  
{  
    return YES;  
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch * touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    if(point.x > 65)
        self.scrollEnabled = NO;
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch * touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    CGPoint formerPoint = [touch previousLocationInView:self];
    
    CGFloat distanceX = formerPoint.x - point.x;
    CGFloat distanceY = formerPoint.y - point.y;
    
    //distanceY = distanceY > 20 ? 20 : distanceY;
    //distanceX *= 1.2f;
    
    [self.swipeDelegate scheduleWeekLeftTableView:self didSwipeHorizontally:distanceX swipeVertically:distanceY];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    self.scrollEnabled = YES;
}

@end
