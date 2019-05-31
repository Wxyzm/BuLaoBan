//
//  SellOrderDeliverDetail.h
//  BuLaoBan
//
//  Created by souxiuyun on 2019/3/27.
//  Copyright © 2019 XX. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SellOrderDeliverDetail : NSObject
/**
 销货单ID
 */
@property (nonatomic,copy) NSString *deliverId;

/**
 公司名称
 */
@property (nonatomic,copy) NSString *companyName;

/**
 公司地址
 */
@property (nonatomic,copy) NSString *companyAddress;

/**
 发货单号
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
 备注
 */
@property (nonatomic,copy) NSString *remark;

/**
 价格单位【11:元 12:美元】
 */
@property (nonatomic,copy) NSString *priceUnit;

/**
 应收金额
 */
@property (nonatomic,copy) NSString *receivablePrice;

/**
 预收款
 */
@property (nonatomic,copy) NSString *depositPrice;

/**
 收款金额
 */
@property (nonatomic,copy) NSString *receiptPrice;

/**
 销售单类型【0:剪样 1:大货】
 */
@property (nonatomic,copy) NSString *type;

/**
 客户Id
 */
@property (nonatomic,copy) NSString *customerId;

/**
 客户名称
 */
@property (nonatomic,copy) NSString *customerName;

/**
销售Id
 */
@property (nonatomic,copy) NSString *sellerId;

/**
 销售姓名
 */
@property (nonatomic,copy) NSString *sellerName;

/**
 销售电话
 */
@property (nonatomic,copy) NSString *sellerMobile;

/**
 创建人
 */
@property (nonatomic,copy) NSString *creatorName;

/**
 仓库名称
 */
@property (nonatomic,copy) NSString *warehouseName;

/**
 发货单详细
 */
@property (nonatomic,strong) NSMutableArray *details;
/**
 结算账户
 */
@property (nonatomic,strong) NSString *companyAccountName;
/**
 结算账户ID
 */
@property (nonatomic,strong) NSString *companyAccountId;

@property (nonatomic,strong) NSMutableArray *sampleList;


//匹数  米数
@property (nonatomic,assign) NSInteger pieces;
@property (nonatomic,assign) CGFloat meet;
@property (nonatomic,assign) CGFloat totMoney; //合计
@property (nonatomic,assign) CGFloat othMoney; //其他
@property (nonatomic,assign) CGFloat setMoney; //总计 = 合计 +其他


- (void)getsampleListWithSellOrderDeliverDetail;


@end

NS_ASSUME_NONNULL_END
