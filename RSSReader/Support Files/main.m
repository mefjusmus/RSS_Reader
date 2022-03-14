//
//  main.m
//  RSSReader
//
//  Created by Vladislav Suslov on 3.03.22.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

int main(int argc, char * argv[]) {
    NSString * appDelegateClassName;
    @autoreleasepool {
        // Setup code that might create autoreleased objects goes here.
        appDelegateClassName = NSStringFromClass([AppDelegate class]);
        [appDelegateClassName retain];
    }
    return UIApplicationMain(argc, argv, nil, appDelegateClassName);
}
