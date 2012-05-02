//
//  ChannelSettingTableViewCell.h
//  WeTongji
//
//  Created by 紫川 王 on 12-4-23.
//  Copyright (c) 2012年 Tongji Apple Club. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ChannelSettingTableViewCellDelegate;

@interface ChannelSettingTableViewCell : UITableViewCell

@property (nonatomic, strong) IBOutlet UILabel *categoryLabel;
@property (nonatomic, strong) IBOutlet UISwitch *itemSwitch;
@property (nonatomic, weak) id<ChannelSettingTableViewCellDelegate> delegate;

- (IBAction)didCLickSwitch:(UISwitch *)sender;

@end

@protocol ChannelSettingTableViewCellDelegate <NSObject>

@optional
- (void)channelSettingCellDidClickSwitch:(UITableViewCell *)cell;

@end
