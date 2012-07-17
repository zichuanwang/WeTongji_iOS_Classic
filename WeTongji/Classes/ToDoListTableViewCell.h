//
//  UserInfoTableViewCell.h
//  WeTongji
//
//  Created by 紫川 王 on 12-4-13.
//  Copyright (c) 2012年 Tongji Apple Club. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ScheduleDayTableViewCell.h"

@interface ToDoListTableViewCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UILabel *whenLabel;
@property (nonatomic, weak) IBOutlet UILabel *whatLabel;
@property (nonatomic, weak) IBOutlet UILabel *whereLabel;
@property (nonatomic, weak) IBOutlet UIImageView *pointImageView;
@property (nonatomic, weak) IBOutlet UIView *mainView;
@property (nonatomic, weak) IBOutlet UILabel *noDataHintLabel;

- (void)setEventType:(EventType)type;
- (void)setAsNormalCell;
- (void)setAsEmptyCell;

@end
