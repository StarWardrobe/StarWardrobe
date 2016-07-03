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
        MatchViewController *matchVC = [MatchViewController new];
        matchVC.tabBarItem.title = @"搭配";
        matchVC.tabBarItem.image = [UIImage imageNamed:@"bottom_dapei_icon@2x"];
        matchVC.tabBarItem.selectedImage = [UIImage imageNamed:@"bottom_dapei_icon_on@3x"];
        CommunityViewController *communityVC = [CommunityViewController new];
        communityVC.tabBarItem.title = @"社区";
        communityVC.tabBarItem.image = [UIImage imageNamed:@"bottom_bbs_icon@3x"];
        communityVC.tabBarItem.selectedImage = [UIImage imageNamed:@"bottom_bbs_icon_on@2x"];
        ManViewController *manVC = [ManViewController new];
        manVC.tabBarItem.title = @"男衣帮";
        manVC.tabBarItem.image = [UIImage imageNamed:@"bottom_clothes_icon@2x"];
        manVC.tabBarItem.selectedImage = [UIImage imageNamed:@"bottom_clothes_icon_on@3x"];
        ShopViewController *shopVC = [ShopViewController new];
        shopVC.tabBarItem.title = @"购物车";
        shopVC.tabBarItem.image = [UIImage imageNamed:@"bottom_shopping_icon@2x"];
        shopVC.tabBarItem.selectedImage = [UIImage imageNamed:@"bottom_shopping_icon_on@3x"];
        tabBarC.viewControllers = @[mainNAV,matchVC,communityVC,manVC,shopVC];
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
