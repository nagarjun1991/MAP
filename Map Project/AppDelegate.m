/////////////////////////////////////////////////////////////////////
//  ControllerName:  AppDelegate.m                                 ||
//  ProjectName:     TasteOfHome                                   ||
//  Author:          Nagarjun Nama Balaji and Pavana Venkataswamy  ||
//  Copyright © 2015 Nagarjun Nama Balaji. All rights reserved.    ||
/////////////////////////////////////////////////////////////////////


#import "AppDelegate.h"
#import "StoreLocatorController.h"
#import "ViewController.h"
@import CoreLocation;

@interface AppDelegate ()

@property (strong,nonatomic) CLLocationManager *location;

@end


@implementation AppDelegate

@synthesize window = _window;



- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    
    // [Optional] Power your app with Local Datastore. For more info, go to
    // https://parse.com/docs/ios_guide#localdatastore/iOS
    [Parse enableLocalDatastore];
    
    // Initialize Parse.
    [Parse setApplicationId:@"HXCtsnzpWDjT40o4XGabHJIVgGF3NAtX2gU1PHQ4"
                  clientKey:@"brUgztvhwiqoHq8gIJatFv9UvjO8U3GXgPMTYSDW"];
    
    // [Optional] Track statistics around application opens.
    [PFAnalytics trackAppOpenedWithLaunchOptions:launchOptions];
    
    if ( [CLLocationManager locationServicesEnabled] )
    {
        NSLog(@"locationServicesEnabled");
        self.location = [[CLLocationManager alloc] init];  // get a location manager
        self.location.distanceFilter = 50.0;               // set criterion for location updating
        self.location.desiredAccuracy = kCLLocationAccuracyBest; // set criterion for location updating
        if ( [[[UIDevice currentDevice] systemVersion] doubleValue] >= 8.0 )
        {
            NSLog(@"iOS >= 8.0");
            [self.location requestAlwaysAuthorization]; // for permission to use location services whenever the app is running.
        }
    }
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // tell location manager to stop listening for location updates
    [self.location stopUpdatingLocation];
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // tell location manager to start listening for location updates
    [self.location startUpdatingLocation];
}

@end
