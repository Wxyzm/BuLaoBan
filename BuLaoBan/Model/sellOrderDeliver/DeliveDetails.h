//
//  DeliveDetails.h
//  BuLaoBan
//
//  Created by souxiuyun on 2019/3/27.
//  Copyright © 2019 XX. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DeliveDetails : NSObject

/**
销货单详细ID
 */
@property (nonatomic,copy) NSString *detailId;

/**
 销售单详细ID
 */
@property (nonatomic,copy) NSString *orderDetailId;

/**
 发货细码单
 */
@property (nonatomic,strong) NSString *packingList;

/**
 样品ID
 */
@property (nonatomic,copy) NSString *sampleId;

/**
 图片ID
 */
@property (nonatomic,copy) NSString *samplePicId;

/**
 图片key
 */
@property (nonatomic,copy) NSString *samplePicKey;

/**
 样品编号
 */
@property (nonatomic,copy) NSString *itemNo;

/**
 品名
 */
@property (nonatomic,copy) NSString *name;

/**
 色卡ID
 */
@property (nonatomic,copy) NSString *colorId;

/**
色号
 */
@property (nonatomic,copy) NSString *colorMark;

/**
色名
 */
@property (nonatomic,copy) NSString *colorName;

/**
 发货数量
 */
@property (nonatomic,copy) NSString *num;

/**
 数量单位
 */
@property (nonatomic,copy) NSString *numUnit;

/**
 单价
 */
@property (nonatomic,copy) NSString *unitPrice;

/**
 仓库名称
 */
@property (nonatomic,copy) NSString *warehouseName;

/**
 附加费
 */
@property (nonatomic,copy) NSString *extraCharge;

/**
 备注
 */
@property (nonatomic,copy) NSString *remark;

/**
 件数数量
 */
@property (nonatomic,copy) NSString *packageNum;

/**
 件数单位
 */
@property (nonatomic,copy) NSString *packageUnit;

/**
 未税金额
 */
@property (nonatomic,copy) NSString *noTaxPrice;

/**
 金额
 */
@property (nonatomic,copy) NSString *price;

/**
 税率
 */
@property (nonatomic,copy) NSString *taxRate;

/**
 税额
 */
@property (nonatomic,copy) NSString *taxPrice;

/**
 汇率
 */
@property (nonatomic,copy) NSString *exchangeRate;

/**
 外币金额
 */
@property (nonatomic,copy) NSString *foreignPrice;

/**
 坯布价格
 */
@property (nonatomic,copy) NSString *fabricPrice;

/**
 耗损率
 */
@property (nonatomic,copy) NSString *scrapRate;

/**
 染色费
 */
@property (nonatomic,copy) NSString *dyeingPrice;

/**
 后整理价格
 */
@property (nonatomic,copy) NSString *afterFinishPrice;

/**
 经营成本
 */
@property (nonatomic,copy) NSString *operatingCost;

/**
 经营总成本(单位成本)
 */
@property (nonatomic,copy) NSString *unitCostPrice;

/**
 经营总成本计
 */
@property (nonatomic,copy) NSString *costPrice;


@end

NS_ASSUME_NONNULL_END
