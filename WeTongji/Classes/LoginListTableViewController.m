//
//  LoginListTableViewController.m
//  WeTongji
//
//  Created by 紫川 王 on 12-4-17.
//  Copyright (c) 2012年 Tongji Apple Club. All rights reserved.
//

#import "LoginListTableViewController.h"
#import "LoginListTableViewCell.h"
#import "LoginViewController.h"
#import "UIApplication+Addition.h"
#import "User+Addition.h"
#import "NSNotificationCenter+Addition.h"

#define TABLE_HEADER_FOOTER_CELL_NUM    7

@interface LoginListTableViewController ()

@property (nonatomic, strong) UIView *tableViewHeaderView;
@property (nonatomic, strong) UIView *tableViewFooterView;

@end

@implementation LoginListTableViewController

@synthesize tableView = _tableView;
@synthesize tableViewFooterView = _tableViewFooterView;
@synthesize tableViewHeaderView = _tableViewHeaderView;
@synthesize mainBgView = _mainBgView;

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
    [self configureTableView];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    self.mainBgView = nil;
}

#pragma mark -
#pragma mark logic methods

#pragma mark -
#pragma mark UI methods

- (void)configureTableView{
    self.tableViewHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, -40 * TABLE_HEADER_FOOTER_CELL_NUM, 300, 40 * TABLE_HEADER_FOOTER_CELL_NUM)];
    self.tableViewFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, self.numberOfRowsInFirstSection * 40, 300, 40 * TABLE_HEADER_FOOTER_CELL_NUM)];
    for(int i = 0; i < TABLE_HEADER_FOOTER_CELL_NUM; i++) {
        UIImageView *headerView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"paper_single_line.png"]];
        UIImageView *footerView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"paper_single_line.png"]];
        headerView.frame = CGRectMake(-10, 40 * i, 320, 40);
        footerView.frame = headerView.frame;
        [self.tableViewHeaderView addSubview:headerView];
        [self.tableViewFooterView addSubview:footerView];
    }
    
    [self.tableView addSubview:self.tableViewHeaderView];
    [self.tableView addSubview:self.tableViewFooterView];
    
    self.tableViewHeaderView.userInteractionEnabled = NO;
    self.tableViewFooterView.userInteractionEnabled = NO;
    
    UIButton *newAccountButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 300, 40)];
    newAccountButton.backgroundColor = [UIColor clearColor];
    [newAccountButton setTitle:@"点此新增一个账户" forState:UIControlStateNormal];
    [newAccountButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [newAccountButton setTitleShadowColor:[UIColor whiteColor] forState:UIControlStateNormal];
    newAccountButton.titleLabel.font = [UIFont boldSystemFontOfSize:14.0f];
    newAccountButton.titleLabel.shadowOffset = CGSizeMake(0, 1);
    [newAccountButton addTarget:self action:@selector(didClickNewAccountButton) forControlEvents:UIControlEventTouchUpInside];
    
    UIView *tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 40)];
    //UIImageView *footerImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"paper_single_line.png"]];
    //footerImageView.frame = CGRectMake(-10, 0, 320, 40);
    //[tableFooterView addSubview:footerImageView];
    [tableFooterView addSubview:newAccountButton];
    self.tableView.tableFooterView = tableFooterView;
    
    self.mainBgView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"paper_main.png"]];
}

#pragma mark -
#pragma mark CoreDataTableViewController methods to overwrite

- (void)insertCellAtIndexPath:(NSIndexPath *)indexPath {
    [self.tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]
                          withRowAnimation:UITableViewRowAnimationTop];
}

- (void)deleteCellAtIndexPath:(NSIndexPath *)indexPath {
    [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]
                          withRowAnimation:UITableViewRowAnimationTop];
}

- (NSString *)customCellClassName {
    return @"LoginListTableViewCell";
}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.row == _selectRow) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    else {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    LoginListTableViewCell *loginCell = (LoginListTableViewCell *)cell;
    User *user = [self.fetchedResultsController objectAtIndexPath:indexPath];
    loginCell.avatarImageView.hidden = NO;
    loginCell.avatarImageView.image = [UIImage imageNamed:@"user_info_default_image.jpg"];
    loginCell.userNameLabel.text = user.name;
}

- (void)configureRequest:(NSFetchRequest *)request
{
    [request setEntity:[NSEntityDescription entityForName:@"User" inManagedObjectContext:self.managedObjectContext]];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"has_login == YES"];
    [request setPredicate:predicate];
    NSSortDescriptor *sort = [[NSSortDescriptor alloc] initWithKey:@"login_time" ascending:NO];
    NSArray *descriptors = [NSArray arrayWithObjects:sort, nil];
    [request setSortDescriptors:descriptors]; 
    request.fetchBatchSize = 20;
}

#pragma mark -
#pragma mark UITableView delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 40;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    User *user = [self.fetchedResultsController objectAtIndexPath:indexPath];
    [User changeCurrentUser:user inManagedObjectContext:self.managedObjectContext];
    [NSNotificationCenter postChangeCurrentUserNotification];
    _selectRow = indexPath.row;
    [self.tableView reloadData];
}

-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath { 
    return @"清除"; 
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {  
    return UITableViewCellEditingStyleDelete;  
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
//        UIAlertView *alert = [[UIAlertView alloc] 
//                              initWithTitle: @"清除账户" 
//                              message: @"是否确认清除？清除账户不会导致用户数据在服务器端的删除。" 
//                              delegate: self
//                              cancelButtonTitle: @"取消"
//                              otherButtonTitles: @"确定", nil];
        User *user = [self.fetchedResultsController objectAtIndexPath:indexPath];
        NSLog(@"delete user:%@", user.display_name);
        [self.managedObjectContext deleteObject:user];
        
        [UIView animateWithDuration:0.3f animations:^{
            CGRect frame = self.tableViewFooterView.frame;
            frame.origin.y -= 40;
            self.tableViewFooterView.frame = frame;
        } completion:^(BOOL finished) {
            if(_selectRow == indexPath.row) {
                _selectRow = _selectRow - 1 < 0 ? 0 : _selectRow - 1;
                if(self.numberOfRowsInFirstSection > 0) {
                    User *newUser = [self.fetchedResultsController objectAtIndexPath:[NSIndexPath indexPathForRow:_selectRow inSection:0]];
                    if(newUser)
                        [User changeCurrentUser:newUser inManagedObjectContext:self.managedObjectContext];
                    [self.tableView reloadData];
                }
            }
            User *currentUser = [CoreDataViewController getCurrentUser];
            if(currentUser) {
                NSLog(@"current user name：%@", currentUser.display_name);
            }
            [NSNotificationCenter postChangeCurrentUserNotification];
        }];
	}
}

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath { 
    return YES; 
} 

#pragma mark -
#pragma mark UIAlertView delegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if(buttonIndex == 0) {
        
    }
    else {
        
    }
}

#pragma mark -
#pragma mark IBActions

- (void)didClickNewAccountButton {
    LoginViewController *vc = [[LoginViewController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    [[UIApplication sharedApplication].rootViewController presentModalViewController:nav animated:YES];
}

@end
