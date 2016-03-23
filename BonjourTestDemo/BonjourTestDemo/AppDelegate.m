//
//  AppDelegate.m
//  BonjourTestDemo
//
//  Created by AD-iOS on 16/2/23.
//  Copyright © 2016年 Adinnet. All rights reserved.
//

#import "AppDelegate.h"
#import "TestViewController.h"
#import "BoujourServerListViewController.h"

static NSString *kWiTapBonjourType = @"_cooperition._tcp.";

@interface AppDelegate ()<NSNetServiceDelegate, NSStreamDelegate>

@property (strong, nonatomic) TestViewController *testVC;
@property (strong, nonatomic) BoujourServerListViewController *listVC;

@property (nonatomic, strong, readwrite) NSNetService *         server;
@property (nonatomic, assign, readwrite) BOOL                   isServerStarted;
@property (nonatomic, copy,   readwrite) NSString *             registeredName;
@property (nonatomic, strong, readwrite) NSInputStream *        inputStream;
@property (nonatomic, strong, readwrite) NSOutputStream *       outputStream;
@property (nonatomic, assign, readwrite) NSUInteger             streamOpenCount;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.testVC = (TestViewController*)self.window.rootViewController;
    
    self.window.rootViewController = self.testVC;
    [self.window makeKeyAndVisible];
    
    self.server = [[NSNetService alloc]initWithDomain:@"local." type:kWiTapBonjourType name:[UIDevice currentDevice].name port:0];
    self.server.includesPeerToPeer = YES;
    [self.server setDelegate:self];
    [self.server publishWithOptions:NSNetServiceListenForConnections];
    self.isServerStarted = YES;
    
    self.listVC = [self.testVC.storyboard instantiateViewControllerWithIdentifier:@"serverList"];
    self.listVC.type = kWiTapBonjourType;
    self.listVC.localService = self.server;
    [self.listVC startSearchServices];
    [self.testVC presentViewController:self.listVC animated:NO completion:nil];
    
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark - NSNetServiceDelegate

- (void)netServiceDidPublish:(NSNetService *)sender
{
    self.registeredName = self.server.name;
}

@end
