//
//  CoreDataViewController.h
//  PushBox
//
//  Created by Xie Hasky on 11-7-24.
//  Copyright 2011年 同济大学. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User+Addition.h"

@interface CoreDataViewController : UIViewController

@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, readonly) User *currentUser;

+ (User *)getCurrentUser;

@end

@interface CoreDataKernal : NSObject

@property (nonatomic, strong) User *currentUser;

+ (CoreDataKernal *)getKernalInstance;

@end
