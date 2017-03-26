//
//  AppDelegate.m
//  Frameworking
//
//  Created by Randy McLain on 5/5/16.
//  Copyright © 2016 Randy McLain. All rights reserved.
//

#import "AppDelegate.h"
#include "GSPAN.h"
@interface AppDelegate ()

@end

@implementation AppDelegate
@synthesize managedObjectModel;
@synthesize managedObjectContext;
@synthesize persistentStore;
@synthesize persistentStoreCoordinator;


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  // Override point for customization after application launch.
  [[RestController getInstance] initialize]; 
  return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
  // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
  // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
  // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
  // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
  // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
  // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
  // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


#pragma mark -
#pragma mark Core Data stack
/**
 Returns the managed object context for the application.
 If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
 */
- (NSManagedObjectContext *) managedObjectContext {
  if (managedObjectContext == nil) {
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    // NEw Encryption Code
    // 2015-10-29 Remove ECD-Encrypted Core Data
    //NSPersistentStoreCoordinator *coordinator = [EncryptedStore makeStore:[self managedObjectModel] passcode:@"iL0v3T2"];
    if (coordinator != nil) {
      //🔓[Bug 3515] Updated init for MOC to non deprecated initWithConcurrencyType.  Used Main as the app calls all MOC on main thread.
      managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
      [managedObjectContext setPersistentStoreCoordinator: coordinator];
      managedObjectContext.undoManager = nil;
      //🔒[Bug 3515]
    }
  }
  
  return managedObjectContext;
}

/**
 Returns the managed object model for the application.
 If the model doesn't already exist, it is `created by merging all of the models found in the application bundle.
 */
- (NSManagedObjectModel *)managedObjectModel {
  
  if (managedObjectModel != nil) {
    return managedObjectModel;
  }
  NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"Frameworking" withExtension:@"momd"];
  managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
  //managedObjectModel = [[NSManagedObjectModel mergedModelFromBundles:nil] retain];
  return managedObjectModel;
}

/**
 Returns the persistent store coordinator for the application.
 If the coordinator doesn't already exist, it is created and the application's store added to it.
 */
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
  if (persistentStoreCoordinator != nil) {
    return persistentStoreCoordinator;
  }
  
  NSURL *storeUrl = [self getStoreURL];
  
  // Rollback journalling mode...  @{@"journal_mode": @"TRUNCATE"}, NSSQLitePragmasOption,
  NSDictionary *options = [NSDictionary dictionaryWithObjectsAndKeys:
                           [NSNumber numberWithBool:YES], NSMigratePersistentStoresAutomaticallyOption,
                           [NSNumber numberWithBool:YES],NSInferMappingModelAutomaticallyOption,
                           NSFileProtectionComplete, NSFileProtectionKey,
                           nil];
  
  persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel: [self managedObjectModel]];
  
  NSError *error = nil;
  self.persistentStore = [persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeUrl options:options error:&error];
  if (!self.persistentStore) {
    NSLog(@"Error: %@",error);

  }
  
  return persistentStoreCoordinator;
}

-(NSURL *)getStoreURL {
  NSString *storePath = [[self applicationDocumentsDirectory] stringByAppendingPathComponent: @"Frameworking"];
  /*
   Set up the store.
   For the sake of illustration, provide a pre-populated default store.
   */
  NSFileManager *fileManager = [NSFileManager defaultManager];
  // If the expected store doesn't exist, copy the default store.
  if (![fileManager fileExistsAtPath:storePath]) {
    NSString *defaultStorePath = [[NSBundle mainBundle] pathForResource:@"Frameworking" ofType:@"sqlite"];
    if (defaultStorePath) {
      [fileManager copyItemAtPath:defaultStorePath toPath:storePath error:NULL];
    }
  }
  
  NSURL *storeUrl = [NSURL fileURLWithPath:storePath];
  
  return storeUrl;
}

#pragma mark Application's documents directory

/**
 Returns the path to the application's documents directory.
 */
- (NSString *)applicationDocumentsDirectory {
  
  NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
  NSString *basePath = ([paths count] > 0) ? [paths objectAtIndex:0] : nil;
  return basePath;
}


#pragma mark - UIApplicationDelegate


- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString *,id> *)options {
  
  if (!url)
  {return NO;} else {
    NSString *urlString = [NSString stringWithFormat:@"%@", url];
    NSDictionary *authorizationCodeDictionary = [options objectForKey: UIApplicationOpenURLOptionsAnnotationKey];
    
    self -> delegate = [RestController getInstance];
    [self -> delegate appDelegateResponse:urlString theSource:authorizationCodeDictionary];
    return YES; 
    
  }
}



@end
