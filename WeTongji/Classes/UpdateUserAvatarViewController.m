//
//  UpdateUserAvatarViewController.m
//  WeTongji
//
//  Created by 紫川 王 on 12-5-6.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <MobileCoreServices/MobileCoreServices.h>
#import "UpdateUserAvatarViewController.h"
#import "WTClient.h"
#import "UIImageView+Addition.h"
#import "UIApplication+Addition.h"
#import "EditAvatarViewController.h"

@interface UpdateUserAvatarViewController ()

@end

@implementation UpdateUserAvatarViewController

@synthesize scrollView = _scrollView;
@synthesize mainBgView = _mainBgView;
@synthesize paperTitleLabel = _paperTitleLabel;
@synthesize avatarImageView = _avatarImageView;

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
    self.avatarImageView = nil;
}

#pragma mark -
#pragma mark Logic methods

- (BOOL)isParameterValid {
    BOOL result = YES;
    if(self.avatarImageView.image == nil) {
        [UIApplication presentAlertToast:@"请选择一张新的头像上传。" withVerticalPos:self.toastVerticalPos];
        result = NO;
    } 
    return result;
}

- (void)updateUser:(NSDictionary *)dict {
    NSDictionary *userInfo = [dict objectForKey:@"User"];
    User *user = [User insertUser:userInfo inManagedObjectContext:self.managedObjectContext];
    [User changeCurrentUser:user inManagedObjectContext:self.managedObjectContext];
}

- (void)updateUserAvatar {
    if(!self.isParameterValid)
        return;
    if(self.isSendingRequest)
        return;
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem getActivityIndicatorButtonItem];
    self.mainBgView.userInteractionEnabled = NO;
    
    WTClient *client = [WTClient client];
    [client setCompletionBlock:^(WTClient *client) {
        if(!client.hasError) {
            [self updateUser:client.responseData];
            [self.parentViewController dismissModalViewControllerAnimated:YES];
            [UIApplication presentToast:@"更新头像成功。" withVerticalPos:DefaultToastVerticalPosition];
        } else {
            [UIApplication presentAlertToast:@"更改头像失败。" withVerticalPos:DefaultToastVerticalPosition];
            self.sendingRequest = NO;
            self.mainBgView.userInteractionEnabled = YES;
        }
        [self configureNavBar];
    }];
    [client updateUserAvatar:self.avatarImageView.image];
    self.sendingRequest = YES;
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
    
    [self.avatarImageView loadImageFromURL:self.currentUser.avatar_link cacheInContext:self.managedObjectContext];
}

#pragma mark - 
#pragma mark IBActions 

- (void)didClickCancelButton {
    [self.parentViewController dismissModalViewControllerAnimated:YES];
}

- (void)didClickSendButton {
    [self updateUserAvatar];
}

- (IBAction)didClickAvatarButton:(UIButton *)sender {
    UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                  initWithTitle:nil
                                  delegate:self
                                  cancelButtonTitle:@"取消"
                                  destructiveButtonTitle:nil
                                  otherButtonTitles:@"相册", @"拍照", nil];
    [actionSheet showInView:self.view];
}

#pragma mark -
#pragma mark UIActionSheet delegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if(buttonIndex == 2)
        return;
    
    UIImagePickerController *ipc = [[UIImagePickerController alloc] init];
    ipc.delegate = self;
    ipc.allowsEditing = NO;
    
    if(buttonIndex == 0) {
        ipc.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    } else if(buttonIndex == 1) {
        ipc.sourceType = UIImagePickerControllerSourceTypeCamera;
    }
    
    [self presentModalViewController:ipc animated:YES];
}

#pragma mark -
#pragma mark UIImagePickerController delegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    EditAvatarViewController *vc = [[EditAvatarViewController alloc] initWithImage:image];
    vc.delegate = self;
    [picker pushViewController:vc animated:YES];
}

#pragma mark -
#pragma mark EditAvatarViewController delegate

- (void)editAvatarViewDidCancelEdit {
    [self dismissModalViewControllerAnimated:YES];
}

- (void)editAvatarViewDidFinishEdit:(UIImage *)image {
    self.avatarImageView.image = image;
    [self dismissModalViewControllerAnimated:YES];
}

@end
