//
//  ScheduleMonthViewController.h
//  WeTongji
//
//  Created by 紫川 王 on 12-5-12.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ScheduleMonthViewController : UIViewController

@property (nonatomic, strong) NSDate *currentDate;

@property CFGregorianDate currentSelectDate;
@property CFGregorianDate lastMonth;

@property (nonatomic, strong) IBOutlet UILabel *headTitle;

- (IBAction)movePrev:(UIButton *)sender;
- (IBAction)moveNext:(UIButton *)sender;

@end
