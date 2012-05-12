//
//  ScheduleDayTableViewController.m
//  WeTongji
//
//  Created by 紫川 王 on 12-5-12.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ScheduleDayTableViewController.h"
#import "WTTableViewHeaderFooterFactory.h"

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
        self.tableView.tableFooterView = [WTTableViewHeaderFooterFactory getWideWTTableViewEmptyFooterWithHint];
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

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
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

@end
