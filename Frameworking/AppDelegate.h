//
//  AppDelegate.h
//  Frameworking
//
//  Created by Randy McLain on 5/5/16.
//  Copyright © 2016 Randy McLain. All rights reserved.
//
#import <CoreData/CoreData.h>
#import <UIKit/UIKit.h>
@import GSPAN;
@interface AppDelegate : UIResponder <UIApplicationDelegate>  {
  
  NSManagedObjectModel *managedObjectModel;
  NSManagedObjectContext *managedObjectContext;
  NSPersistentStore* persistentStore;
  NSPersistentStoreCoordinator* persistentStoreCoordinator;
  id <appDelegateResponder> delegate; 
  
}
@property (nonatomic, strong) NSManagedObjectModel* managedObjectModel;
@property (nonatomic, strong) NSManagedObjectContext* managedObjectContext;
@property (nonatomic, strong) NSPersistentStore* persistentStore;
@property (nonatomic, strong) NSPersistentStoreCoordinator* persistentStoreCoordinator;
@property (strong, nonatomic) UIWindow *window;


@end

