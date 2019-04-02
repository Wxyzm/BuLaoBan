//
//  SaleStatisticController.m
//  BuLaoBan
//
//  Created by souxiuyun on 2019/4/2.
//  Copyright © 2019 XX. All rights reserved.
//

#import "SaleStatisticController.h"
#import "SaleSTopView.h"

@interface SaleStatisticController ()

@property (nonatomic,strong) SaleSTopView *topView;


@end

@implementation SaleStatisticController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"销售统计表";
    [self setBarBackBtnWithImage:nil];
    [self initUI];
}

- (void)initUI{
    [self.view addSubview:self.topView];
}


#pragma mark---- get

-(SaleSTopView *)topView{
    
    if (!_topView ) {
        _topView  = [[SaleSTopView alloc]init];
    }
    return _topView;
    
}


@end
