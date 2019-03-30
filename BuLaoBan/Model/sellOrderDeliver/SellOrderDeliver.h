//
//  SellOrderDeliver.h
//  BuLaoBan
//
//  Created by souxiuyun on 2019/3/27.
//  Copyright © 2019 XX. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SellOrderDeliver : NSObject

/**
 销货单ID
 */
@property (nonatomic,copy) NSString *deliverId;



/**
 销售订单ID
 */
@property (nonatomic,copy) NSString *orderId;
/**
 销货单号
 */
@property (nonatomic,copy) NSString *deliverNo;
/**
 销售订单号
 */
@property (nonatomic,copy) NSString *sellOrderNo;
/**
 发货日期
 */
@property (nonatomic,copy) NSString *deliverDate;
/**
 订单交期
 */
@property (nonatomic,copy) NSString *leadTime;
/**
 客户名称
 */
@property (nonatomic,copy) NSString *customerName;
/**
 销售姓名
 */
@property (nonatomic,copy) NSString *sellerName;
/**
 仓库名称
 */
@property (nonatomic,copy) NSString *warehouseName;
/**
 价格单位【11:元 12:美元】
 */
@property (nonatomic,copy) NSString *priceUnit;
/**
 订单金额
 */
@property (nonatomic,copy) NSString *totalPrice;
/**
 销货金额
 */
@property (nonatomic,copy) NSString *totalDeliverPrice;
/**
 收款金额
 */
@property (nonatomic,copy) NSString *receiptPrice;
/**
 核算状态
 */
@property (nonatomic,copy) NSString *accountingStatus;
/**
 核算状态
 */
@property (nonatomic,copy) NSString *status;
/**
 订单类型
 */
@property (nonatomic,copy) NSString *type;
/**
 订单数量
 */
@property (nonatomic,copy) NSMutableArray *sellNum;
/**
 销货数量
 */
@property (nonatomic,copy) NSMutableArray *deliverNum;


@property (nonatomic,assign) BOOL selected;


@end

NS_ASSUME_NONNULL_END
