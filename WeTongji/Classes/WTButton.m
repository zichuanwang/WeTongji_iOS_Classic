//
//  WTButton.m
//  WeTongji
//
//  Created by 紫川 王 on 12-4-10.
//  Copyright (c) 2012年 Tongji Apple Club. All rights reserved.
//

#import "WTButton.h"
#import "UIView+Addition.h"

@interface WTButton()

@end

@implementation WTButton

@synthesize highlightedImageView = _highlightedImageView;

- (void)awakeFromNib {
    CGRect frame = self.frame;
    frame.origin = CGPointMake(0, 0);
    
    self.showsTouchWhenHighlighted = NO;
    self.adjustsImageWhenHighlighted = NO;
    
    self.highlightedImageView = [[UIImageView alloc] initWithFrame:frame];
    self.highlightedImageView.alpha = 0;
    [self addSubview:self.highlightedImageView];
}

- (void)setHighlighted:(BOOL)highlighted {
    if(self.highlighted && !highlighted) {
        [self.highlightedImageView fadeOut];
    }
    else if(!self.highlighted && highlighted) {
        self.highlightedImageView.alpha = 1;
    }
    if(self.selected)
        self.highlightedImageView.alpha = 1;
    [super setHighlighted:highlighted];
}

- (void)setSelected:(BOOL)selected {
    if(selected)
        self.highlightedImageView.alpha = 1;
    else if(self.selected == YES && !selected)
        [self.highlightedImageView fadeOut];
    else
        self.highlightedImageView.alpha = 0;
    
    [super setSelected:selected];
}

@end
