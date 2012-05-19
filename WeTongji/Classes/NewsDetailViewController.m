//
//  NewsDetailViewController.m
//  WeTongji
//
//  Created by 紫川 王 on 12-5-19.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "NewsDetailViewController.h"

@interface NewsDetailViewController ()

@property (nonatomic, strong) News *news;

@end

@implementation NewsDetailViewController

@synthesize news = _news;
@synthesize webView = _webView;

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
    [self configureWebView];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    self.webView = nil;
}

- (id)initWithNews:(News *)news {
    self = [super init];
    if(self) {
        self.news = news;
    }
    return self;
}

#pragma mark -
#pragma mark UI methods

- (void)configureNavBar {
    UILabel *titleLabel = [UILabel getNavBarTitleLabel:self.news.title];
    self.navigationItem.titleView = titleLabel;
    
    UIBarButtonItem *backButton = [UIBarButtonItem getBackButtonItemWithTitle:@"返回" target:self action:@selector(didClickBackButton)];
    self.navigationItem.leftBarButtonItem = backButton;
}

- (void)configureWebView {
    [self.webView loadHTMLString:self.news.content baseURL:nil];
}

#pragma mark - 
#pragma mark IBActions 

- (void)didClickBackButton {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
