//
//  UserInfoTableViewCell.m
//  WeTongji
//
//  Created by 紫川 王 on 12-4-13.
//  Copyright (c) 2012年 Tongji Apple Club. All rights reserved.
//

#import "ToDoListTableViewCell.h"

@interface ToDoListTableViewCell ()

@end

@implementation ToDoListTableViewCell

@synthesize whenLabel = _whenLabel;
@synthesize whereLabel = _whereLabel;
@synthesize whatLabel = _whatLabel;
@synthesize pointImageView = _pointImageView;
@synthesize mainView = _mainView;
@synthesize noDataHintLabel = _noDataHintLabel;

- (void)awakeFromNib {
    self.whenLabel.text = @"";
    self.whereLabel.text = @"";
    self.whatLabel.text = @"";
    
    UIView *tempView = [[UIView alloc] init];
    [self setBackgroundView:tempView];
}

- (void)setEventType:(EventType)type {
    if(type == EventTypeActivity) {
        self.pointImageView.image = [UIImage imageNamed:@"to_do_list_point_yellow"];
    } else if(type == EventTypeRequiredCurriculum) {
        self.pointImageView.image = [UIImage imageNamed:@"to_do_list_point_blue"];
    } else if(type == EventTypeOptionalCurriculum) {
        self.pointImageView.image = [UIImage imageNamed:@"to_do_list_point_green"];
    }
}

- (void)setAsNormalCell {
    self.mainView.hidden = NO;
    self.noDataHintLabel.hidden = YES;
    self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
}

- (void)setAsEmptyCell {
    self.mainView.hidden = YES;
    self.noDataHintLabel.hidden = NO;
    self.accessoryType = UITableViewCellAccessoryNone;
}

@end
