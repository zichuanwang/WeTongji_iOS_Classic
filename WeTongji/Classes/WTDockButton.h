//
//  WTDockButton.h
//  WeTongji
//
//  Created by 紫川 王 on 12-4-12.
//  Copyright (c) 2012年 Tongji Apple Club. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WTButton.h"

@interface WTDockButton : WTButton

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIImageView *buttonCoverImageView;

- (id)initWithImage:(UIImage *)image highlightedImage:(UIImage *)highlightedImage title:(NSString *)title;
- (void)configureUIStyle;

@end
