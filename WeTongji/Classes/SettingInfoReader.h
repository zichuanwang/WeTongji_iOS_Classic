//
//  SettingInfoReader.h
//  WeTongji
//
//  Created by 紫川 王 on 12-5-6.
//  Copyright (c) 2012年 Tongji Apple Club. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kPushNavigationController   @"kPushNavigationController"
#define kModalViewController        @"kModalViewController"
#define kAccessoryTypeSwitch        @"kAccessoryTypeSwitch"
#define kAccessoryTypeDisclosure    @"kAccessoryTypeDisclosure"

@interface SettingInfoReader : NSObject

- (NSArray *)getSettingInfoSectionArray;

@end

@interface SettingInfoSection : NSObject

@property (nonatomic, strong) NSString *sectionTitle;
@property (nonatomic, strong) NSArray *itemArray;

@end

@interface SettingInfo : NSObject

@property (nonatomic, strong) NSString *itemTitle;
@property (nonatomic, strong) NSString *nibFileName;
@property (nonatomic, strong) NSString *accessoryType;
@property (nonatomic, strong) NSString *wayToPresentViewController;

@end
