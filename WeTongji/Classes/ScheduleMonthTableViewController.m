//
//  ScheduleMonthTableViewController.m
//  WeTongji
//
//  Created by 紫川 王 on 12-5-17.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ScheduleMonthTableViewController.h"
#import "ScheduleDayTableViewCell.h"
#import "NSString+Addition.h"
#import "WTTableViewHeaderFooterFactory.h"
#import "ScheduleDayTableViewController.h"

@interface ScheduleMonthTableViewController ()

@end

@implementation ScheduleMonthTableViewController

@synthesize selectedDate = _selectedDate;
@synthesize delegate = _delegate;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.selectedDate = [NSDate date];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self configureTableViewHeaderFooter];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

#pragma mark -
#pragma mark Custom setter & getter

- (void)setSelectedDate:(NSDate *)selectedDate {
    _selectedDate = selectedDate;
    self.fetchedResultsController = nil;
    [self.fetchedResultsController performFetch:NULL];
    [self.tableView reloadData];
    [self configureTableViewFooter];
}

#pragma mark -
#pragma mark UI methods

- (void)configureTableViewFooter {
    if(self.numberOfRowsInFirstSection == 0) {
        self.tableView.tableFooterView = [WTTableViewHeaderFooterFactory getWideWTTableViewFooterWithHint:@"无日程安排。"];
    }
    else {
        self.tableView.tableFooterView = [WTTableViewHeaderFooterFactory getWideWTTableViewEmptyFooter];
    }
}

- (void)configureTableViewHeader {
    UIView *headerView = [WTTableViewHeaderFooterFactory getWideWTTableViewHeader];
    self.tableView.tableHeaderView = headerView;
    self.tableView.contentInset = UIEdgeInsetsMake(-headerView.frame.size.height, 0.0f, 0.0f, 0.0f);
}

- (void)configureTableViewHeaderFooter {
    [self configureTableViewHeader];
    [self configureTableViewFooter];
}

#pragma mark -
#pragma mark CoreDataTableViewController methods to overwrite

- (NSString *)customCellClassName {
    return @"ScheduleDayTableViewCell";
}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    Event *event = [self.fetchedResultsController objectAtIndexPath:indexPath];
    ScheduleDayTableViewCell *dayCell = (ScheduleDayTableViewCell *)cell;
    [dayCell configureCell:event];
}

- (void)configureRequest:(NSFetchRequest *)request
{
    [request setEntity:[NSEntityDescription entityForName:@"Event" inManagedObjectContext:self.managedObjectContext]];
    NSPredicate *ownerPredicate = [NSPredicate predicateWithFormat:@"SELF IN %@", self.currentUser.schedule];
    NSPredicate *dayPredicate = [NSPredicate predicateWithFormat:@"begin_day == %@", [NSString yearMonthDayWeekConvertFromDate:self.selectedDate]];
    [request setPredicate:[NSCompoundPredicate andPredicateWithSubpredicates:[NSArray arrayWithObjects:ownerPredicate, dayPredicate, nil]]];
    NSSortDescriptor *sort = [[NSSortDescriptor alloc] initWithKey:@"begin_time" ascending:YES];
    NSArray *descriptors = [NSArray arrayWithObjects:sort, nil];
    [request setSortDescriptors:descriptors];
    request.fetchBatchSize = 20;
}

#pragma mark -
#pragma mark UITableView delegates

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    Event *event = [self.fetchedResultsController objectAtIndexPath:indexPath];
    [self.delegate scheduleDayTableViewDidSelectEvent:event];
}


@end
