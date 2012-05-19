//
//  MailViewController.m
//  WeTongji
//
//  Created by 紫川 王 on 12-5-17.
//  Copyright (c) 2012年 Tongji Apple Club. All rights reserved.
//

#import "MailViewController.h"

@interface MailViewController ()

@end

@implementation MailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:@"ComingSoonViewController" bundle:nil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self configureNavBar];
    [self configurePlaceHolder];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

#pragma mark -
#pragma mark UI methods

- (void)configureNavBar {
    UILabel *titleLabel = [UILabel getNavBarTitleLabel:@"邮箱"];
    self.navigationItem.titleView = titleLabel;
}

- (void)configurePlaceHolder {
    self.placeHolderImageView.image = [UIImage imageNamed:@"coming_soon_mail"];
    self.descriptionLabel.text = @"整合@tongji.edu.cn电子邮箱";
}

@end
