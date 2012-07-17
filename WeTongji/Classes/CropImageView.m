//
//  CropImageView.m
//  VCard
//
//  Created by 紫川 王 on 12-4-18.
//  Copyright (c) 2012年 Mondev. All rights reserved.
//

#import "CropImageView.h"

typedef enum {
    PointPositionLeftTop,
    PointPositionRightTop,
    PointPositionRightBottom,
    PointPositionLeftBottom,
} PointPositionIdentifier;

#define MINIMUM_INTERVAL 100
#define CROP_SECTION_NUM 3

@interface CropImageView() 

@property (nonatomic, strong) NSMutableArray *pointImageViewArray;

@end

@implementation CropImageView

@synthesize pointImageViewArray = _pointImageViewArray;

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        // Initialization code
        self.pointImageViewArray = [[NSMutableArray alloc] initWithCapacity:4];
        for(int i = 0; i < 4; i++) {
            UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"crop_image_puller.png"]];
            [self.pointImageViewArray addObject:imageView];
            [self addSubview:imageView];
        }
    }
    return self;
}

- (void)setDefault {    
    CGPoint center = _cropImageInitCenter;
    
    [self pointImageViewWithIdentifier:PointPositionLeftTop].center = CGPointMake(center.x - MINIMUM_INTERVAL / 2, center.y - MINIMUM_INTERVAL / 2);
    [self pointImageViewWithIdentifier:PointPositionRightBottom].center = CGPointMake(center.x + MINIMUM_INTERVAL / 2, center.y + MINIMUM_INTERVAL / 2);
    [self pointImageViewWithIdentifier:PointPositionLeftBottom].center = CGPointMake(center.x - MINIMUM_INTERVAL / 2, center.y + MINIMUM_INTERVAL / 2);
    [self pointImageViewWithIdentifier:PointPositionRightTop].center = CGPointMake(center.x + MINIMUM_INTERVAL / 2, center.y - MINIMUM_INTERVAL / 2);
    
    CGPoint leftTopPoint = CGPointMake(center.x - _cropImageInitSize.width / 2, center.y - _cropImageInitSize.height / 2);
    CGPoint rightBottomPoint = CGPointMake(center.x + _cropImageInitSize.width / 2, center.y + _cropImageInitSize.height / 2);
    
    int minimumXArray[] = {leftTopPoint.x, leftTopPoint.x + MINIMUM_INTERVAL, leftTopPoint.x + MINIMUM_INTERVAL, leftTopPoint.x};
    int minimumYArray[] = {leftTopPoint.y, leftTopPoint.y, leftTopPoint.y + MINIMUM_INTERVAL, leftTopPoint.y + MINIMUM_INTERVAL};
    int maximumXArray[] = {rightBottomPoint.x - MINIMUM_INTERVAL, rightBottomPoint.x, rightBottomPoint.x, rightBottomPoint.x - MINIMUM_INTERVAL};
    int maximumYArray[] = {rightBottomPoint.y - MINIMUM_INTERVAL, rightBottomPoint.y - MINIMUM_INTERVAL, rightBottomPoint.y, rightBottomPoint.y};
    
    for(int i = 0; i < 4; i++) {
        _minimumXArray[i] = minimumXArray[i];
        _minimumYArray[i] = minimumYArray[i];
        _maximumXArray[i] = maximumXArray[i];
        _maximumYArray[i] = maximumYArray[i];
    }
    
}

- (UIImageView *)pointImageViewWithIdentifier:(PointPositionIdentifier)identifier {
    return [self.pointImageViewArray objectAtIndex:identifier];
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.

#pragma mark - Draw methods

- (void)drawShadow {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, CGColorCreateCopyWithAlpha([UIColor blackColor].CGColor, 0.6f));
    
    CGRect rectangle = CGRectMake(0, 0, (int)[self pointImageViewWithIdentifier:PointPositionRightTop].center.x, (int)[self pointImageViewWithIdentifier:PointPositionRightTop].center.y);
    CGContextAddRect(context, rectangle);
    CGContextFillRect(context, rectangle);
    
    rectangle = CGRectMake((int)[self pointImageViewWithIdentifier:PointPositionRightTop].center.x, 0, self.frame.size.width - (int)[self pointImageViewWithIdentifier:PointPositionRightBottom].center.x, (int)[self pointImageViewWithIdentifier:PointPositionRightBottom].center.y);
    CGContextAddRect(context, rectangle);
    CGContextFillRect(context, rectangle);
    
    rectangle = CGRectMake((int)[self pointImageViewWithIdentifier:PointPositionLeftBottom].center.x, (int)[self pointImageViewWithIdentifier:PointPositionLeftBottom].center.y, self.frame.size.width, self.frame.size.height);
    CGContextAddRect(context, rectangle);
    CGContextFillRect(context, rectangle);
    
    rectangle = CGRectMake(0, (int)[self pointImageViewWithIdentifier:PointPositionLeftTop].center.y, (int)[self pointImageViewWithIdentifier:PointPositionLeftTop].center.x, self.frame.size.height - (int)[self pointImageViewWithIdentifier:PointPositionLeftTop].center.y);
    CGContextAddRect(context, rectangle);
    CGContextFillRect(context, rectangle);
}

- (void)drawLine {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 2.0);
    CGContextSetStrokeColorWithColor(context, CGColorCreateCopyWithAlpha([UIColor whiteColor].CGColor, 0.6f));
    
    CGPoint initPos = [self pointImageViewWithIdentifier:PointPositionLeftBottom].center;
    CGContextMoveToPoint(context, initPos.x, initPos.y);
    for(UIImageView *pointImageView in self.pointImageViewArray) {
        CGPoint currentPos = pointImageView.center;
        CGContextAddLineToPoint(context, currentPos.x, currentPos.y);
        CGContextMoveToPoint(context, currentPos.x, currentPos.y);
    }
    CGContextStrokePath(context);
    
    CGContextSetLineWidth(context, 1.0);
    CGPoint leftTopPoint = [self pointImageViewWithIdentifier:PointPositionLeftTop].center;
    CGPoint rightBottom = [self pointImageViewWithIdentifier:PointPositionRightBottom].center;
    CGSize cropSize = CGSizeMake(rightBottom.x - leftTopPoint.x , rightBottom.y - leftTopPoint.y);
    CGSize cropSectionSize = CGSizeMake(cropSize.width / CROP_SECTION_NUM, cropSize.height / CROP_SECTION_NUM);
    
    for(int i = 1; i < CROP_SECTION_NUM; i++) {
        CGPoint verticalPos = CGPointMake(leftTopPoint.x + i * cropSectionSize.width, leftTopPoint.y);
        CGContextMoveToPoint(context, verticalPos.x, verticalPos.y);
        CGContextAddLineToPoint(context, verticalPos.x, verticalPos.y + cropSize.height);
        CGContextStrokePath(context);
        
        CGPoint horizontalPos = CGPointMake(leftTopPoint.x, leftTopPoint.y + i * cropSectionSize.height);
        CGContextMoveToPoint(context, horizontalPos.x, horizontalPos.y);
        CGContextAddLineToPoint(context, horizontalPos.x + cropSize.width, horizontalPos.y);
        CGContextStrokePath(context);
    }
    
}

- (void)drawRect:(CGRect)rect {
    // Drawing code
    [self drawShadow];
    [self drawLine];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch * touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    for(UIImageView *pointImageView in self.pointImageViewArray) {
        CGRect frame = pointImageView.frame;
        frame.origin.x -= frame.size.width / 2;
        frame.origin.y -= frame.size.height / 2;
        frame.size.width *= 2;
        frame.size.height *= 2;
        if(CGRectContainsPoint(frame, point)) {
            _draggingPointImageView = pointImageView;
            break;
        }
    }
    _formerTouchPoint = point;
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch * touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    CGFloat distanceX = point.x - _formerTouchPoint.x;
    CGFloat distanceY = point.y - _formerTouchPoint.y;
    _formerTouchPoint = point;
    
    if(_draggingPointImageView) {        
        CGFloat distance = fabsf(distanceX) > fabsf(distanceY) ? fabsf(distanceX) : fabsf(distanceY);
        distanceX = distanceY > 0 ? distance : distance * -1;
        distanceY = distanceX;
        PointPositionIdentifier pointIdentifier = [self.pointImageViewArray indexOfObject:_draggingPointImageView];
        if(pointIdentifier % 2 == 1)
            distanceX *= -1;
        
        CGPoint center = _draggingPointImageView.center;
        if(center.x + distanceX < _minimumXArray[pointIdentifier])
            distanceX = _minimumXArray[pointIdentifier] - center.x;
        else if(center.x + distanceX > _maximumXArray[pointIdentifier])
            distanceX = _maximumXArray[pointIdentifier] - center.x;
        if(center.y + distanceY < _minimumYArray[pointIdentifier])
            distanceY = _minimumYArray[pointIdentifier] - center.y;
        else if(center.y + distanceY > _maximumYArray[pointIdentifier])
            distanceY = _maximumYArray[pointIdentifier] - center.y;
        
        distance = fabsf(distanceX) < fabsf(distanceY) ? fabsf(distanceX) : fabsf(distanceY);
        distanceX = distanceY > 0 ? distance : distance * -1;
        distanceY = distanceX;
        if(pointIdentifier % 2 == 1)
            distanceX *= -1;
        
        center.x += distanceX;
        center.y += distanceY;
        _draggingPointImageView.center = center;
        
        PointPositionIdentifier oppositePointIdentifier = (pointIdentifier + 2) % 4;
        UIImageView *oppositePointImageView = [self.pointImageViewArray objectAtIndex:oppositePointIdentifier];
        
        if((oppositePointImageView.center.x - _draggingPointImageView.center.x) * (oppositePointIdentifier % 3 ? 1 : -1) < MINIMUM_INTERVAL
           || (oppositePointImageView.center.y - _draggingPointImageView.center.y) * (oppositePointIdentifier > 1 ? 1 : -1) < MINIMUM_INTERVAL) {
            center.x -= distanceX;
            center.y -= distanceY;
            _draggingPointImageView.center = center;
            
        } else {
            UIImageView *pointWithSameX = [self pointImageViewWithIdentifier:(pointIdentifier + 1) % 4];
            UIImageView *pointWithSameY = [self pointImageViewWithIdentifier:(pointIdentifier + 3) % 4];
            if(pointIdentifier % 2 == 0) {
                UIImageView *temp = pointWithSameX;
                pointWithSameX = pointWithSameY;
                pointWithSameY = temp;
            }
            pointWithSameX.center = CGPointMake(_draggingPointImageView.center.x, pointWithSameX.center.y);
            pointWithSameY.center = CGPointMake(pointWithSameY.center.x, _draggingPointImageView.center.y);
        }
    }
    else {
        CGPoint leftTop = [self pointImageViewWithIdentifier:PointPositionLeftTop].center;
        CGPoint rightBottom = [self pointImageViewWithIdentifier:PointPositionRightBottom].center;
        if(leftTop.x + distanceX < _minimumXArray[PointPositionLeftTop])
            distanceX = _minimumXArray[PointPositionLeftTop] - leftTop.x;
        if(rightBottom.x + distanceX > _maximumXArray[PointPositionRightBottom])
            distanceX = _maximumXArray[PointPositionRightBottom] - rightBottom.x;
        if(leftTop.y + distanceY < _minimumYArray[PointPositionLeftTop])
            distanceY = _minimumYArray[PointPositionLeftTop] - leftTop.y;
        if(rightBottom.y + distanceY > _maximumYArray[PointPositionRightBottom])
            distanceY = _maximumYArray[PointPositionRightBottom] - rightBottom.y;
        
        for(UIImageView *pointImageView in self.pointImageViewArray) {
            CGPoint center = pointImageView.center;
            center.x += distanceX;
            center.y += distanceY;
            pointImageView.center = center;
        }
    }
    [self setNeedsDisplay];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    _draggingPointImageView = nil;
}

- (void)setCropImageInitSize:(CGSize)size center:(CGPoint)center {
    _cropImageInitSize = size;
    _cropImageInitCenter = center;
    [self setDefault];
}

- (CGRect)cropImageRect {
    CGPoint leftTop = [self pointImageViewWithIdentifier:PointPositionLeftTop].center;
    CGPoint rightBottom = [self pointImageViewWithIdentifier:PointPositionRightBottom].center;
    CGSize size = CGSizeMake(rightBottom.x - leftTop.x, rightBottom.y - leftTop.y);
    CGPoint origin = CGPointMake(leftTop.x - _minimumXArray[PointPositionLeftTop], leftTop.y - _minimumYArray[PointPositionLeftTop]);
    CGRect rect = CGRectMake(origin.x, origin.y, size.width, size.height);
    return rect;
}

- (CGRect)cropEditRect {
    CGPoint leftTop = [self pointImageViewWithIdentifier:PointPositionLeftTop].center;
    CGPoint rightBottom = [self pointImageViewWithIdentifier:PointPositionRightBottom].center;
    CGSize size = CGSizeMake(rightBottom.x - leftTop.x, rightBottom.y - leftTop.y);
    CGPoint origin = CGPointMake(leftTop.x, leftTop.y);
    CGRect rect = CGRectMake(origin.x, origin.y, size.width, size.height);
    return rect;
}

@end
