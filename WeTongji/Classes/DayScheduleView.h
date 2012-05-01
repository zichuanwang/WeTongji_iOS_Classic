//
//  DayScheduleView.h
//  WeTongji
//
//  Created by M.K.Rain on 12-4-30.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DayScheduleView : UIView{
	CFGregorianDate currentMonthDate;
	CFGregorianDate currentSelectDate;
	CFAbsoluteTime	currentTime;
}

@property CFGregorianDate currentMonthDate;
@property CFGregorianDate currentSelectDate;
@property CFAbsoluteTime  currentTime;

@property (nonatomic, strong) UIScrollView *sv;

@end
