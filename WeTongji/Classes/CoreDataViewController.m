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

static CoreDataKernal *kernalInstance = nil;

@interface CoreDataViewController()

@property (nonatomic, readonly) CoreDataKernal *kernal;

@end

@implementation CoreDataViewController

@synthesize managedObjectContext = _managedObjectContext;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if(self) {
        AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        self.managedObjectContext = appDelegate.managedObjectContext;
        [CoreDataKernal getKernalInstance];
        //NSLog(@"init core data view controller");
    }
    return self;
}

- (CoreDataKernal *)kernal {
    return [CoreDataKernal getKernalInstance];
}

- (User *)currentUser {
    return [CoreDataViewController getCurrentUser];
}

+ (User *)getCurrentUser {
    return [CoreDataKernal getKernalInstance].currentUser;
}

#pragma mark -
#pragma mark CoreData methods

- (void)saveContext
{
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. 
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        } 
    }
}

@end

@implementation CoreDataKernal

@synthesize currentUser = _currentUser;

- (id)init {
    self = [super init];
    if(self) {
        AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        self.currentUser = [User currentUserInManagedObjectContext:appDelegate.managedObjectContext];
        
        [NSNotificationCenter registerCoreChangeCurrentUserNotificationWithSelector:@selector(handleCoreChangeCurrentUserNotification:) target:self]; 
    }
    return self;
}

+ (CoreDataKernal *)getKernalInstance {
    if(kernalInstance == nil) {
        kernalInstance = [[CoreDataKernal alloc] init];
    }
    return kernalInstance;
}

#pragma mark -
#pragma mark Handle notifications

- (void)handleCoreChangeCurrentUserNotification:(NSNotification *)notification {
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    self.currentUser = [User currentUserInManagedObjectContext:appDelegate.managedObjectContext];
    [NSNotificationCenter postChangeCurrentUserNotification];
}

@end