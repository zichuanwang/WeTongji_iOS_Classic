//
//  PromoteLoginViewController.h
//  WeTongji
//
//  Created by 紫川 王 on 12-5-7.
//  Copyright (c) 2012年 Tongji Apple Club. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PromoteLoginViewController : UIViewController 

@property (nonatomic, weak) IBOutlet UIScrollView *scrollView;
@property (nonatomic, weak) IBOutlet UIView *mainBgView;

- (IBAction)didClickLoginButton:(UIButton *)sender;

@end
