//
//  User.h
//  WeTongji
//
//  Created by 紫川 王 on 12-5-2.
//  Copyright (c) 2012年 Tongji Apple Club. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Activity;

@interface User : NSManagedObject

@property (nonatomic, retain) NSDate * birthday;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * user_ud;
@property (nonatomic, retain) Activity *favor;
@property (nonatomic, retain) Activity *schedule;

@end
