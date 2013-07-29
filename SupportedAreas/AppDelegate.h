//
//  AppDelegate.h
//  SupportedAreas
//
//  Created by Barry Teoh on 7/30/13.
//  Copyright (c) 2013 perceptionz.net. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate> {
    BOOL supported_or_not;
    BOOL supported_or_not_error;
}

@property (strong, nonatomic) UIWindow *window;

@end
