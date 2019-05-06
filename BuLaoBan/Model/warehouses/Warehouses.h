//
//  Warehouses.h
//  BuLaoBan
//
//  Created by souxiuyun on 2019/5/6.
//  Copyright © 2019 XX. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Warehouses : NSObject

/**
 仓库ID
 */
@property (nonatomic,copy) NSString *warehouseId;

/**
 仓库名称
 */
@property (nonatomic,copy) NSString *warehouseName;

/**
 负责人ID
 */
@property (nonatomic,copy) NSString *managerId;

/**
 负责人名称
 */
@property (nonatomic,copy) NSString *managerName;

/**
 仓库电话
 */
@property (nonatomic,copy) NSString *telephone;

/**
 仓库简介
 */
@property (nonatomic,copy) NSString *desc;

/**
 仓库类型
 */
@property (nonatomic,copy) NSString *type;

/**
 
 */
@property (nonatomic,strong) NSArray *participants;

/**
 是否细码单
 */
@property (nonatomic,copy) NSString *packingListType;

/**
 用户组
 */
@property (nonatomic,strong) NSArray *groups;



@end

NS_ASSUME_NONNULL_END
