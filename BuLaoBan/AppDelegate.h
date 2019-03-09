//
//  AppDelegate.h
//  BuLaoBan
//
//  Created by apple on 2019/1/24.
//  Copyright © 2019年 XX. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DetailViewController;
@class ListViewController;
@class LBTabBarController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property(nonatomic,strong)UISplitViewController * splitViewController;
@property(nonatomic,strong)DetailViewController * detail;
@property(nonatomic,strong)ListViewController * list;
@property (strong, nonatomic) LBTabBarController *mainTab;

@end

