//
//  PackingListDetail.h
//  BuLaoBan
//
//  Created by souxiuyun on 2019/3/13.
//  Copyright © 2019 XX. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PackingListDetail : NSObject

/**
 产品ID号
 */
@property (nonatomic, copy) NSString *sampleId;

/**
 颜色ID号
 */
@property (nonatomic, copy) NSString *colorId;

/**
 缸号
 */
@property (nonatomic, copy) NSString *dyelot;

/**
 数量单位
 */
@property (nonatomic, copy) NSString *quantityUnit;

/**
 数量
 */
@property (nonatomic, copy) NSString *quantity;

/**
 包号
 */
@property (nonatomic, copy) NSString *packageNo;

/**
 卷（匹）数单位
 */
@property (nonatomic, copy) NSString *packageUnit;

/**
 卷（匹）数量
 */
@property (nonatomic, copy) NSString *packageNum;


/**
 卷号
 */
@property (nonatomic, copy) NSString *boltNo;











@end

NS_ASSUME_NONNULL_END
