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
    [self setNavBarAppearance];
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    RssXMLParser *parser = [[RssXMLParser new] autorelease];
    MainViewController *mainViewController = [[[MainViewController alloc] initWithParser: parser]autorelease];
    UINavigationController *navController = [[[UINavigationController alloc] initWithRootViewController: mainViewController] autorelease];
    self.window.rootViewController = navController;
    parser.alertDelegate = mainViewController;
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (void) setNavBarAppearance {
    if (@available(iOS 15.0, *)) {
        UINavigationBarAppearance *navBarAppearance = [[UINavigationBarAppearance alloc] init];
//        navBarAppearance.backgroundColor = [UIColor lightGrayColor];
        [navBarAppearance configureWithOpaqueBackground];
        [UINavigationBar appearance].standardAppearance = navBarAppearance;
        [UINavigationBar appearance].scrollEdgeAppearance = navBarAppearance;
    }
}


@end
