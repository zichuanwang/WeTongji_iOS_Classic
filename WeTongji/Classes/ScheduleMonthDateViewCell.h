//
//  ScheduleMonthDateViewCell.h
//  WeTongji
//
//  Created by M.K.Rain on 12-5-15.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ScheduleMonthDateViewCell : UIView

@property (nonatomic, strong) UILabel  *label;

- (void)setDay:(int)day;
- (void)setGray;

@end
