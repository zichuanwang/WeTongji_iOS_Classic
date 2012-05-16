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

@property (nonatomic, strong) IBOutlet UILabel *whenLabel;
@property (nonatomic, strong) IBOutlet UILabel *whatLabel;
@property (nonatomic, strong) IBOutlet UILabel *whereLabel;
@property (nonatomic, strong) IBOutlet UIImageView *pointImageView;
@property (nonatomic, strong) IBOutlet UIView *mainView;
@property (nonatomic, strong) IBOutlet UILabel *noDataHintLabel;

- (void)setEventType:(EventType)type;
- (void)setAsNormalCell;
- (void)setAsEmptyCell;

@end
