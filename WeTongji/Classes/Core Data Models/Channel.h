//
//  Channel.h
//  WeTongji
//
//  Created by 紫川 王 on 12-5-3.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Channel : NSManagedObject

@property (nonatomic, retain) NSString * content;
@property (nonatomic, retain) NSString * channel_id;
@property (nonatomic, retain) NSNumber * follow_count;
@property (nonatomic, retain) NSString * title;

@end
