//
//  AppDelegate.h
//  ANWeather
//
//  Created by a on 15/12/25.
//  Copyright (c) 2015年 YongChaoAn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "RESideMenu.h"

@protocol ANAppDelegateRESideMenuDelegate <NSObject>

@optional
- (void)appDelegateRESideMenuWillShowMenuViewController;
- (void)appDelegateRESideMenuWillHideMenuViewController;


@end


@interface AppDelegate : UIResponder <UIApplicationDelegate, RESideMenuDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@property (weak, nonatomic)id<ANAppDelegateRESideMenuDelegate> delegate;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;


@end

