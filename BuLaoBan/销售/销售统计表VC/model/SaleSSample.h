//
//  SaleSSample.h
//  BuLaoBan
//
//  Created by souxiuyun on 2019/4/3.
//  Copyright © 2019 XX. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SaleSSample : NSObject

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
 样品名称
 */
@property (nonatomic,copy) NSString *name;

/**
 样品色号
 */
@property (nonatomic,copy) NSString *colorMark;

/**
 样品颜色
 */
@property (nonatomic,copy) NSString *colorName;

/**
 客户数
 */
@property (nonatomic,copy) NSString *customerCount;

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
