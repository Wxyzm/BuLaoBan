//
//  LBNavigationController.m
//  XianYu
//
//  Created by li  bo on 16/5/28.
//  Copyright © 2016年 li  bo. All rights reserved.
//

#import "LBNavigationController.h"
//黄色导航栏
#define NavBarColor [UIColor colorWithRed:250/255.0 green:227/255.0 blue:111/255.0 alpha:1.0]
@interface LBNavigationController ()

@end

@implementation LBNavigationController

+ (void)load
{


//    UIBarButtonItem *item=[UIBarButtonItem appearanceWhenContainedIn:self, nil ];
//    NSMutableDictionary *dic=[NSMutableDictionary dictionary];
//    dic[NSFontAttributeName]=[UIFont systemFontOfSize:15];
//    dic[NSForegroundColorAttributeName]=[UIColor blackColor];
//    [item setTitleTextAttributes:dic forState:UIControlStateNormal];
//
//    UINavigationBar *bar = [UINavigationBar appearanceWhenContainedInInstancesOfClasses:@[self]];
//
//    [bar setBackgroundImage:[UIImage imageWithColor:NavBarColor] forBarMetrics:UIBarMetricsDefault];
//    NSMutableDictionary *dicBar=[NSMutableDictionary dictionary];
//
//    dicBar[NSFontAttributeName]=[UIFont systemFontOfSize:15];
//    [bar setTitleTextAttributes:dic];

}

- (void)viewDidLoad {
    [super viewDidLoad];
  //  [[UINavigationBar appearance] setShadowImage:[[UIImage alloc] init]];
    [[UINavigationBar appearance] setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    
    self.navigationBar.barTintColor =UIColorFromRGB(WhiteColorValue);
    [self.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:17]
       ,NSForegroundColorAttributeName:UIColorFromRGB(BlackColorValue)
       }];
    self.navigationBar.translucent = NO;
}


-(void)viewWillAppear:(BOOL)animated
{
    
 //   [[UINavigationBar appearance] setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
//    [[UINavigationBar appearance] setShadowImage:[[UIImage alloc] init]];
    // Modify the color of UITextField's cursor when inputing text.
   // [[UITextField appearance] setTintColor:UIColorFromRGB(0x333333)];
    
    [self.navigationBar setTitleTextAttributes:
     
     @{NSFontAttributeName:[UIFont systemFontOfSize:17]
       ,NSForegroundColorAttributeName:UIColorFromRGB(BlackColorValue)
       }];
    self.navigationBar.translucent = NO;
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{

    if (self.viewControllers.count > 0) {
        
        viewController.hidesBottomBarWhenPushed = YES;
    }

    return [super pushViewController:viewController animated:animated];
}








@end
