//
//  ScheduleWeekLeftTableView.m
//  WeTongji
//
//  Created by 紫川 王 on 12-5-24.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ScheduleWeekLeftTableView.h"
#import "ScheduleWeekRightTableViewCellContentView.h"

#define ACCCELERATED_SPEED 1.0f

@implementation ScheduleWeekLeftTableView

@synthesize swipeDelegate = _swipeDelegate;
@synthesize speedX = _speedX;
@synthesize speedY = _speedY;

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
    CGContextSetRGBStrokeColor(context, 253 / 255., 53 / 255., 71 / 255., 0.4f);
    CGContextSetLineWidth(context, 1.0f);
    CGFloat verticalPos = [ScheduleWeekRightTableViewCellContentView startPosConvertFromDate:[NSDate date]];
    CGContextMoveToPoint(context, 65.0, verticalPos);
    CGContextAddLineToPoint(context, 320.0f, verticalPos);
    CGContextStrokePath(context);
}

- (BOOL)touchesShouldBegin:(NSSet *)touches withEvent:(UIEvent *)event inContentView:(UIView *)view  
{  
    [_timer invalidate];
    _timer = [NSTimer scheduledTimerWithTimeInterval:0.02 target:self selector:@selector(handleTimeCount:) userInfo:nil repeats:YES];
    
    _timeCountX = 1;
    _timeCountY = 1;
    
    _distanceX = 0;
    _distanceY = 0;
    
    _freezeCountX = 0;
    _freezeCountY = 0;
    
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
    
    _distanceX += distanceX;
    _distanceY += distanceY;
    
    NSLog(@"distanceX:%f, _distanceX:%f", distanceX, _distanceX);
    
    //distanceY = distanceY > 20 ? 20 : distanceY;
    //distanceX *= 1.2f;
    
    [self.swipeDelegate scheduleWeekLeftTableView:self didSwipeHorizontally:distanceX swipeVertically:distanceY];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    self.scrollEnabled = YES;
    [_timer invalidate];
    
    _speedX = _distanceX / _timeCountX;
    _speedY = _distanceY / _timeCountY / 2;
    NSLog(@"speedX:%f, speedY:%f", _speedX, _speedY);
    _timer = [NSTimer scheduledTimerWithTimeInterval:0.02 target:self selector:@selector(handleDecelerate:) userInfo:nil repeats:YES];
}

- (void)handleTimeCount:(NSTimer *)timer {
    static CGFloat formerDistanceX = 0;
    static CGFloat formerDistanceY = 0;
    _timeCountX++;
    _timeCountY++;
    
    if(fabsf(formerDistanceX - _distanceX) < 1) {
        _freezeCountX++;
        if(_freezeCountX >= 5) {
            _distanceX = 0;
            _timeCountX = 1;
            _freezeCountX = 0;
            NSLog(@"freeze");
        }
    }
    NSLog(@"freezeX:%f", fabsf(formerDistanceX - _distanceX));
    
    if(fabsf(formerDistanceY - _distanceY) < 1) {
        _freezeCountY++;
        if(_freezeCountY >= 5) {
            _distanceY = 0;
            _timeCountY = 1;
            _freezeCountY = 0;
        }
    }
    
    formerDistanceX = _distanceX;
    formerDistanceY = _distanceY;
}

- (void)handleDecelerate:(NSTimer *)timer {
    
    _speedX *= 0.95f;
    _speedY *= 0.9f;
    
    if(fabsf(_speedX) < 0.2)
        _speedX = 0;
    if(fabsf(_speedY) < 0.2)
        _speedY = 0;
    
    if(_speedX != 0 || _speedY != 0)
        [self.swipeDelegate scheduleWeekLeftTableView:self didSwipeHorizontally:_speedX swipeVertically:_speedY];
    else {
        [_timer invalidate];
        _timer = nil;
    }
}

@end
