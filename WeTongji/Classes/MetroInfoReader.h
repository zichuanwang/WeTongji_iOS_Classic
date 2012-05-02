//
//  MetroInfoReader.h
//  WeTongji
//
//  Created by 紫川 王 on 12-4-30.
//  Copyright (c) 2012年 Tongji Apple Club. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MetroInfoReader : NSObject

- (NSArray *)getMetroInfoArray;

@end

@interface MetroInfo : NSObject

@property (nonatomic, strong) NSString *nibFileName;
@property (nonatomic, strong) NSString *buttonTitle;
@property (nonatomic, strong) NSString *buttonImageFileName;
@property (nonatomic, strong) NSString *buttonHighlightImageFileName;
@property (nonatomic, strong) NSString *alertMessage;

@end
