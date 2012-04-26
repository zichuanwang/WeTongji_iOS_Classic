//
//  User.h
//  WeTongji
//
//  Created by 紫川 王 on 12-4-26.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface User : NSManagedObject

@property (nonatomic, retain) NSString * user_ud;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSDate * birthday;

@end
