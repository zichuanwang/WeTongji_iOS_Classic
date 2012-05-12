//
//  ScheduleDayTableViewCell.h
//  WeTongji
//
//  Created by 紫川 王 on 12-5-12.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    ActivityTypeActivity,
    ActivityTypeCurriculum,
} ActivityType;

@interface ScheduleDayTableViewCell : UITableViewCell

@property (nonatomic, strong) IBOutlet UILabel *whenLabel;
@property (nonatomic, strong) IBOutlet UILabel *whatLabel;
@property (nonatomic, strong) IBOutlet UILabel *whereLabel;
@property (nonatomic, strong) IBOutlet UIImageView *pointImageView;

- (void)setActivityType:(ActivityType)type;

@end
