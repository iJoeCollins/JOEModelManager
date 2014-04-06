//
//  AppDelegate.m
//  JOEModelManager
//
//  Created by Joseph Collins on 4/6/14.
//  Copyright (c) 2014 Joseph Collins. All rights reserved.
//

#import "AppDelegate.h"
#import "JOEModelManager.h"
#import "ViewController.h"
#import "MyObject.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    NSLog(@"DidFinishLaunching");
    // Override point for customization after application launch.
    ViewController *viewController = (ViewController *)self.window.rootViewController;
    
    // Initialize the shared model manager to perform data modeling tasks
    BOOL success = [[JOEModelManager sharedManager] load];
    
    if (!success) {
        // This is a brand new user, let's introduce them!
        // You could use this functionality to instantiate an Introduction View Controller
        viewController.myObject = [[MyObject alloc] initWithText:@"Welcome New User!"];
        [[JOEModelManager sharedManager] addObject:viewController.myObject];
        [[JOEModelManager sharedManager] save];
    }else {
        // This user has existing data. Get straight to work.
        // Here you would instantiate the main part of the app or just do work.
        viewController.myObject = [[JOEModelManager sharedManager] objectAtIndex:0];
    }
    
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
