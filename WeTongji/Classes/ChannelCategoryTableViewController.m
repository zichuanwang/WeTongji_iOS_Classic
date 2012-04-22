//
//  ChannelCategoryTableViewController.m
//  WeTongji
//
//  Created by 紫川 王 on 12-4-23.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ChannelCategoryTableViewController.h"
#import "ChannelCategoryTableViewCell.h"

@interface ChannelCategoryTableViewController ()

@property (nonatomic, strong) NSMutableArray *categoryArray;

@end

@implementation ChannelCategoryTableViewController

@synthesize categoryArray = _categoryArray;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.categoryArray = [[NSMutableArray alloc] initWithObjects:@"学术讲座", @"文娱活动", @"赛事信息", @"企业招聘", nil];
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

#pragma mark -
#pragma mark UITableView data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.categoryArray.count + 2;
}

#pragma mark -
#pragma mark UITableView delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 40;
}

#pragma mark -
#pragma mark WTTableViewController methods to overwrite

- (NSString *)customCellClassNameAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.row == 0)
        return @"PaperHeaderTableViewCell";
    else if(indexPath.row == self.categoryArray.count + 1)
        return @"PaperFooterTableViewCell";
    else 
        return @"ChannelCategoryTableViewCell";
}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    //cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    if([cell isMemberOfClass:[ChannelCategoryTableViewCell class]]) {
        ChannelCategoryTableViewCell *categoryCell = (ChannelCategoryTableViewCell *)cell;
        categoryCell.categoryLabel.text = [self.categoryArray objectAtIndex:indexPath.row - 1];
    }
}

@end
