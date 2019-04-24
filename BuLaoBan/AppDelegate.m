//
//  AppDelegate.m
//  BuLaoBan
//
//  Created by apple on 2019/1/24.
//  Copyright © 2019年 XX. All rights reserved.
//

#import "AppDelegate.h"
#import "LoginViewController.h"
#import "HomeRootViewController.h"
#import "LBTabBarController.h"

#import "DetailViewController.h"
#import "ListViewController.h"
#import <Bugtags/Bugtags.h>

//微信
#import "WXApi.h"
#import "WXApiManager.h"



@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    
    
    //初始化微信
    [WXApi registerApp:WXID
       withDescription:WXSECRET];
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];

    _mainTab = [[LBTabBarController alloc]init];
    _mainTab.selectedIndex = 1;
    //设置状态栏字体颜色
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    //列表界面
    self.list = [[ListViewController alloc]init];
    LBNavigationController *masterNav = [[LBNavigationController alloc]initWithRootViewController:_list];
    //模型界面
    self.detail = [[DetailViewController alloc]init];
   // LBNavigationController *detailNav = [[LBNavigationController alloc]initWithRootViewController:_detail];
    //合成splitviewcontroller
    self.splitViewController = [[UISplitViewController alloc]init];
    [self.splitViewController setPresentsWithGesture:YES];
    self.splitViewController.viewControllers = @[masterNav,_mainTab];
    self.splitViewController.delegate = _detail;
    LBNavigationController *lbVc = [[LBNavigationController alloc]initWithRootViewController:[[LoginViewController alloc]init]];
    User *user = [[UserPL shareManager] getLoginUser];
    if (user.userId.length>0) {
        if ([user.defutecompanyName isEqualToString:@"示例样品间"]) {
            self.window.rootViewController = lbVc;
        }else{
            //选择角色
            self.window.rootViewController = lbVc;
        }
    }else{
        self.window.rootViewController = lbVc;
    }
    
    self.splitViewController.maximumPrimaryColumnWidth = 100.0;
    [Bugtags startWithAppKey:@"a1bc1972953ced15a53bcd43caae981f" invocationEvent:BTGInvocationEventBubble];
    [self.window makeKeyAndVisible];
    return YES;
}




- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    return  [WXApi handleOpenURL:url delegate:[WXApiManager sharedManager]];
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    return  [WXApi handleOpenURL:url delegate:[WXApiManager sharedManager]];
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
