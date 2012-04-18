//
//  LoginViewController.m
//  WeTongji
//
//  Created by 紫川 王 on 12-4-18.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "LoginViewController.h"
#import "UIApplication+Addition.h"

@interface LoginViewController ()

@property (weak, nonatomic) UITextField *editingTextField;

@end

@implementation LoginViewController

@synthesize bgImageView = _bgImageView;
@synthesize editingTextField = _editingTextField;

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
    UITapGestureRecognizer* gesture;
    gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    [self.bgImageView addGestureRecognizer:gesture];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    self.bgImageView = nil;
}

- (void)dismissKeyboard {
    [self.editingTextField resignFirstResponder];
}

- (IBAction)didClickCancelButton:(UIButton *)sender {
    [[UIApplication sharedApplication] dismissModalViewController];
    [self dismissKeyboard];
}

#pragma mark - 
#pragma mark UITextField delegate

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    self.editingTextField = textField;
}

@end
