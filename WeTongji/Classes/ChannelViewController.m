//
//  ChannelViewController.m
//  WeTongji
//
//  Created by 紫川 王 on 12-4-14.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ChannelViewController.h"

@interface ChannelViewController ()

@end

@implementation ChannelViewController

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
    //self.navigationController.navigationBar.topItem.title = @"频道";
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 44)];
    titleLabel.text = @"频道";
    titleLabel.font = [UIFont boldSystemFontOfSize:20];
    titleLabel.textColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.8];
    titleLabel.shadowColor = [UIColor darkGrayColor];
    titleLabel.shadowOffset = CGSizeMake(0, 1);
    [titleLabel sizeToFit];
    titleLabel.backgroundColor = [UIColor clearColor];
    self.navigationController.navigationBar.topItem.titleView = titleLabel;
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 60, 44)];
    [button setBackgroundImage:[UIImage imageNamed:@"nav_bar_btn_finish.png"] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:@"nav_bar_btn_finish_hl.png"] forState:UIControlStateHighlighted];
    [button setTitle:@"完成" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor colorWithRed:1 green:1 blue:1 alpha:0.8] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor colorWithRed:1 green:1 blue:1 alpha:0.8f] forState:UIControlStateHighlighted];
    [button setTitleShadowColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont boldSystemFontOfSize:13];
    button.titleLabel.shadowOffset = CGSizeMake(0, 1);
    [button addTarget:self action:@selector(didClickFinishButton) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *finishButton = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.leftBarButtonItem = finishButton;
    self.navigationItem.leftBarButtonItem.enabled = YES;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)didClickFinishButton {
    [self.parentViewController dismissModalViewControllerAnimated:YES];
}

@end
