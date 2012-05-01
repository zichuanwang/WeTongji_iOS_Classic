//
//  ScheduleViewController.h
//  WeTongji
//
//  Created by 紫川 王 on 12-4-8.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WTNavigationViewController.h"

@interface ScheduleViewController : WTNavigationViewController

@property (nonatomic, strong) NSMutableArray *datesIndexArray;
@property (nonatomic, strong) NSMutableDictionary *dateSourceDictionary;
@property (nonatomic, strong) IBOutlet UIToolbar *toolBarView;
@property (nonatomic, strong) IBOutlet UIBarButtonItem *todayButton;
@property (nonatomic, strong) IBOutlet UISegmentedControl *segmentedControl;

- (IBAction)toggleControls:(id)sender;
- (IBAction)didClickTodayButton:(id)sender;

@end
