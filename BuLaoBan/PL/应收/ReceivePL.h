//
//  ReceivePL.h
//  BuLaoBan
//
//  Created by souxiuyun on 2019/3/11.
//  Copyright © 2019 XX. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ReceivePL : NSObject

/**
 获取应收对账单/单-按客户
 */
+ (void)Receive_receiveGetReceivableStatementOrderCustomer:(NSString *)Customer
                                         andorderDateStart:(NSString *)orderDateStart
                                           andorderDateEnd:(NSString *)orderDateEnd
                                           WithReturnBlock:(PLReturnValueBlock)returnBlock
                                             andErrorBlock:(PLErrorCodeBlock)errorBlock;

/**
 获取应收对账单/单-按销售
 */
+ (void)Receive_receiveGetReceivableStatementOrderSeller:(NSString *)Seller
                                       andorderDateStart:(NSString *)orderDateStart
                                         andorderDateEnd:(NSString *)orderDateEnd
                                         WithReturnBlock:(PLReturnValueBlock)returnBlock
                                           andErrorBlock:(PLErrorCodeBlock)errorBlock;


/**
 获取应收对账单/货品-按客户
 */
+ (void)Receive_receiveGetReceivableStatementSampleCustomer:(NSString *)Customer
                                          andorderDateStart:(NSString *)orderDateStart
                                            andorderDateEnd:(NSString *)orderDateEnd
                                            WithReturnBlock:(PLReturnValueBlock)returnBlock
                                              andErrorBlock:(PLErrorCodeBlock)errorBlock;


/**
 获取应收对账单/货品-按销售
 */
+ (void)Receive_receiveGetReceivableStatementSampleSeller:(NSString *)Seller
                                        andorderDateStart:(NSString *)orderDateStart
                                          andorderDateEnd:(NSString *)orderDateEnd
                                          WithReturnBlock:(PLReturnValueBlock)returnBlock
                                            andErrorBlock:(PLErrorCodeBlock)errorBlock;


/**
 获取应收账款统计-按客户
 */
+ (void)Receive_receiveGetReceivableStatisticsCustomer:(NSString *)Customer
                                     andorderDateStart:(NSString *)orderDateStart
                                       andorderDateEnd:(NSString *)orderDateEnd
                                       WithReturnBlock:(PLReturnValueBlock)returnBlock
                                         andErrorBlock:(PLErrorCodeBlock)errorBlock;


/**
 获取应收账款统计-按销售
 */
+ (void)Receive_receiveGetReceivableStatisticsSeller:(NSString *)Seller
                                   andorderDateStart:(NSString *)orderDateStart
                                     andorderDateEnd:(NSString *)orderDateEnd
                                     WithReturnBlock:(PLReturnValueBlock)returnBlock
                                       andErrorBlock:(PLErrorCodeBlock)errorBlock;


@end

NS_ASSUME_NONNULL_END
