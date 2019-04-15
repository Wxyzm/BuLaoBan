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
@property (nonatomic,copy) NSString *sellTimes;

/**
销售单品数
 */
@property (nonatomic,copy) NSString *sampleCount;

/**
 客户数
 */
@property (nonatomic,copy) NSString  *customerCount;

/**
 销货金额
 */
@property (nonatomic,strong) NSMutableArray *deliverPrice;

/**
 销货金额
 */
@property (nonatomic,strong) NSMutableArray *sellPrice;

/**
 销售数量
 */
@property (nonatomic,strong) NSMutableArray *sellNum;


@end

NS_ASSUME_NONNULL_END
