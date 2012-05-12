//
//  WTTableViewHeaderFooterFactory.h
//  WeTongji
//
//  Created by 紫川 王 on 12-5-12.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WTTableViewHeaderFooterFactory : NSObject

+ (UIView *)getWideWTTableViewHeader;
+ (UIView *)getWideWTTableViewEmptyFooter;
+ (UIView *)getWideWTTableViewEmptyFooterWithHint;

@end
