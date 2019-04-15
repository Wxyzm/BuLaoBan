//
//  SaleSCustomer.h
//  BuLaoBan
//
//  Created by souxiuyun on 2019/4/3.
//  Copyright © 2019 XX. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SaleSCustomer : NSObject

/**
 客户ID
 */
@property (nonatomic,copy) NSString  *customerId;

/**
 客户名称
 */
@property (nonatomic,copy) NSString  *customerName;

/**
 联系电话
 */
@property (nonatomic,copy) NSString  *customerMobile;

/**
 销售次数
 */
@property (nonatomic,copy) NSString  *sellTimes;

/**
 销售样品款数
 */
@property (nonatomic,copy) NSString  *sellSampleCount;

/**
 销售数量
 */
@property (nonatomic,strong) NSMutableArray *sellNum;

/**
 销售金额
 */
@property (nonatomic,strong) NSMutableArray *sellPrice;

/**
 销货金额
 */
@property (nonatomic,strong) NSMutableArray *deliverPrice;


@end

NS_ASSUME_NONNULL_END
