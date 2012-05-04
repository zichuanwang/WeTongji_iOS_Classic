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

static User *currentUserInstance = nil;

@implementation CoreDataViewController

@synthesize managedObjectContext = _managedObjectContext;

- (id)init {
    self = [super init];
    if(self) {
        AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        self.managedObjectContext = appDelegate.managedObjectContext;
    }
    return self;
}

- (User *)currentUser {
    if(currentUserInstance == nil) {
        NSDictionary *dict = [NSDictionary dictionaryWithObject:@"092969" forKey:@"Id"];
        currentUserInstance = [User insertUser:dict inManagedObjectContext:self.managedObjectContext];
    }
    return currentUserInstance;
}

@end
