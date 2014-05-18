//
//  TPLAppDelegate.h
//  SQLite
//
//  Created by Harishwar on 4/24/14.
//  Copyright (c) 2014 com.harishwar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TPLAppDelegate : UIResponder <UIApplicationDelegate>

@property (nonatomic, retain, readonly) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, retain, readonly) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator ;

@property (strong, nonatomic) UIWindow *window;

@end
