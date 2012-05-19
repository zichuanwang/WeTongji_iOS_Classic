//
//  ScheduleWeekViewController.m
//  WeTongji
//
//  Created by 紫川 王 on 12-5-12.
//  Copyright (c) 2012年 Tongji Apple Club. All rights reserved.
//

#import "ScheduleWeekViewController.h"
#import "ScheduleWeekRightTableViewCell.h"
#import "ScheduleWeekLeftTableViewCell.h"
#import "NSUserDefaults+Addition.h"

#define BEGIN_TIME  7
#define END_TIME    22

@interface ScheduleWeekViewController ()

@end

@implementation ScheduleWeekViewController

@synthesize leftTableView = _leftTableView;
@synthesize rightTableView = _rightTableView;

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
    [self configureRightTableView];
    [self configureView];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    self.leftTableView = nil;
    self.rightTableView = nil;
}

#pragma mark -
#pragma mark UI methods

- (void)configureView {
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"paper_wide_main"]];
}

- (void)configureRightTableView {
    CGRect frame =  self.rightTableView.frame;
    self.rightTableView.transform = CGAffineTransformMakeRotation(-M_PI_2);
    frame.size.width = self.rightTableView.frame.size.height;
    frame.size.height = self.rightTableView.frame.size.width;
    NSLog(@"frame origin:%f, %f", frame.origin.x, frame.origin.y);
    self.rightTableView.frame = frame;
    self.rightTableView.contentInset = UIEdgeInsetsMake(65.0f, 0, 0, 0);
}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath{
    if([cell isKindOfClass:[ScheduleWeekLeftTableViewCell class]]) {
        NSInteger hour = indexPath.row + BEGIN_TIME;
        NSString *hourString = nil;
        if(hour < 10)
            hourString = [NSString stringWithFormat:@"0%d:00", hour];
        else
            hourString = [NSString stringWithFormat:@"%d:00", hour];
        ScheduleWeekLeftTableViewCell *leftCell = (ScheduleWeekLeftTableViewCell *)cell;
        leftCell.hourLabel.text = hourString;
    } else {
        
    }
}

#pragma mark -
#pragma mark UITableView data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(tableView == self.rightTableView) {
        NSDate *begin = [NSUserDefaults getCurrentSemesterBeginDate];
        NSDate *end = [NSUserDefaults getCurrentSemesterEndDate];
        return 100;
    } else {
        return END_TIME - BEGIN_TIME + 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellIdentifier = nil;
    if(tableView == self.rightTableView)
        cellIdentifier = @"ScheduleWeekRightTableViewCell";
    else 
        cellIdentifier = @"ScheduleWeekLeftTableViewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:cellIdentifier owner:self options:nil];
    cell = [nib objectAtIndex:0];
    
    [self configureCell:cell atIndexPath:indexPath];
    return cell;
}

@end
