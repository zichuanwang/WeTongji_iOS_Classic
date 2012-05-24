//
//  ScheduleWeekLeftTableView.m
//  WeTongji
//
//  Created by 紫川 王 on 12-5-24.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ScheduleWeekLeftTableView.h"

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

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

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
    distanceX = distanceX > 20 ? 20 : distanceX;
    distanceY = distanceY > 20 ? 20 : distanceY;
    [self.swipeDelegate scheduleWeekLeftTableView:self didSwipeHorizontally:distanceX swipeVertically:distanceY];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    self.scrollEnabled = YES;
}

@end
