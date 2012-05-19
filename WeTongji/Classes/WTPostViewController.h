//
//  WTPostViewController.h
//  WeTongji
//
//  Created by 紫川 王 on 12-5-5.
//  Copyright (c) 2012年 Tongji Apple Club. All rights reserved.
//

#import "WTNavigationViewController.h"

@interface WTPostViewController : WTNavigationViewController

@property (nonatomic, assign) CGFloat toastVerticalPos;
@property (nonatomic, readonly, getter = isParameterValid) BOOL parameterValid;
@property (nonatomic, assign, getter = isSendingRequest) BOOL sendingRequest;

@end
