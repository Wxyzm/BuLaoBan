//
//  Setting.h
//  BuLaoBan
//
//  Created by 熊鑫 on 2019/6/26.
//  Copyright © 2019 XX. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Setting : NSObject

/**
 配货流程(0:否 1:是)
 */
@property (nonatomic,copy) NSString *distributionProcess;
/**
 外币核算(0:否 1:是)
 */
@property (nonatomic,copy) NSString *foreignCurrency;
/**
 坯布色号
 */
@property (nonatomic,copy) NSString *greyFabricColorMark;
/**
 坯布色名
 */
@property (nonatomic,copy) NSString *greyFabricColorName;
/**
 
 */
@property (nonatomic,copy) NSString *imageSearch;
/**
 */
@property (nonatomic,copy) NSString *moduleHandle;
/**
 样品间开通过的模块
 */
@property (nonatomic,strong) NSArray *modules;
/**
 多计量单位(0:不开启 1:开启)
 */
@property (nonatomic,copy) NSString *multiUnit;
/**
 应付开始使用日期
 */
@property (nonatomic,copy) NSString *payableStartDate;
/**
 应收开始使用日期
 */
@property (nonatomic,copy) NSString *receivableStartDate;
/**
 列表需要展示的字段列表
 */
@property (nonatomic,copy) NSString *sampleListParams;
/**
 新增样品同步发布(0:不同步,1:同步)
 */
@property (nonatomic,copy) NSString *samplePublish;
/**
 销售库存扣减(0:不扣减 1:扣减)
 

 */
@property (nonatomic,copy) NSString *sellInventoryReduce;
/**
 库存开始使用日期
 */
@property (nonatomic,copy) NSString *storeStartDate;
/**
 税率
 */
@property (nonatomic,copy) NSString *taxRate;
/**
 水印开关(0:关, 1:开)
 */
@property (nonatomic,copy) NSString *waterMarker;
/**
 水印参数
 */
@property (nonatomic,strong) NSArray *waterMarkerParams;




@end

NS_ASSUME_NONNULL_END
