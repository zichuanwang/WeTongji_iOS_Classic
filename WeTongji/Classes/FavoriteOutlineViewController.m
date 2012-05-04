//
//  FavoriteOutlineViewController.m
//  WeTongji
//
//  Created by 紫川 王 on 12-5-4.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "FavoriteOutlineViewController.h"

@interface FavoriteOutlineViewController ()

@end

@implementation FavoriteOutlineViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:@"ChannelOutlineTableViewController" bundle:nil];;
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

#pragma mark -
#pragma mark CoreDataTableViewController methods to overwrite

- (void)configureRequest:(NSFetchRequest *)request
{
    [request setEntity:[NSEntityDescription entityForName:@"Activity" inManagedObjectContext:self.managedObjectContext]];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF IN %@", self.currentUser.favor];
    [request setPredicate:predicate];
    NSSortDescriptor *sortByBegin = [[NSSortDescriptor alloc] initWithKey:@"begin_time" ascending:NO];
    
    NSArray *descriptors = [NSArray arrayWithObjects:sortByBegin, nil];
    [request setSortDescriptors:descriptors]; 
    request.fetchBatchSize = 20;
}

#pragma mark -
#pragma mark EGORefresh Method

- (void)refresh {
    //[self hideLoadMoreDataButton];
    [self loadMoreData];
}

- (void)clearData
{
    
}

- (void)loadMoreData {
//    WTClient *client = [WTClient client];
//    [client setCompletionBlock:^(WTClient *client) {
//        if(!client.hasError) {
//            NSDictionary *dict = client.responseJSONObject;
//            NSDictionary *data = [dict objectForKey:@"Data"];
//            NSArray *array = [data objectForKey:@"Activities"];
//            for(NSDictionary *activityDict in array) {
//                [Activity insertActivity:activityDict inManagedObjectContext:self.managedObjectContext];
//            }
//        }
//        [self doneLoadingTableViewData];
//    }];
//    [client getActivitesWithChannelIds:[NSUserDefaults getChannelFollowStatusString] page:1];
}

@end
