//
//  ReceivableItems.h
//  BuLaoBan
//
//  Created by souxiuyun on 2019/3/9.
//  Copyright © 2019 XX. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ReceivableItems : NSObject
/**
 单据日期
 */
@property (nonatomic, copy) NSString *orderDate;
/**
 单据编号
 */
@property (nonatomic, copy) NSString *orderNo;
/**
 已收金额
 */
@property (nonatomic, copy) NSString *receiptAmount;
/**
 应收金额
 */
@property (nonatomic, copy) NSString *receivableAmount;
/**
 销售名称
 */
@property (nonatomic, copy) NSString *sellerName;
/**
 销售ID
 */
@property (nonatomic, copy) NSString *sellerId;
/**
 单据类别(0:应收初始单 1:销货单 2:退货单 3:期初应收余额 4:收款单)
 */
@property (nonatomic, copy) NSString *type;

@end

NS_ASSUME_NONNULL_END
