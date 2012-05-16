//
//  Event+Addition.h
//  WeTongji
//
//  Created by 紫川 王 on 12-5-16.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "Event.h"

@interface Event (Addition)

+ (void)clearEmptyEventInManagedObjectContext:(NSManagedObjectContext *)context;

@end
