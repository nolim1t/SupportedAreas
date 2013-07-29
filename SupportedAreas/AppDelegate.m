//
//  AppDelegate.m
//  SupportedAreas
//
//  Created by Barry Teoh on 7/30/13.
//  Copyright (c) 2013 perceptionz.net. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    CLLocationCoordinate2D coord;
    coord.latitude = -33.873979;
    coord.longitude = 151.212288;
    
    [self checkIfInAreaWithRemoteURL:[NSURL URLWithString:@"https://somewebsite/supported_areas.json"] AndWithCoordinateToTest:coord];
    
    // Override point for customization after application launch.
    return YES;
}
#pragma mark - The function to work with
// Framework Requires: CoreLocation
// Other things: URL and coords to test out. Should also know what to do afterwards (replace NSLog with actions).
-(void) checkIfInAreaWithRemoteURL:(NSURL *)remoteURL AndWithCoordinateToTest:(CLLocationCoordinate2D)coordtotest {
    NSURLRequest *request = [NSURLRequest requestWithURL:remoteURL];
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON){
        if ([JSON respondsToSelector:@selector(objectForKey:)]) {
            if ([[JSON objectForKey:@"areas"] respondsToSelector:@selector(objectAtIndex:)]) {
                NSArray *areas = [JSON objectForKey:@"areas"];
                BOOL supported = NO;
                for (NSDictionary *area in areas) {
                    NSInteger distance = [[area objectForKey:@"distance"] integerValue];
                    NSArray *geo = [area objectForKey:@"geo"];
                    CLLocation *areaobj = [[CLLocation alloc] initWithLatitude:[[geo objectAtIndex:0] doubleValue] longitude:[[geo objectAtIndex:1] doubleValue]];
                    CLLocation *loctotest = [[CLLocation alloc] initWithLatitude:coordtotest.latitude longitude:coordtotest.longitude];
                    CLLocationDistance distclloc = [loctotest distanceFromLocation:areaobj];
                    if ((NSInteger)distclloc <= distance) {
                        supported = YES;
                    }
                }
                if (supported == YES) {
                    NSLog(@"Supported by this app. Do something here");
                } else {
                    NSLog(@"Not supported by this app. Do something here");
                }
            } else {
                NSLog(@"Areas not a JSON Array. Do something here");
            }
        } else {
            NSLog(@"Not a JSON Dictionary. Do something here");
        }
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON){
        NSLog(@"Error found. Do something here");
    }];
    [operation start];
}

#pragma mark - Stuff to ignore in this project (Below)
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
