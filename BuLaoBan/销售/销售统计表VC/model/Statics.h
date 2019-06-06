//
//  Statics.h
//  BuLaoBan
//
//  Created by souxiuyun on 2019/4/4.
//  Copyright © 2019 XX. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Statics : NSObject

/**
 统计分组序号
 */
@property (nonatomic,copy) NSString  *groupNo;

/**
 总销售单数
 */
@property (nonatomic,copy) NSString *deliverTimes;

/**
销售单品数
 */
@property (nonatomic,copy) NSString *sampleCount;


/**
 未核算数
 */
@property (nonatomic,copy) NSString *noAccountingTimes;

/**
 客户数
 */
@property (nonatomic,copy) NSString  *customerCount;

/**
 销售金额
 */
@property (nonatomic,strong) NSMutableArray *deliverPrice;

/**
 利润
 */
@property (nonatomic,strong) NSMutableArray *profitPrice;

///**
// 销售数量
// */
//@property (nonatomic,strong) NSMutableArray *sellNum;


@end

NS_ASSUME_NONNULL_END
