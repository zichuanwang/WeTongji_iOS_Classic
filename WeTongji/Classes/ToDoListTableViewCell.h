//
//  UserInfoTableViewCell.h
//  WeTongji
//
//  Created by 紫川 王 on 12-4-13.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ToDoListTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *whenLabel;
@property (strong, nonatomic) IBOutlet UILabel *whatLabel;
@property (strong, nonatomic) IBOutlet UILabel *whereLabel;

@property (strong, nonatomic) IBOutlet UIImageView *pointImageView;

@end
