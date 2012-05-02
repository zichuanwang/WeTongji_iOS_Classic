//
//  DayScheduleView.h
//  WeTongji
//
//  Created by M.K.Rain on 12-4-30.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class quartzView;

@interface DayScheduleView : UIView{
	CFGregorianDate currentMonthDate;
	CFGregorianDate currentSelectDate;
	CFAbsoluteTime	currentTime;
}

@property (nonatomic, strong) NSMutableArray *datesIndexArray;
@property (nonatomic, strong) NSMutableDictionary *dateSourceDictionary;

@property CFGregorianDate currentMonthDate;
@property CFGregorianDate currentSelectDate;
@property CFAbsoluteTime  currentTime;

@property CGRect firstRect;

@property (nonatomic, strong) UIScrollView *sv;
@property (nonatomic, strong) quartzView *currentView;
@property (nonatomic, strong) UIImageView* viewImageView;

- (void)drawCourses;
- (void)moveToToday;

@end
