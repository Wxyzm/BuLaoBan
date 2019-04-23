//
//  ListViewController.m
//  BuLaoBan
//
//  Created by apple on 2019/2/22.
//  Copyright © 2019年 XX. All rights reserved.
//

#import "ListViewController.h"
#import "MenueView.h"
#import "DetailViewController.h"
#import "LBTabBarController.h"
@interface ListViewController ()
@property (strong, nonatomic) MenueView *menueView;

@end

@implementation ListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.needHideNavBar = YES;
    _menueView = [[MenueView alloc]initWithFrame:CGRectMake(0, 0, 100, ScreenHeight)];
    [self.view addSubview:_menueView];
    self.view.backgroundColor = [UIColor orangeColor];

    WeakSelf(self);
    _menueView.returnBlock = ^(NSInteger index) {
        [weakself changeChildViewController:index];
    };
}

- (void)changeChildViewController:(NSInteger)sign {
    //获取详细控制器
//    UINavigationController *detailNAV = [self.splitViewController.viewControllers lastObject];
//    [detailNAV popToRootViewControllerAnimated:YES];
//    DetailViewController *detatilVC = (DetailViewController*)[detailNAV viewControllers][0];
//    [detatilVC changeChildViewController:sign];
    AppDelegate *app = (AppDelegate *)[[UIApplication  sharedApplication] delegate];
  //  UIWindow *window = [UIApplication sharedApplication].keyWindow;
    if (sign == 2) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"ReceivebarSelected" object:nil];

    }
    app.mainTab.selectedIndex  = sign;
    
    
}

@end
