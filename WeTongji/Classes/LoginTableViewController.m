//
//  LoginTableViewController.m
//  WeTongji
//
//  Created by 紫川 王 on 12-4-17.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "LoginTableViewController.h"
#import "LoginTableViewCell.h"

@interface LoginTableViewController ()

@property (strong, nonatomic) NSMutableArray *userListArray;

@end

@implementation LoginTableViewController

@synthesize tableView = _tableView;
@synthesize userListArray = _userListArray;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.userListArray = [[NSMutableArray alloc] initWithCapacity:10];
        [self.userListArray addObject:[NSString stringWithFormat:@"王紫川"]];
        [self.userListArray addObject:[NSString stringWithFormat:@"王紫川"]];
        [self.userListArray addObject:[NSString stringWithFormat:@"王紫川"]];
        [self.userListArray addObject:[NSString stringWithFormat:@"王紫川"]];
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
    NSInteger count = self.userListArray.count + 1;
    return count >= 3 ? count : 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {    
    NSString *CellIdentifier = @"LoginTableViewCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:CellIdentifier owner:self options:nil];
        cell = [nib lastObject];
    }
    
    if(indexPath.row == _selectRow) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    else {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    LoginTableViewCell *loginCell = (LoginTableViewCell *)cell;
    if(indexPath.row < self.userListArray.count) {
        loginCell.userNameLabel.text = [self.userListArray objectAtIndex:indexPath.row];
        loginCell.avatarImageView.hidden = NO;
        loginCell.avatarImageView.image = [UIImage imageNamed:@"user_info_default_image.jpg"];
    }
    else if(indexPath.row == self.userListArray.count) {
        loginCell.avatarImageView.image = [UIImage imageNamed:@"login_add_user.png"];
        loginCell.userNameLabel.text = @"添加一个新的账户";
    }
    return cell;
}

#pragma mark -
#pragma mark UITableView delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 40;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.row < self.userListArray.count) {
        _selectRow = indexPath.row;
        [self.tableView reloadData];
    }
    else if(indexPath.row == self.userListArray.count) {
        
    }
}

@end
