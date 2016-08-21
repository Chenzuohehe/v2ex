//
//  AppDelegate.m
//  v2ex
//
//  Created by MAC on 16/6/29.
//  Copyright © 2016年 chenzuo. All rights reserved.
//

#import "AppDelegate.h"
#import "BaseViewController.h"

#import "MainViewController.h"
#import "LeftMenuViewController.h"
#import "RightMenuViewController.h"

@interface AppDelegate ()
{
    RESideMenu * sideMenuViewController;
}

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    
    MainViewController * rootViewController = [[MainViewController alloc]init];
    UINavigationController * navigationController = [[UINavigationController alloc]initWithRootViewController:rootViewController];
    
    LeftMenuViewController *leftMenuViewController = [[LeftMenuViewController alloc] init];
    RightMenuViewController *rightMenuViewController = [[RightMenuViewController alloc] init];
    
    sideMenuViewController = [[RESideMenu alloc] initWithContentViewController:navigationController
                                                                    leftMenuViewController:leftMenuViewController
                                                                   rightMenuViewController:rightMenuViewController];
    sideMenuViewController.backgroundImage = [UIImage imageNamed:@"backGround"];
    sideMenuViewController.menuPreferredStatusBarStyle = 1; // UIStatusBarStyleLightContent
    sideMenuViewController.delegate = self;
    sideMenuViewController.contentViewShadowColor = [UIColor blackColor];
    sideMenuViewController.contentViewShadowOffset = CGSizeMake(0, 0);
    sideMenuViewController.contentViewShadowOpacity = 0.6;
    sideMenuViewController.contentViewShadowRadius = 6;
    sideMenuViewController.contentViewShadowEnabled = YES;
    self.window.rootViewController = sideMenuViewController;
    
    self.window.backgroundColor = [UIColor yellowColor];

    [self.window makeKeyAndVisible];
    return YES;
}


-(void)sideMenu:(RESideMenu *)sideMenu willShowMenuViewController:(UIViewController *)menuViewController{
    NSLog(@"willShowMenuViewController: %@", NSStringFromClass([menuViewController class]));
    
    if ([[menuViewController class]isSubclassOfClass:[LeftMenuViewController class]]) {
        NSUserDefaults * userDefaulys = [NSUserDefaults standardUserDefaults];
        NSDictionary * userInfoDic = [userDefaulys objectForKey:@"userInfoDic"];
        LeftMenuViewController * leftMianView = (LeftMenuViewController *)menuViewController;
        leftMianView.userInfoDic = userInfoDic;
        
        sideMenuViewController.leftMenuViewController = leftMianView;
        self.window.rootViewController = sideMenuViewController;
    }
    
    
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

@end
