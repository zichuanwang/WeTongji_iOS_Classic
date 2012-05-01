//
//  MonthScheduleViewController.h
//  WeTongji
//
//  Created by M.K.Rain on 12-4-29.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MonthScheduleViewController : UIViewController

@property (nonatomic, strong) NSMutableArray *datesIndexArray;
@property (nonatomic, strong) NSMutableDictionary *dateSourceDictionary;

- (void)moveToToday;

@end
