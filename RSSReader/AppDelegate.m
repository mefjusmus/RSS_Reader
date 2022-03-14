//
//  AppDelegate.m
//  RSSReader
//
//  Created by Vladislav Suslov on 3.03.22.
//

#import "AppDelegate.h"
#import "rssParser.h"
#import "MainViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    self.window.rootViewController = [[[MainViewController alloc] init] autorelease];
    [self.window makeKeyAndVisible];

    return YES;
}

@end
