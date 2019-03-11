//
//  StasticeItem.h
//  BuLaoBan
//
//  Created by souxiuyun on 2019/3/11.
//  Copyright © 2019 XX. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface StasticeItem : NSObject

/**
 客户ID
 */
@property (nonatomic, copy) NSString *customerId;
/**
 客户名称
 */
@property (nonatomic, copy) NSString *customerName;
/**
 本期收款
 */
@property (nonatomic, copy) NSString *receiptAmountCurrent;
/**
 期初应收
 */
@property (nonatomic, copy) NSString *receivableAmountBefore;
/**
 本期应收
 */
@property (nonatomic, copy) NSString *receivableAmountCurrent;
/**
 销售ID
 */
@property (nonatomic, copy) NSString *sellerId;
/**
 销售名称
 */
@property (nonatomic, copy) NSString *sellerName;


@end

NS_ASSUME_NONNULL_END
