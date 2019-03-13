//
//  DeliverCreateDetail.h
//  BuLaoBan
//
//  Created by souxiuyun on 2019/3/13.
//  Copyright © 2019 XX. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DeliverCreateDetail : NSObject

/**
 发货细码单
 */
@property (nonatomic, copy) NSString *packingList;

/**
 销售单详细ID
 */
@property (nonatomic, copy) NSString *orderDetailId;

/**
 样品ID
 */
@property (nonatomic, copy) NSString *sampleId;

/**
 色卡ID
 */
@property (nonatomic, copy) NSString *colorId;

/**
 件数数量
 */
@property (nonatomic, copy) NSString *packageNum;

/**
 件数单位
 */
@property (nonatomic, copy) NSString *packageUnit;

/**
 发货数量*
 */
@property (nonatomic, copy) NSString *num;

/**
 数量单位*
 */
@property (nonatomic, copy) NSString *numUnit;

/**
 单价
 */
@property (nonatomic, copy) NSString *unitPrice;

/**
 税率
 */
@property (nonatomic, copy) NSString *taxRate;

/**
 附加费
 */
@property (nonatomic, copy) NSString *extraCharge;

/**
 价格
 */
@property (nonatomic, copy) NSString *price;

/**
 未税金额
 */
@property (nonatomic, copy) NSString *noTaxPrice;

/**
 税额
 */
@property (nonatomic, copy) NSString *taxPrice;

/**
 汇率
 */
@property (nonatomic, copy) NSString *exchangeRate;

/**
 外币金额
 */
@property (nonatomic, copy) NSString *foreignPrice;

/**
 备注
 */
@property (nonatomic, copy) NSString *remark;


@end

NS_ASSUME_NONNULL_END
