//
//  ChannelOutlineTableViewController.m
//  WeTongji
//
//  Created by 紫川 王 on 12-4-23.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ChannelOutlineTableViewController.h"
#import "ChannelOutlineTableViewCell.h"
#import "WTClient.h"
#import "Activity+Addition.h"
#import "NSString+Addition.h"
#import "NSUserDefaults+Addition.h"

@interface ChannelOutlineTableViewController ()

@end

@implementation ChannelOutlineTableViewController

@synthesize delegate = _delegate;

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
    [self loadMoreData];
    
    NSLog(@"section count:%d", self.fetchedResultsController.sections.count);
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)setTableFooterViewStyle:(NSInteger)style {
    if(style == 0) {
        UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 70)];
        UIImageView *footerImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"paper_wide_footer.png"]];
        footerImageView.center = CGPointMake(160, 60);
        UIImageView *mainImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"paper_wide_main.png"]];
        mainImageView.center = CGPointMake(160, 20);
        UIImageView *lineImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"paper_wide_single_line.png"]];
        lineImageView.center = CGPointMake(160, 20);
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 40)];
        label.backgroundColor = [UIColor clearColor];
        label.font = [UIFont boldSystemFontOfSize:14.0f];
        label.textColor = [UIColor colorWithRed:0.2f green:0.2f blue:0.2f alpha:1];
        label.shadowColor = [UIColor whiteColor];
        label.shadowOffset = CGSizeMake(0, 1);
        label.text = @"无内容。";
        label.textAlignment = UITextAlignmentCenter;
        [mainImageView addSubview:label];
        
        [footerView addSubview:footerImageView];
        [footerView addSubview:mainImageView];
        [footerView addSubview:lineImageView];
        self.tableView.tableFooterView = footerView;
    }
    else if(style == 1) {
        UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 30)];
        UIImageView *footerImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"paper_wide_footer.png"]];
        footerImageView.center = CGPointMake(160, 20);
        [footerView addSubview:footerImageView];
        self.tableView.tableFooterView = footerView;

    }
}

- (void)configureTableViewFooter {
    if(self.numberOfRowsInFirstSection == 0) {
        [self setTableFooterViewStyle:0];
    }
    else {
        [self setTableFooterViewStyle:1];
    }
}

- (void)configureTableViewHeader {
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 30)];
    UIImageView *headerImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"paper_wide_header.png"]];
    headerImageView.center = CGPointMake(160, 10);
    UIImageView *lineImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"paper_wide_single_line.png"]];
    lineImageView.center = CGPointMake(160, 10);
    lineImageView.center = headerImageView.center;
    [headerView addSubview:headerImageView];
    [headerView addSubview:lineImageView];
    self.tableView.tableHeaderView = headerView;
}

- (void)configureTableViewHeaderFooter {
    [self configureTableViewHeader];
    [self configureTableViewFooter];
}

#pragma mark -
#pragma mark UITableView delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    Activity *activity = [self.fetchedResultsController objectAtIndexPath:indexPath];
    [self.delegate channelOutlineTableViewDidSelectActivity:activity];
}

#pragma mark -
#pragma mark EGO methods

- (void)loadMoreData {
    WTClient *client = [WTClient client];
    [client setCompletionBlock:^(WTClient *client) {
        if(!client.hasError) {
            NSDictionary *dict = client.responseJSONObject;
            NSDictionary *data = [dict objectForKey:@"Data"];
            NSArray *array = [data objectForKey:@"Activities"];
            for(NSDictionary *activityDict in array) {
                [Activity insertActivity:activityDict inManagedObjectContext:self.managedObjectContext];
            }
        }
    }];
    [client getActivitesWithChannelIds:[NSUserDefaults getChannelFollowStatusString] page:1];
}

#pragma mark -
#pragma mark CoreDataTableViewController methods to overwrite

- (NSString *)customCellClassName {
    return @"ChannelOutlineTableViewCell";
}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    if([cell isMemberOfClass:[ChannelOutlineTableViewCell class]]) {
        ChannelOutlineTableViewCell *outlineCell = (ChannelOutlineTableViewCell *)cell;
        Activity *activity = [self.fetchedResultsController objectAtIndexPath:indexPath];
        outlineCell.titleLabel.text = activity.title;
        outlineCell.locationLabel.text = activity.location;
        outlineCell.timeLabel.text = [NSString timeConvertFromBeginDate:activity.begin_time endDate:activity.end_time];
    }
}

- (void)configureRequest:(NSFetchRequest *)request
{
    [request setEntity:[NSEntityDescription entityForName:@"Activity" inManagedObjectContext:self.managedObjectContext]];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"channel_id IN %@", [NSUserDefaults getFollowedChannelArray]];
    [request setPredicate:predicate];
    NSSortDescriptor *sort = nil;
    ChannelSortMethod methodCode = [NSUserDefaults getChannelSortMethod];
    if(methodCode == ChannelSortByLikeCount)
        sort = [[NSSortDescriptor alloc] initWithKey:@"like_count" ascending:NO];
    else 
        sort = [[NSSortDescriptor alloc] initWithKey:@"begin_time" ascending:YES];
    
    NSArray *descriptors = [NSArray arrayWithObject:sort];
    [request setSortDescriptors:descriptors]; 
    request.fetchBatchSize = 20;
}

- (void)insertCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    [self configureTableViewFooter];
}

@end
