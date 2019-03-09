//
//  receivableGoods.h
//  BuLaoBan
//
//  Created by souxiuyun on 2019/3/9.
//  Copyright © 2019 XX. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface receivableGoods : NSObject
/**
 客户ID
 */
@property (nonatomic, copy) NSString *customerId;
/**
 客户名称
 */
@property (nonatomic, copy) NSString *customerName;
/**
 销售ID
 */
@property (nonatomic, copy) NSString *sellerId;
/**
 销售名称
 */
@property (nonatomic, copy) NSString *sellerName;

/**
 单据列表
 */
@property (nonatomic, strong) NSMutableArray *items;
@end

NS_ASSUME_NONNULL_END
