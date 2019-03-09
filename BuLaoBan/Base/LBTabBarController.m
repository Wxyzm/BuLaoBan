//
//  LBTabBarController.m
//  XianYu
//
//  Created by li  bo on 16/5/28.
//  Copyright © 2016年 li  bo. All rights reserved.
//

#import "LBTabBarController.h"
#import "LBNavigationController.h"



#import "HomeVCHeader.h"

@interface LBTabBarController ()<UITabBarControllerDelegate>
@property (strong, nonatomic) SaleViewController *saleController;            //销售
@property (strong, nonatomic) GoodsViewController *goodsController;          //货品
@property (strong, nonatomic) ReceivableViewController *receivableController;//应收
@property (strong, nonatomic) CustomerViewController *customerController;    //客户

@property (strong, nonatomic) MineInfoViewController *mineInfoViewController;    //客户

@property (strong, nonatomic) SettingViewController *settingViewController;    //客户

@end

@implementation LBTabBarController

#pragma mark - 第一次使用当前类的时候对设置UITabBarItem的主题
+ (void)initialize
{
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont fontWithName:@"Helvetica"size:11.0f],NSFontAttributeName, nil] forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont fontWithName:@"Helvetica"size:11.0f],NSFontAttributeName, nil] forState:UIControlStateSelected];
}



- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabBar.barTintColor = [UIColor whiteColor];
    self.tabBar.tintColor = UIColorFromRGB(0x333333);
    self.tabBar.hidden = YES;
    [self setUpAllChildVc];
  
    self.delegate = self;
    _barIndex= 0;


}
- (void)viewWillLayoutSubviews{
    
    CGRect tabFrame =self.tabBar.frame;
    
    tabFrame.size.height= 0.001;
    
    tabFrame.origin.y= self.view.frame.size.height- 0.001;
    
    self.tabBar.frame= tabFrame;
    
}
#pragma mark - ------------------------------------------------------------------
#pragma mark - 初始化tabBar上除了中间按钮之外所有的按钮

- (void)setUpAllChildVc
{

    MineInfoViewController *mineinfoVc =[[MineInfoViewController alloc] init];
    [self setUpOneChildVcWithVc:mineinfoVc Image:@"" selectedImage:@"" title:@""];
    
    SaleViewController *SaleVC  =[[SaleViewController alloc] init];
    [self setUpOneChildVcWithVc:SaleVC  Image:@"" selectedImage:@"" title:@""];

    ReceivableViewController *ReceivaVC = [[ReceivableViewController alloc] init];
    [self setUpOneChildVcWithVc:ReceivaVC Image:@"" selectedImage:@"" title:@""];
    
    GoodsViewController *GoodsVC = [[GoodsViewController alloc] init];
    [self setUpOneChildVcWithVc:GoodsVC Image:@"" selectedImage:@"" title:@""];

    CustomerViewController *CustomerVC = [[CustomerViewController alloc] init];
    [self setUpOneChildVcWithVc:CustomerVC Image:@"" selectedImage:@"" title:@""];

    SettingViewController *SettingVC = [[SettingViewController alloc] init];
    [self setUpOneChildVcWithVc:SettingVC Image:@"" selectedImage:@"" title:@""];

}

#pragma mark - 初始化设置tabBar上面单个按钮的方法

/**
 *  @author li bo, 16/05/10
 *
 *  设置单个tabBarButton
 *
 *  @param Vc            每一个按钮对应的控制器
 *  @param image         每一个按钮对应的普通状态下图片
 *  @param selectedImage 每一个按钮对应的选中状态下的图片
 *  @param title         每一个按钮对应的标题
 */
- (void)setUpOneChildVcWithVc:(UIViewController *)Vc Image:(NSString *)image selectedImage:(NSString *)selectedImage title:(NSString *)title
{
    
    
    LBNavigationController *nav = [[LBNavigationController alloc] initWithRootViewController:Vc];


  //  Vc.view.backgroundColor = [self randomColor];

    UIImage *myImage = [UIImage imageNamed:image];
    myImage = [myImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];

    //tabBarItem，是系统提供模型，专门负责tabbar上按钮的文字以及图片展示
    Vc.tabBarItem.image = myImage;
    [Vc.tabBarItem setTitlePositionAdjustment:UIOffsetMake(0, -3)];
    [Vc.tabBarItem setImageInsets:UIEdgeInsetsMake(-3, 0, 3, 0)];
    UIImage *mySelectedImage = [UIImage imageNamed:selectedImage];
    mySelectedImage = [mySelectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];

    Vc.tabBarItem.selectedImage = mySelectedImage;

    Vc.tabBarItem.title = title;

    Vc.navigationItem.title = title;

    [self addChildViewController:nav];
    
}






/**
 tabBar代理点击方法
 
 @param tabBar tabBar
 @param item item
 */
-(void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item
{
    NSArray* arr=self.tabBar.items;
    
    for (int i=0; i<arr.count; i++)
    {
        
        if ([item isEqual:self.tabBar.items[i]])
        {
            _barIndex = i;
            
        }
    }
    if (_barIndex == 0) {
       
    }else if (_barIndex == 1){
       
    }else if (_barIndex ==2){

    }else if (_barIndex ==3){
        
    }
    
    
    
    
    NSLog(@"的值是：%ld",(long)_barIndex);
    
}
@end
