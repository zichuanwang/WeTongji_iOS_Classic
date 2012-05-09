//
//  CropImageView.h
//  VCard
//
//  Created by 紫川 王 on 12-4-18.
//  Copyright (c) 2012年 Mondev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CropImageView : UIView {
    UIImageView *_draggingPointImageView;
    CGPoint _formerTouchPoint;
    
    int _minimumXArray[4];
    int _minimumYArray[4];
    int _maximumXArray[4];
    int _maximumYArray[4];
    
    CGSize _cropImageInitSize;
    CGPoint _cropImageInitCenter;
}

@property (nonatomic, readonly) CGRect cropImageRect;
@property (nonatomic, readonly) CGRect cropEditRect;

- (void)setCropImageInitSize:(CGSize)size center:(CGPoint)center;

@end
