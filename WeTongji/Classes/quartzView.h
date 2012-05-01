//
//  quartzView.h
//  WeTongji
//
//  Created by M.K.Rain on 12-4-28.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface quartzView : UIView

@property (nonatomic, strong) NSMutableArray *datesIndexArray;
@property (nonatomic, strong) NSMutableDictionary *dateSourceDictionary;
@property (nonatomic, strong) NSString *currentDate;

@property CGRect firstRect;

- (void)updateCourses;

@end
