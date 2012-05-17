//
//  ScheduleDayTableViewCell.h
//  WeTongji
//
//  Created by 紫川 王 on 12-5-12.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Event+Addition.h"

typedef enum {
    EventTypeActivity,
    EventTypeRequiredCurriculum,
    EventTypeOptionalCurriculum,
} EventType;

@interface ScheduleDayTableViewCell : UITableViewCell

@property (nonatomic, strong) IBOutlet UILabel *whenLabel;
@property (nonatomic, strong) IBOutlet UILabel *whatLabel;
@property (nonatomic, strong) IBOutlet UILabel *whereLabel;
@property (nonatomic, strong) IBOutlet UIImageView *pointImageView;
@property (nonatomic, strong) IBOutlet UIView *mainView;
@property (nonatomic, strong) IBOutlet UILabel *noDataHintLabel;

- (void)configureCell:(Event *)event;

@end
