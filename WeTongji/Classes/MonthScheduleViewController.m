//
//  MonthScheduleViewController.m
//  WeTongji
//
//  Created by M.K.Rain on 12-4-29.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "MonthScheduleViewController.h"
#import "MonthScheduleView.h"

@interface MonthScheduleViewController ()


@end

@implementation MonthScheduleViewController

@synthesize datesIndexArray = _datesIndexArray;
@synthesize dateSourceDictionary = _dateSourceDictionary;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)moveToToday{
    
}

@end
