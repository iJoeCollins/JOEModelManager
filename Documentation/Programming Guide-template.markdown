Programming Guide
-----------------

This programming guide serves as a reference on how to go about using the included api.

Steps
-----

1. Drag the files into your project and import them into your source file using, #import "JOEModelManager.h"
2. Instantiate the singleton and load the model file by calling [[JOEModelManager sharedManager] load];
3. Create objects that conform to NSCoding and add them by calling [[JOEModelManager sharedManager] addObject:object];
4. Get objects by calling [[JOEModelManager sharedManager] objectAtIndex:index]; // index is the objects place in the array
5. Remove objects by calling [[JOEModelManager sharedManager] removeObject:object];
6. Save objects to disk by calling [[JOEModelManager sharedManager] save];

<a name="App Delegate Example"></a>
App Delegate Example
--------------------

```
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
```
