//
//  AppInfoViewController.m
//  WeTongji
//
//  Created by 紫川 王 on 12-5-22.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "AppInfoViewController.h"
#import "UIApplication+Addition.h"
#import "UIImageView+Addition.h"

#define WE_TONGJI_EMAIL             @"wetongji2012@gmail.com"
#define WE_TONGJI_SINA_WEIBO_URL    @"http://www.weibo.com/wetongji"
#define WE_TONGJI_APP_STORE_URL     @"http://itunes.apple.com/cn/app/id526260090?mt=8"

@interface AppInfoViewController ()

@end

@implementation AppInfoViewController

@synthesize iconImageView = _iconImageView;
@synthesize scrollView = _scrollView;
@synthesize mainBgView = _mainBgView;
@synthesize appVersionLabel = _appVersionLabel;

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
    [self configureScrollView];
    [self configureNavBar];
    
    NSString *currentBundleVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    self.appVersionLabel.text = currentBundleVersion;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    self.iconImageView = nil;
    self.scrollView = nil;
    self.mainBgView = nil;
}


#pragma mark -
#pragma mark UI methods 

- (void)configureScrollView {
    [self.iconImageView configureShadow];
    
    CGRect frame = self.scrollView.frame;
    frame.size.height = frame.size.height + 1;
    self.scrollView.contentSize = frame.size;
    
    self.mainBgView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"paper_main.png"]];
}

- (void)configureNavBar {
    UILabel *titleLabel = [UILabel getNavBarTitleLabel:@"版本信息"];
    self.navigationItem.titleView = titleLabel;
    
    UIBarButtonItem *finishButton = [UIBarButtonItem getFunctionButtonItemWithTitle:@"完成" target:self action:@selector(didClickCancelButton)];
    self.navigationItem.leftBarButtonItem = finishButton;
}

#pragma mark - 
#pragma mark IBActions

- (IBAction)didClickFeedbackButton:(UIButton *)sender {
    MFMailComposeViewController *picker = [[MFMailComposeViewController alloc] init];
    if (!picker) {
        [UIApplication presentAlertToast:@"您的设备未设置邮件帐号。" withVerticalPos:DefaultToastVerticalPosition];
        return;
    }
    picker.mailComposeDelegate = self;
    [picker setSubject:@"微同济 1.1.0 用户反馈"];
    [picker.navigationBar setBarStyle:UIBarStyleBlack];

    NSArray *toRecipients = [NSArray arrayWithObjects:WE_TONGJI_EMAIL, nil];
    NSString *emailBody = @"请将需要反馈的信息填入邮件正文，您的宝贵建议会直接送达微同济开发团队。";
    [picker setToRecipients:toRecipients];
    [picker setMessageBody:emailBody isHTML:NO];
    [self presentModalViewController:picker animated:YES];
}

- (IBAction)didClickFollowUsButton:(UIButton *)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:WE_TONGJI_SINA_WEIBO_URL]];
}

- (IBAction)didClickEvaluateUsButton:(UIButton *)sender {
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:WE_TONGJI_APP_STORE_URL]];    
}

- (void)didClickCancelButton {
    [self.parentViewController dismissModalViewControllerAnimated:YES];
}

#pragma mark - 
#pragma mark MFMailComposeViewController delegate

- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error {
    if(result == MFMailComposeResultSent)
        [UIApplication presentToast:@"邮件已发送。" withVerticalPos:DefaultToastVerticalPosition];
    else if(result == MFMailComposeResultFailed)
        [UIApplication presentAlertToast:@"邮件发送失败。" withVerticalPos:DefaultToastVerticalPosition];
	[self dismissModalViewControllerAnimated:YES];
}

@end
