//
//  Deliver.h
//  BuLaoBan
//
//  Created by souxiuyun on 2019/3/13.
//  Copyright © 2019 XX. All rights reserved.
//  x销货单

#import <Foundation/Foundation.h>
@class DeliverCreateDetail;
NS_ASSUME_NONNULL_BEGIN

@interface Deliver : NSObject
/**
 销售单ID
 */
@property (nonatomic, copy) NSString *sellOrderId;

/**
 发货日期*
 */
@property (nonatomic, copy) NSString *deliverDate;

/**
 备注
 */
@property (nonatomic, copy) NSString *remark;

/**
 销售员ID
 */
@property (nonatomic, copy) NSString *sellerId;

/**
 客户ID
 */
@property (nonatomic, copy) NSString *customerId;

/**
 价格单位【11:元 12:美元】
 */
@property (nonatomic, copy) NSString *priceUnit;

/**
 付款方式
 */
@property (nonatomic, copy) NSString *payType;

/**
 预收款
 */
@property (nonatomic, copy) NSString *depositPrice;

/**
 剩余应收款
 */
@property (nonatomic, copy) NSString *receivablePrice;

/**
 订单类型【0:剪样 1:大货】
 */
@property (nonatomic, copy) NSString *type;

/**
 计税类型【0:不计税 1:应税内含 2:应税外加】
 */
@property (nonatomic, copy) NSString *taxType;

/**
 付款期限
 */
@property (nonatomic, copy) NSString *payDeadline;

/**
 仓库ID*
 */
@property (nonatomic, copy) NSString *warehouseId;

/**
 发货单详细
 */
@property (nonatomic, strong) NSMutableArray *details;


@property (nonatomic, strong) NSMutableArray *packingListDetail;

@end

NS_ASSUME_NONNULL_END
