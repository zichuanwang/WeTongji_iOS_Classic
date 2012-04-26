//
//  Channel.h
//  WeTongji
//
//  Created by 紫川 王 on 12-4-26.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Channel : NSManagedObject

@property (nonatomic, retain) NSString * channel_id;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * channel_description;
@property (nonatomic, retain) NSString * avatar_link;
@property (nonatomic, retain) NSNumber * follow_count;

@end
