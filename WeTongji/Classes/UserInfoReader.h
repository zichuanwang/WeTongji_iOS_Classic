//
//  UserInfoReader.h
//  WeTongji
//
//  Created by 紫川 王 on 12-5-7.
//  Copyright (c) 2012年 Tongji Apple Club. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserInfoReader : NSObject

- (NSArray *)getUserInfoSectionArray;

@end

@interface UserInfoSection : NSObject

@property (nonatomic, strong) NSString *sectionTitle;
@property (nonatomic, strong) NSArray *itemArray;

@end

@interface UserInfo : NSObject

@property (nonatomic, strong) NSString *itemTitle;
@property (nonatomic, strong) NSString *contentName;

@end
