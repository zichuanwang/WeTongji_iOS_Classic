//
//  UserInfoTableViewCell.m
//  WeTongji
//
//  Created by 紫川 王 on 12-4-13.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ToDoListTableViewCell.h"

@interface ToDoListTableViewCell ()

@end

@implementation ToDoListTableViewCell

@synthesize whenLabel = _whenLabel;
@synthesize whereLabel = _whereLabel;
@synthesize whatLabel = _whatLabel;
@synthesize pointImageView = _pointImageView;

- (void)awakeFromNib {
    self.whenLabel.text = @"";
    self.whereLabel.text = @"";
    self.whatLabel.text = @"";
    
    UIView *tempView = [[UIView alloc] init];
    [self setBackgroundView:tempView];
}

@end
