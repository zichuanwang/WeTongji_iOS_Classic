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
#import "NSString+Addition.h"

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
    [self.rightTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:[self getTodayRowInRightTableView] inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:NO];
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
#pragma mark Logic methods 

- (NSInteger)getTodayRowInRightTableView {
    NSDate *today = [NSDate date];
    NSTimeInterval timeIntervalSinceSemesterBegin = [today timeIntervalSinceDate:[NSUserDefaults getCurrentSemesterBeginDate]];
    NSInteger todayRow = timeIntervalSinceSemesterBegin / 60 / 60 / 24;
    return todayRow;
}

#pragma mark -
#pragma mark UI methods

- (void)configureView {
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"paper_wide_main"]];
}

- (void)configureRightTableView {
    CGRect frame =  self.rightTableView.frame;
    self.rightTableView.transform = CGAffineTransformMakeRotation(-M_PI_2);
    frame.size.width = LEFT_TABLE_VIEW_ROW_COUNT * 30;
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
        NSInteger weekDay = (indexPath.row + 1) % 7 + 1;
        NSString *weekDayString = [NSString weekDayConvertFromInteger:weekDay];
        
        NSInteger week = indexPath.row / 7;
        if(weekDay == 2) {
            NSArray *weekStringArray = [NSArray arrayWithObjects:@"一", @"二", @"三", @"四", @"五", @"六", @"七", @"八", @"九", @"十", nil];
            NSString *weekString = nil;
            if(week < 10)
                weekString = [NSString stringWithFormat:@"第%@周", [weekStringArray objectAtIndex:week]];
            else {
                weekString = [NSString stringWithFormat:@"第十%@周", [weekStringArray objectAtIndex:week - 10]];
            }
            weekDayString = weekString;
        }
        
        ScheduleWeekRightTableViewCell *rightCell = (ScheduleWeekRightTableViewCell *)cell;
        rightCell.weekDayLabel.text = weekDayString;
        
        if([self getTodayRowInRightTableView] == indexPath.row)
            rightCell.weekDayLabel.textColor = [UIColor colorWithRed:0 green:0.37f blue:0.66f alpha:1];
        
        rightCell.contentVerticalOffset = self.leftTableView.contentOffset.y;
    }
}

#pragma mark -
#pragma mark UITableView data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(tableView == self.rightTableView) {
        NSDate *begin = [NSUserDefaults getCurrentSemesterBeginDate];
        NSDate *end = [NSUserDefaults getCurrentSemesterEndDate];
        NSTimeInterval timeInterval = [end timeIntervalSinceDate:begin]; 
        NSInteger result = timeInterval / 60 / 60 / 24;
        NSLog(@"right row:%d", result);
        return result;
    } else {
        return LEFT_TABLE_VIEW_ROW_COUNT;
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

#pragma mark -
#pragma mark IBActions

- (void)didClickTodayButton {
    [self.rightTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:[self getTodayRowInRightTableView] inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
}

#pragma mark -
#pragma mark UIScrollView delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if(scrollView == self.leftTableView) {
        for(ScheduleWeekRightTableViewCell *cell in self.rightTableView.visibleCells) {
            cell.contentVerticalOffset = self.leftTableView.contentOffset.y;
        }
    }
}

@end
