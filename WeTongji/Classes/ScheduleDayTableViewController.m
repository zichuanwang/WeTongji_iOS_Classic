//
//  ScheduleDayTableViewController.m
//  WeTongji
//
//  Created by 紫川 王 on 12-5-12.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ScheduleDayTableViewController.h"
#import "WTTableViewHeaderFooterFactory.h"
#import "ScheduleDayTableViewCell.h"
#import "Activity+Addition.h"
#import "NSString+Addition.h"

@interface ScheduleDayTableViewController ()

@end

@implementation ScheduleDayTableViewController

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
    [self configureTableViewHeaderFooter];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

#pragma mark -
#pragma mark UI methods

- (void)configureTableViewFooter {
    if(self.numberOfRowsInFirstSection == 0) {
        self.tableView.tableFooterView = [WTTableViewHeaderFooterFactory getWideWTTableViewFooterWithNoDataHint];
    }
    else {
        self.tableView.tableFooterView = [WTTableViewHeaderFooterFactory getWideWTTableViewEmptyFooter];
    }
}

- (void)configureTableViewHeader {
    UIView *headerView = [WTTableViewHeaderFooterFactory getWideWTTableViewHeader];
    self.tableView.tableHeaderView = headerView;
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

- (NSString *)customSectionNameKeyPath {
    return @"begin_day";
}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    Activity *activity = [self.fetchedResultsController objectAtIndexPath:indexPath];
    ScheduleDayTableViewCell *dayCell = (ScheduleDayTableViewCell *)cell;
    dayCell.whatLabel.text = activity.title;
    dayCell.whenLabel.text = [NSString timeConvertFromDate:activity.begin_time];
    dayCell.whereLabel.text = activity.location;
}

- (void)configureRequest:(NSFetchRequest *)request
{
    [request setEntity:[NSEntityDescription entityForName:@"Activity" inManagedObjectContext:self.managedObjectContext]];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF IN %@", self.currentUser.schedule];
    [request setPredicate:predicate];
    NSSortDescriptor *sort = [[NSSortDescriptor alloc] initWithKey:@"begin_time" ascending:YES];
    NSArray *descriptors = [NSArray arrayWithObjects:sort, nil];
    [request setSortDescriptors:descriptors];
    request.fetchBatchSize = 20;
}

- (void)insertCellAtIndexPath:(NSIndexPath *)indexPath {
    [super insertCellAtIndexPath:indexPath];
    [self configureTableViewFooter];
}

#pragma mark -
#pragma mark UITableView delegates

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, 22)];
    headerView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"paper_wide_main"]];
    
    NSString *section_name = [[[self.fetchedResultsController sections] objectAtIndex:section] name];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 320, 22)];
    label.text = section_name;
    label.font = [UIFont boldSystemFontOfSize:14.0f];
    label.textColor = [UIColor colorWithRed:0.1f green:0.1f blue:0.1f alpha:1];
    label.shadowColor = [UIColor whiteColor];
    label.shadowOffset = CGSizeMake(0, 1.0f);
    label.backgroundColor = [UIColor clearColor];
    
    UIImageView *singleLine = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"paper_wide_single_line"]];
    singleLine.center = CGPointMake(singleLine.frame.size.width / 2, 2);
    
    [headerView addSubview:label];
    [headerView addSubview:singleLine];
    return headerView;
}

@end
