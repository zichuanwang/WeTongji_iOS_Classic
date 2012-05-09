//
//  UpdateUserAvatarViewController.m
//  WeTongji
//
//  Created by 紫川 王 on 12-5-6.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "UpdateUserAvatarViewController.h"

@interface UpdateUserAvatarViewController ()

@end

@implementation UpdateUserAvatarViewController

@synthesize scrollView = _scrollView;
@synthesize mainBgView = _mainBgView;
@synthesize paperTitleLabel = _paperTitleLabel;

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
    [self configureNavBar];
    [self configureScrollView];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    self.mainBgView = nil;
    self.scrollView = nil;
    self.paperTitleLabel = nil;
}

#pragma mark -
#pragma mark UI methods

- (void)configureNavBar {
    UILabel *titleLabel = [UILabel getNavBarTitleLabel:@"更新头像"];
    self.navigationItem.titleView = titleLabel;
    
    UIBarButtonItem *cancelButton = [UIBarButtonItem getFunctionButtonItemWithTitle:@"取消" target:self action:@selector(didClickCancelButton)];
    self.navigationItem.leftBarButtonItem = cancelButton;
    
    UIBarButtonItem *sendButton = [UIBarButtonItem getFunctionButtonItemWithTitle:@"发送" target:self action:@selector(didClickSendButton)];
    self.navigationItem.rightBarButtonItem = sendButton;
}

- (void)configureScrollView {
    CGRect frame = self.scrollView.frame;
    frame.size.height += 1;
    self.scrollView.contentSize = frame.size;
    
    self.mainBgView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"paper_main.png"]];
    self.paperTitleLabel.text = [NSString stringWithFormat:@"您正在更新\"%@\"的头像", self.currentUser.name];
}

#pragma mark - 
#pragma mark IBActions 

- (void)didClickCancelButton {
    [self.parentViewController dismissModalViewControllerAnimated:YES];
}

- (void)didClickSendButton {
    
}

@end
