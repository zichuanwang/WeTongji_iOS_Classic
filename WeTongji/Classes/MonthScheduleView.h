//
//  MonthScheduleView.h
//  WeTongji
//
//  Created by M.K.Rain on 12-5-15.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//
//

#import <UIKit/UIKit.h>

@class MonthEventTableViewController;

@interface MonthScheduleView : UIView {
	CFGregorianDate currentMonthDate;
	CFGregorianDate currentSelectDate;
	CFAbsoluteTime	currentTime;
	UIImageView* viewImageView;
	int *monthFlagArray; 
}

@property CFGregorianDate currentMonthDate;
@property CFGregorianDate currentSelectDate;
@property CFAbsoluteTime  currentTime;

@property (nonatomic, retain) UIImageView* viewImageView;
@property (nonatomic, retain) MonthEventTableViewController *eventViewController;
-(int)getDayCountOfaMonth:(CFGregorianDate)date;
-(int)getMonthWeekday:(CFGregorianDate)date;
-(int)getDayFlag:(int)day;
-(void)setDayFlag:(int)day flag:(int)flag;
-(void)clearAllDayFlag;
@end
