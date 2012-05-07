//
//  CoreDataViewController.m
//  PushBox
//
//  Created by Xie Hasky on 11-7-24.
//  Copyright 2011年 同济大学. All rights reserved.
//

#import "CoreDataViewController.h"
#import "AppDelegate.h"
#import "User+Addition.h"
#import "NSNotificationCenter+Addition.h"

static User *currentUserInstance = nil;

@implementation CoreDataViewController

@synthesize managedObjectContext = _managedObjectContext;

- (id)init {
    self = [super init];
    if(self) {
        AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        self.managedObjectContext = appDelegate.managedObjectContext;
        [NSNotificationCenter registerChangeCurrentUserNotificationWithSelector:@selector(handleChangeCurrentUserNotification:) target:self]; 
    }
    return self;
}

- (User *)currentUser {
    if(currentUserInstance == nil) {
        currentUserInstance = [User currentUserInManagedObjectContext:self.managedObjectContext];
    }
    return currentUserInstance;
}

#pragma mark -
#pragma mark Handle notifications

- (void)handleChangeCurrentUserNotification:(NSNotification *)notification {
    currentUserInstance = [User currentUserInManagedObjectContext:self.managedObjectContext];
}

@end
