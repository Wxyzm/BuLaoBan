//
//  DetailViewController.m
//  BuLaoBan
//
//  Created by apple on 2019/2/22.
//  Copyright © 2019年 XX. All rights reserved.
//

#import "DetailViewController.h"
#import "HomeVCHeader.h"

@interface DetailViewController ()
@property (strong, nonatomic) SaleViewController *saleController;            //销售
@property (strong, nonatomic) GoodsViewController *goodsController;          //货品
@property (strong, nonatomic) ReceivableViewController *receivableController;//应收
@property (strong, nonatomic) CustomerViewController *customerController;    //客户

@property (strong, nonatomic) MineInfoViewController *mineInfoViewController;    //客户

@property (strong, nonatomic) SettingViewController *settingViewController;    //客户

//当前视图
@property(nonatomic, strong)BaseViewController *currentViewController;
//视图控制器数组
@property(nonatomic, strong)NSMutableArray *viewControllerArray;

@end

@implementation DetailViewController{
    
    NSInteger _index;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}
-(void)loadView{
    [super loadView];
    //添加视图方法
    [self addViewController];
}



- (void)addViewController {
    //视图控制器数组
    _viewControllerArray = [NSMutableArray array];
    
    //设置子视图的尺寸
    CGRect rect = CGRectMake(0, 0, ScreenWidth , ScreenHeight);
    
    //实例化子视图的vc
    _saleController = [SaleViewController new];
    _receivableController = [ReceivableViewController new];
    _goodsController = [GoodsViewController new];
    _customerController = [CustomerViewController new];
    _mineInfoViewController = [MineInfoViewController new];
    _settingViewController = [SettingViewController new];
    
    //将子视图的vc添加到一个可变数组中, 方便处理
    [_viewControllerArray addObject:_saleController];
    [_viewControllerArray addObject:_receivableController];
    [_viewControllerArray addObject:_goodsController];
    [_viewControllerArray addObject:_customerController];
    [_viewControllerArray addObject:_mineInfoViewController];
    [_viewControllerArray addObject:_settingViewController];
    
    //偷懒
    for (NSInteger i = 0; i < 6; i++) {
        [_viewControllerArray[i] view].frame = rect;
    }
    
    //这块是实现能够在外面点击不同的button进入不同页面的关键, 通过属性传值确定视图的内部布局
    [self.view addSubview:[_viewControllerArray[_index] view]];
    //将当前子视图设置为传值确定的子视图
    _currentViewController = _viewControllerArray[_index];
    //将子视图添加到父视图上
    [self addChildViewController:_viewControllerArray[_index]];
    
}
- (void)changeChildViewController:(NSInteger)sign {
    //通过block传递过来的tag值判断切换视图
    //如果点击的button在当前页, 则废弃点击操作
    if ((_currentViewController == _saleController && sign == 0) ||
        (_currentViewController == _receivableController  && sign == 1) ||
        (_currentViewController == _goodsController  && sign == 2) ||
        (_currentViewController == _customerController && sign == 3) ||
        (_currentViewController == _mineInfoViewController && sign == 4) ||
        (_currentViewController == _settingViewController && sign == 5)) {
        return;
    }
    else{
        [self replaceOldViewCroller:_currentViewController newViewController:_viewControllerArray[sign]];
    }
}


#pragma mark 切换子视图方法

- (void)replaceOldViewCroller:(BaseViewController *)oldViewController newViewController:(BaseViewController *)newViewController{
    
    //将新的子视图先添加到父视图上
    [self addChildViewController:newViewController];
    
    //这个方法是负责对子视图进行切换的, 有几个参数, 前两个参数是切换前子视图和切换后子视图, 这个方法有个条件, 就是一定要两个视图都是当前父视图的子视图才可以切换, 所以在上面才会先添加子视图, 后面的参数都应该很熟悉了, duration延时, options选项, 可以将动画的枚举类型给他, animations更不用说了, 动画效果, 闭包的bool参数finish代表的是切换是否成功
    [self transitionFromViewController:oldViewController toViewController:newViewController duration:.3 options:UIViewAnimationOptionTransitionCrossDissolve  animations:nil completion:^(BOOL finished) {
        if (finished) {
            //切换后将老视图移除, 新的视图设置为当前视图
            [oldViewController removeFromParentViewController];
            _currentViewController = newViewController;
            
        }else
        {
            _currentViewController = oldViewController;
            
        }
    }];
}



@end
