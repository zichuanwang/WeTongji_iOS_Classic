//
//  PromoteLoginViewController.h
//  WeTongji
//
//  Created by 紫川 王 on 12-5-7.
//  Copyright (c) 2012年 Tongji Apple Club. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PromoteLoginViewController : UIViewController 

@property (nonatomic, strong) IBOutlet UIScrollView *scrollView;
@property (nonatomic, strong) IBOutlet UIView *mainBgView;

- (IBAction)didClickLoginButton:(UIButton *)sender;

@end
