//
//  WTPostViewController.m
//  WeTongji
//
//  Created by 紫川 王 on 12-5-5.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "WTPostViewController.h"

@interface WTPostViewController ()

@end

@implementation WTPostViewController

@synthesize toastVerticalPos = _toastVerticalPos;
@synthesize sendingRequest = _sendingRequest;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

#pragma mark -
#pragma mark Methods to overwrite

- (BOOL)isParameterValid {
    return YES;
}

#pragma mark -
#pragma mark Keyboard notification

- (void)keyboardWillShow:(NSNotification *)notification {
    NSDictionary *info = [notification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    self.toastVerticalPos = 480 - kbSize.height - 40;
    //NSLog(@"keyboard changed, keyboard width = %f, height = %f", kbSize.width,kbSize.height);
}

@end
