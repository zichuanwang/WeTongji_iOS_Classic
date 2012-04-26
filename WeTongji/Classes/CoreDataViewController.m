//
//  CoreDataViewController.m
//  PushBox
//
//  Created by Xie Hasky on 11-7-24.
//  Copyright 2011年 同济大学. All rights reserved.
//

#import "CoreDataViewController.h"
#import "AppDelegate.h"

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

@end
