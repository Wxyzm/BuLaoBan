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

- (void)showSaleView{
    [self changeChildViewController:1];
    [_menueView setSelected:0];
}


- (void)changeChildViewController:(NSInteger)sign {
    //获取详细控制器

    AppDelegate *app = (AppDelegate *)[[UIApplication  sharedApplication] delegate];
    if (sign == 2) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"ReceivebarSelected" object:nil];
    }
    app.mainTab.selectedIndex  = sign;
}

@end
