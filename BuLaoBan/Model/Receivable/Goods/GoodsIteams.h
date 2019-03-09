//
//  GoodsIteams.h
//  BuLaoBan
//
//  Created by souxiuyun on 2019/3/9.
//  Copyright © 2019 XX. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface GoodsIteams : NSObject

/**
 单据类别(0:应收初始单 1:销货单 2:退货单 3:期初应收余额 4:收款单)
 */
@property (nonatomic, copy) NSString *type;

/**
 单据日期
 */
@property (nonatomic, copy) NSString *orderDate;

/**
 单据编号
 */
@property (nonatomic, copy) NSString *orderNo;

/**
 编号
 */
@property (nonatomic, copy) NSString *itemNo;

/**
 品名
 */
@property (nonatomic, copy) NSString *name;

/**
 颜色
 */
@property (nonatomic, copy) NSString *color;

/**
 数量
 */
@property (nonatomic, copy) NSString *num;

/**
 数量单位
 */
@property (nonatomic, copy) NSString *numUnit;
/**
 单价
 */
@property (nonatomic, copy) NSString *unitPrice;

/**
 应收金额
 */
@property (nonatomic, copy) NSString *receivableAmount;

/**
 已收金额
 */
@property (nonatomic, copy) NSString *receiptAmount;




@end

NS_ASSUME_NONNULL_END
