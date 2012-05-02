//
//  DayScheduleViewController.h
//  WeTongji
//
//  Created by M.K.Rain on 12-4-26.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DayScheduleView;

@interface DayScheduleViewController : UIViewController

@property (nonatomic, strong) IBOutlet DayScheduleView *dayScheduleView;

- (void)moveToToday;

@end
