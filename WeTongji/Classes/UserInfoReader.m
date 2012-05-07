//
//  UserInfoReader.m
//  WeTongji
//
//  Created by 紫川 王 on 12-5-7.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "UserInfoReader.h"

#define kUserInfoSectionArray    @"kUserInfoSectionArray"
#define kSectionName                @"kSectionName"
#define kSectionArray               @"kSectionArray"

#define kItemTitle                  @"kItemTitle"
#define kContentName                @"kContentName"

@interface UserInfoReader()

@property (nonatomic, strong) NSDictionary *userInfoMap;

@end

@implementation UserInfoReader

@synthesize userInfoMap = _userInfoMap;

- (id)init {
    self = [super init];
    if(self) {
        [self readPlist];
    }
    return self;
}

- (void)readPlist {
    NSString *configFilePath = [[NSBundle mainBundle] pathForResource:@"UserInfo" ofType:@"plist"];  
    self.userInfoMap = [[NSDictionary alloc] initWithContentsOfFile:configFilePath]; 
}

- (NSArray *)getUserInfoSectionArray {
    NSArray *sectonArray = [NSArray arrayWithArray:[self.userInfoMap objectForKey:kUserInfoSectionArray]];
    NSMutableArray *result = [NSMutableArray array];
    for(NSDictionary *sectionDict in sectonArray) {
        UserInfoSection *section = [[UserInfoSection alloc] init];
        section.sectionTitle = [sectionDict objectForKey:kSectionName];
        NSArray *infoArray = [sectionDict objectForKey:kSectionArray];
        NSMutableArray *parsedInfoArray = [NSMutableArray arrayWithCapacity:4];
        for(NSDictionary *infoDict in infoArray) {
            UserInfo *info = [[UserInfo alloc] init];
            info.itemTitle = [infoDict objectForKey:kItemTitle];
            info.contentName = [infoDict objectForKey:kContentName];
            [parsedInfoArray addObject:info];
        }
        section.itemArray = parsedInfoArray;
        [result addObject:section];
    }
    return result;
}

@end

@implementation UserInfoSection

@synthesize sectionTitle = _sectionTitle;
@synthesize itemArray = _itemArray;

@end

@implementation UserInfo

@synthesize itemTitle = _itemTitle;
@synthesize contentName = _contentName;

@end
