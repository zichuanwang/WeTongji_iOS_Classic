//
//  DayScheduleViewController.h
//  WeTongji
//
//  Created by M.K.Rain on 12-4-26.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DayScheduleViewController : UIViewController

@property (nonatomic, strong) NSMutableArray *datesIndexArray;
@property (nonatomic, strong) NSMutableDictionary *dateSourceDictionary;

//@property (nonatomic, strong) IBOutlet UILabel *currentDateLabel;
//- (IBAction)didClickPreviousDay:(id)sender;
//- (IBAction)didClickNextDay:(id)sender;

- (void)moveToToday;

@end
