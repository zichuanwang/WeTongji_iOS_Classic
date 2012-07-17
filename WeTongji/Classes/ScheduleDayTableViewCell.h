//
//  ScheduleDayTableViewCell.h
//  WeTongji
//
//  Created by 紫川 王 on 12-5-12.
//  Copyright (c) 2012年 Tongji Apple Club. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Event+Addition.h"

typedef enum {
    EventTypeActivity,
    EventTypeRequiredCurriculum,
    EventTypeOptionalCurriculum,
} EventType;

@interface ScheduleDayTableViewCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UILabel *whenLabel;
@property (nonatomic, weak) IBOutlet UILabel *whatLabel;
@property (nonatomic, weak) IBOutlet UILabel *whereLabel;
@property (nonatomic, weak) IBOutlet UIImageView *pointImageView;
@property (nonatomic, weak) IBOutlet UIView *mainView;
@property (nonatomic, weak) IBOutlet UILabel *noDataHintLabel;

- (void)configureCell:(Event *)event;

@end
