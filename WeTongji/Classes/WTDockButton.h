//
//  WTDockButton.h
//  WeTongji
//
//  Created by 紫川 王 on 12-4-12.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WTButton.h"

@interface WTDockButton : WTButton

@property (strong, nonatomic) UILabel *titleLabel;

- (id)initWithImage:(UIImage *)image highlightedImage:(UIImage *)highlightedImage title:(NSString *)title;

@end
