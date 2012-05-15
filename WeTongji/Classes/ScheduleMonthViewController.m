//
//  ScheduleMonthViewController.m
//  WeTongji
//
//  Created by 紫川 王 on 12-5-12.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ScheduleMonthViewController.h"
#import "ScheduleMonthDateViewCell.h"

@interface ScheduleMonthViewController ()

@property (nonatomic, strong) IBOutlet UIView *scheduleMonthHeadView;
@property (nonatomic, strong) IBOutlet UIView *scheduleMonthDateView;
@property (nonatomic, strong) IBOutlet UIView *scheduleMonthEventView;

@end

@implementation ScheduleMonthViewController

@synthesize currentMonthDate = _currentMonthDate;
@synthesize currentSelectDate = _currentSelectDate;
@synthesize currentTime = _currentTime;

@synthesize scheduleMonthDateView = _scheduleMonthDateView;
@synthesize scheduleMonthHeadView = _scheduleMonthHeadView;
@synthesize scheduleMonthEventView = _scheduleMonthEventView;
@synthesize headTitle = _headTitle;

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
    [self configureHeadView];
//    [self configureDateView];
    [self configureEventView];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)configureHeadView{
    self.currentTime=CFAbsoluteTimeGetCurrent();
    self.currentMonthDate=CFAbsoluteTimeGetGregorianDate(self.currentTime,CFTimeZoneCopyDefault());
    //self.currentMonthDate.day = 1;
	NSString *title_Month   = [[NSString alloc] initWithFormat:@"%d年%d月",self.currentMonthDate.year,self.currentMonthDate.month];
    self.headTitle.text = title_Month;
}

- (void)configureDateView{
    for(int i=0;i<7;i++){
        for (int j=0; j<[self getLineNumberOfMonth:self.currentMonthDate]; j++) {
            ScheduleMonthDateViewCell *tmpCell = [[ScheduleMonthDateViewCell alloc] initWithFrame:CGRectMake(i*46, j*46, 46, 46)];
            [self.scheduleMonthDateView addSubview:tmpCell];
        }
    }
}

- (void)configureEventView{
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark
#pragma mark -- Logic methods
- (int)getDayCountOfaMonth:(CFGregorianDate)date{
	switch (date.month) {
		case 1:
		case 3:
		case 5:
		case 7:
		case 8:
		case 10:
		case 12:
			return 31;
		case 2:
			if(date.year%4==0 && date.year%100!=0)
				return 29;
			else
				return 28;
		case 4:
		case 6:
		case 9:		
		case 11:
			return 30;
		default:
			return 31;
	}
}

- (int)getLineNumberOfMonth:(CFGregorianDate)date{
    int row_count = 0;
    if ([self getMonthWeekday:self.currentMonthDate] != 7) {
        row_count = ([self getDayCountOfaMonth:self.currentMonthDate]+[self getMonthWeekday:self.currentMonthDate]-1)/7+1;
    }else {
        row_count = ([self getDayCountOfaMonth:self.currentMonthDate])/7+1;
    }
    return row_count;
}

- (int)getMonthWeekday:(CFGregorianDate)date
{
	CFTimeZoneRef tz = CFTimeZoneCopyDefault();
	CFGregorianDate month_date;
	month_date.year=date.year;
	month_date.month=date.month;
	month_date.day=1;
	month_date.hour=0;
	month_date.minute=0;
	month_date.second=1;
	return (int)CFAbsoluteTimeGetDayOfWeek(CFGregorianDateGetAbsoluteTime(month_date,tz),tz);
}

@end
