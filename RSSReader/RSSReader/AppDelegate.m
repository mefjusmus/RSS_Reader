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
    self.window.rootViewController = [[[MainViewController alloc] initWithParser: parser] autorelease];
    parser.alertDelegate = (MainViewController *) self.window.rootViewController;
    [self.window makeKeyAndVisible];
    
    return YES;
}

@end
