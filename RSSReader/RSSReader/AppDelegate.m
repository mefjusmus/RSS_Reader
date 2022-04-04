//
//  AppDelegate.m
//  RSSReader
//
//  Created by Vladislav Suslov on 3.03.22.
//

#import "AppDelegate.h"
#import "RssXMLParser.h"
#import "MainViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    RssXMLParser *parser = [[RssXMLParser new] autorelease];
    MainViewController *mainViewController = [[[MainViewController alloc] initWithParser: parser]autorelease];
    UINavigationController *navController = [[[UINavigationController alloc] initWithRootViewController: mainViewController] autorelease];
//    self.window.rootViewController = [[[MainViewController alloc] initWithParser: parser] autorelease];
    self.window.rootViewController = navController;
//    parser.alertDelegate = (MainViewController *) self.window.rootViewController;
    parser.alertDelegate = mainViewController;
    [self.window makeKeyAndVisible];
    
    return YES;
}

@end
