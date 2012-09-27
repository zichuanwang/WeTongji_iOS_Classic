//
//  RookieGuideViewController.h
//  WeTongji
//
//  Created by Ziqi on 12-9-11.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WTNavigationViewController.h"

@interface RookieGuideViewController : WTNavigationViewController

@property (weak, nonatomic) IBOutlet UIButton *startButton;

- (IBAction)seeDetail:(id)sender;

@end
