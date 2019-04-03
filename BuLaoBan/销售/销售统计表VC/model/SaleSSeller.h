//
//  SaleSSeller.h
//  BuLaoBan
//
//  Created by souxiuyun on 2019/4/3.
//  Copyright © 2019 XX. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SaleSSeller : NSObject
/**
 销售员ID
 */
@property (nonatomic,strong) NSMutableArray *sellerId;

/**
 销售员名称
 */
@property (nonatomic,strong) NSMutableArray *sellerName;

/**
 销售员电话
 */
@property (nonatomic,strong) NSMutableArray *sellerMobile;

/**
 销售次数
 */
@property (nonatomic,strong) NSMutableArray *sellTimes;

/**
 销售样品款数
 */
@property (nonatomic,strong) NSMutableArray *sellSampleCount;

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
