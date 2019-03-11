//
//  ReceivePL.m
//  BuLaoBan
//
//  Created by souxiuyun on 2019/3/11.
//  Copyright © 2019 XX. All rights reserved.
//

#import "ReceivePL.h"
//账单model
#import "ReceivableCustomers.h"
#import "receivableGoods.h"
#import "ReceivableItems.h"

@implementation ReceivePL
/**
 获取应收对账单/单-按客户
 */
+ (void)Receive_receiveGetReceivableStatementOrderCustomer:(NSString *)Customer
                                         andorderDateStart:(NSString *)orderDateStart
                                           andorderDateEnd:(NSString *)orderDateEnd
                                           WithReturnBlock:(PLReturnValueBlock)returnBlock
                                             andErrorBlock:(PLErrorCodeBlock)errorBlock{
    User *user = [[UserPL shareManager] getLoginUser];
    NSDictionary *dic = @{@"companyId":user.defutecompanyId,@"key":Customer.length>0?Customer:@"",@"orderDateStart":@"",@"orderDateEnd":orderDateEnd};
    [HUD showLoading:nil];
    [[HttpClient sharedHttpClient] requestGET:@"finance/receivable/statement/order/customer" Withdict:dic WithReturnBlock:^(id returnValue) {
        NSMutableArray *dataArr = [receivableGoods mj_objectArrayWithKeyValuesArray:returnValue[@"receivableCustomers"]];
        [HUD cancel];
        returnBlock(dataArr);
    } andErrorBlock:^(NSString *msg) {
       [HUD cancel];
        errorBlock(msg);
    }];
}

/**
 获取应收对账单/单-按销售
 */
+ (void)Receive_receiveGetReceivableStatementOrderSeller:(NSString *)Seller
                                       andorderDateStart:(NSString *)orderDateStart
                                         andorderDateEnd:(NSString *)orderDateEnd
                                         WithReturnBlock:(PLReturnValueBlock)returnBlock
                                           andErrorBlock:(PLErrorCodeBlock)errorBlock{
    User *user = [[UserPL shareManager] getLoginUser];
    NSDictionary *dic = @{@"companyId":user.defutecompanyId,@"key":Seller.length>0?Seller:@"",@"orderDateStart":@"",@"orderDateEnd":orderDateEnd};
    [HUD showLoading:nil];
    [[HttpClient sharedHttpClient] requestGET:@"finance/receivable/statement/order/seller" Withdict:dic WithReturnBlock:^(id returnValue) {
        NSMutableArray *dataArr = [receivableGoods mj_objectArrayWithKeyValuesArray:returnValue[@"receivableSellers"]];
        [HUD cancel];
        returnBlock(dataArr);
    } andErrorBlock:^(NSString *msg) {
       [HUD cancel];
        errorBlock(msg);
    }];
}


/**
 获取应收对账单/货品-按客户
 */
+ (void)Receive_receiveGetReceivableStatementSampleCustomer:(NSString *)Customer
                                          andorderDateStart:(NSString *)orderDateStart
                                            andorderDateEnd:(NSString *)orderDateEnd
                                            WithReturnBlock:(PLReturnValueBlock)returnBlock
                                              andErrorBlock:(PLErrorCodeBlock)errorBlock{
    User *user = [[UserPL shareManager] getLoginUser];
    NSDictionary *dic = @{@"companyId":user.defutecompanyId,@"key":Customer.length>0?Customer:@"",@"orderDateStart":@"",@"orderDateEnd":orderDateEnd};
    [HUD showLoading:nil];
    [[HttpClient sharedHttpClient] requestGET:@"finance/receivable/statement/sample/customer" Withdict:dic WithReturnBlock:^(id returnValue) {
        NSMutableArray *dataArr = [receivableGoods mj_objectArrayWithKeyValuesArray:returnValue[@"receivableCustomers"]];
         [HUD cancel];
        returnBlock(dataArr);
    } andErrorBlock:^(NSString *msg) {
       [HUD cancel];
        errorBlock(msg);
    }];
}


/**
 获取应收对账单/货品-按销售
 */
+ (void)Receive_receiveGetReceivableStatementSampleSeller:(NSString *)Seller
                                        andorderDateStart:(NSString *)orderDateStart
                                          andorderDateEnd:(NSString *)orderDateEnd
                                          WithReturnBlock:(PLReturnValueBlock)returnBlock
                                            andErrorBlock:(PLErrorCodeBlock)errorBlock{
    User *user = [[UserPL shareManager] getLoginUser];
    NSDictionary *dic = @{@"companyId":user.defutecompanyId,@"key":Seller.length>0?Seller:@"",@"orderDateStart":@"",@"orderDateEnd":orderDateEnd};
    [HUD showLoading:nil];
    [[HttpClient sharedHttpClient] requestGET:@"finance/receivable/statement/sample/seller" Withdict:dic WithReturnBlock:^(id returnValue) {
        NSMutableArray *dataArr = [receivableGoods mj_objectArrayWithKeyValuesArray:returnValue[@"receivableSellers"]];
        [HUD cancel];
        returnBlock(dataArr);
    } andErrorBlock:^(NSString *msg) {
       [HUD cancel];
        errorBlock(msg);
    }];
}


/**
 获取应收账款统计-按客户
 */
+ (void)Receive_receiveGetReceivableStatisticsCustomer:(NSString *)Customer
                                     andorderDateStart:(NSString *)orderDateStart
                                       andorderDateEnd:(NSString *)orderDateEnd
                                       WithReturnBlock:(PLReturnValueBlock)returnBlock
                                         andErrorBlock:(PLErrorCodeBlock)errorBlock{
    User *user = [[UserPL shareManager] getLoginUser];
    NSDictionary *dic = @{@"companyId":user.defutecompanyId,@"key":Customer.length>0?Customer:@"",@"orderDateStart":@"",@"orderDateEnd":orderDateEnd};
    [HUD showLoading:nil];
    [[HttpClient sharedHttpClient] requestGET:@"finance/receivable/statistics/customer" Withdict:dic WithReturnBlock:^(id returnValue) {
        NSMutableArray *dataArr = [receivableGoods mj_objectArrayWithKeyValuesArray:returnValue[@"receivableSellers"]];
        [HUD cancel];
        returnBlock(dataArr);
    } andErrorBlock:^(NSString *msg) {
       [HUD cancel];
        errorBlock(msg);
    }];
}


/**
 获取应收账款统计-按销售
 */
+ (void)Receive_receiveGetReceivableStatisticsSeller:(NSString *)Seller
                                   andorderDateStart:(NSString *)orderDateStart
                                     andorderDateEnd:(NSString *)orderDateEnd
                                     WithReturnBlock:(PLReturnValueBlock)returnBlock
                                       andErrorBlock:(PLErrorCodeBlock)errorBlock{
    User *user = [[UserPL shareManager] getLoginUser];
    NSDictionary *dic = @{@"companyId":user.defutecompanyId,@"key":Seller.length>0?Seller:@"",@"orderDateStart":@"",@"orderDateEnd":orderDateEnd};
    [HUD showLoading:nil];
    [[HttpClient sharedHttpClient] requestGET:@"finance/receivable/statistics/seller" Withdict:dic WithReturnBlock:^(id returnValue) {
        NSMutableArray *dataArr = [receivableGoods mj_objectArrayWithKeyValuesArray:returnValue[@"receivableSellers"]];
        [HUD cancel];
        returnBlock(dataArr);
    } andErrorBlock:^(NSString *msg) {
         [HUD cancel];
        errorBlock(msg);
    }];
}

@end
