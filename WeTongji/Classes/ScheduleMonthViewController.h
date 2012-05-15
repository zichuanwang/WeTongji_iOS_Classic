//
//  ScheduleMonthViewController.h
//  WeTongji
//
//  Created by 紫川 王 on 12-5-12.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ScheduleMonthViewController : UIViewController

@property CFGregorianDate currentMonthDate;
@property CFGregorianDate currentSelectDate;
@property CFAbsoluteTime  currentTime;

@property (nonatomic, strong) IBOutlet UILabel *headTitle;

@end
