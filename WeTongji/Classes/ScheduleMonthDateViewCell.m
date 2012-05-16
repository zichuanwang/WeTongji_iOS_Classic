//
//  ScheduleMonthDateViewCell.m
//  WeTongji
//
//  Created by M.K.Rain on 12-5-15.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ScheduleMonthDateViewCell.h"

@implementation ScheduleMonthDateViewCell

@synthesize label = _label;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor whiteColor];
        
    }
    return self;
}

- (void)setDay:(int)day{
    self.label = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, 46, 10)];
    self.label.textAlignment = UITextAlignmentCenter;
    self.label.text = [NSString stringWithFormat:@"%d",day];
    [self addSubview:self.label];
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
