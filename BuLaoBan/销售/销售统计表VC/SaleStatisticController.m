//
//  SaleStatisticController.m
//  BuLaoBan
//
//  Created by souxiuyun on 2019/4/2.
//  Copyright © 2019 XX. All rights reserved.
//

#import "SaleStatisticController.h"
#import "SaleSTopView.h"
#import "SaleSSample.h"
#import "SaleSCustomer.h"
#import "SaleSGoodsCell.h"
#import "SaleSGoodsTopCell.h"
#import "SaleSCustomerCell.h"
#import "SaleSCustomerListCell.h"

@interface SaleStatisticController ()

@property (nonatomic,strong) SaleSTopView *topView;


@end

@implementation SaleStatisticController{
    
    NSInteger _index;
    NSMutableArray *_dataArr1;
    NSMutableArray *_dataArr2;
    NSMutableArray *_dataArr3;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"销售统计表";
    [self setBarBackBtnWithImage:nil];
    [self initDatas];
    [self initUI];
    [self statisticsList];
}

- (void)initDatas{
    _index = 0;
    _dataArr1 = [NSMutableArray arrayWithCapacity:0];
    _dataArr2 = [NSMutableArray arrayWithCapacity:0];
    _dataArr3 = [NSMutableArray arrayWithCapacity:0];
}


- (void)initUI{
    [self.view addSubview:self.topView];
    WeakSelf(self);
    self.topView.returnBlock = ^(NSInteger tag) {
        if (tag ==0) {
            [weakself statisticsList];
        }else if (tag ==1){
            [weakself statisticscustomerList];
        }else{
            [weakself statisticssellerList];
        }
        
    };
}
#pragma mark----获取销售统计
- (void)statisticsList{
    User *user  =[[UserPL shareManager] getLoginUser];
    NSDictionary *dic = @{@"companyId":user.defutecompanyId
                          };
    [[HttpClient sharedHttpClient] requestGET:@"/sell/statistics/sample" Withdict:dic WithReturnBlock:^(id returnValue) {
        NSLog(@"%@",returnValue);
    } andErrorBlock:^(NSString *msg) {
        
    }];
}
#pragma mark----获取销售统计详细-按客户
- (void)statisticscustomerList{
    User *user  =[[UserPL shareManager] getLoginUser];
    NSDictionary *dic = @{@"companyId":user.defutecompanyId
                          };
    [[HttpClient sharedHttpClient] requestGET:@"/sell/statistics/customer" Withdict:dic WithReturnBlock:^(id returnValue) {
        NSLog(@"%@",returnValue);
    } andErrorBlock:^(NSString *msg) {
        
    }];
}


#pragma mark---- 获取销售统计详细-按销售员
- (void)statisticssellerList{
    User *user  =[[UserPL shareManager] getLoginUser];
    NSDictionary *dic = @{@"companyId":user.defutecompanyId
                          };
    [[HttpClient sharedHttpClient] requestGET:@"/sell/statistics/seller" Withdict:dic WithReturnBlock:^(id returnValue) {
        NSLog(@"%@",returnValue);
    } andErrorBlock:^(NSString *msg) {
        
    }];
}

-(SaleSTopView *)topView{
    
    if (!_topView ) {
        _topView  = [[SaleSTopView alloc]init];
    }
    return _topView;
    
}


@end
