//
//  SettingTableViewCell.h
//  WeTongji
//
//  Created by 紫川 王 on 12-4-24.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingTableViewCell : UITableViewCell

@property (nonatomic, strong) IBOutlet UILabel *itemTitleLabel;
@property (nonatomic, strong) IBOutlet UISwitch *itemSwitch;

@end
