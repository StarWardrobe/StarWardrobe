//
//  AppDelegate.m
//  StarWardrobee
//
//  Created by Mac on 16/7/2.
//  Copyright © 2016年 Happy. All rights reserved.
//

#import "AppDelegate.h"
#import "MainViewController.h"
#import "GuideViewController.h"
#import "CommunityViewController.h"
#import "ManViewController.h"
#import "MatchViewController.h"
#import "ShopViewController.h"



typedef void(^block)(void);

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.window = [[UIWindow alloc]initWithFrame:kMainBounds];
    self.window.backgroundColor = [UIColor whiteColor];
    
//    TabBarViewController *rootVC = [[TabBarViewController alloc]init];
    
    
    //引导界面
    GuideViewController *introductionVC = [GuideViewController new];
    
    [self.window addSubview:introductionVC.view];
    
    
    __block GuideViewController *weakSelf = introductionVC;
    [introductionVC enterRootVC:^{
        [weakSelf.view removeFromSuperview];
        
        UITabBarController *tabBarC = [UITabBarController new];
        
        
        UINavigationController *mainNAV = [[UINavigationController alloc]initWithRootViewController:[MainViewController new]];
        mainNAV.tabBarItem.title = @"首页";
        mainNAV.tabBarItem.image =[UIImage imageNamed:@"bottom_home_icon@2x"];
        mainNAV.tabBarItem.selectedImage = [UIImage imageNamed:@"bottom_home_icon_on@3x"];

        UINavigationController *matchNAV = [[UINavigationController alloc]initWithRootViewController:[MatchViewController new]];
        matchNAV.tabBarItem.title = @"搭配";
        matchNAV.tabBarItem.image = [UIImage imageNamed:@"bottom_dapei_icon@2x"];
        matchNAV.tabBarItem.selectedImage = [UIImage imageNamed:@"bottom_dapei_icon_on@3x"];
        UINavigationController *communityNAV = [[UINavigationController alloc]initWithRootViewController:[CommunityViewController new]];
        communityNAV.tabBarItem.title = @"社区";
        communityNAV.tabBarItem.image = [UIImage imageNamed:@"bottom_bbs_icon@3x"];
        communityNAV.tabBarItem.selectedImage = [UIImage imageNamed:@"bottom_bbs_icon_on@2x"];
        UINavigationController *manNAV = [[UINavigationController alloc]initWithRootViewController:[ManViewController new]];
        manNAV.tabBarItem.title = @"男衣帮";
        manNAV.tabBarItem.image = [UIImage imageNamed:@"bottom_clothes_icon@2x"];
        manNAV.tabBarItem.selectedImage = [UIImage imageNamed:@"bottom_clothes_icon_on@3x"];
        UINavigationController *shopNAV = [[UINavigationController alloc]initWithRootViewController:[ShopViewController new]];
        shopNAV.tabBarItem.title = @"购物车";
        shopNAV.tabBarItem.image = [UIImage imageNamed:@"bottom_shopping_icon@2x"];
        shopNAV.tabBarItem.selectedImage = [UIImage imageNamed:@"bottom_shopping_icon_on@3x"];
        
        tabBarC.viewControllers = @[mainNAV,matchNAV,communityNAV,manNAV,shopNAV];
        self.window.rootViewController = tabBarC;
    }];
    
    self.window.rootViewController = weakSelf;
    
    
    [self.window makeKeyAndVisible];

    
    
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

@end
