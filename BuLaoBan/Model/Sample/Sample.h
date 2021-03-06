//
//  Sample.h
//  BuLaoBan
//
//  Created by apple on 2019/2/11.
//  Copyright © 2019年 XX. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Sample : NSObject

/**
 门幅
 */
@property (nonatomic, copy) NSString *width;

/**
 克重
 */
@property (nonatomic, copy) NSString *weight;

/**
 单位1 列：卷
 */
@property (nonatomic, copy) NSString *viceUnit;

/**
 
 */
@property (nonatomic, copy) NSString *type;

/**
 规格（废弃，兼容）
 */
@property (nonatomic, copy) NSString *specification;

/**
 图片key
 */
@property (nonatomic, copy) NSString *samplePicKey;

/**
 图片ID
 */
@property (nonatomic, copy) NSString *samplePicId;

/**
 样品ID
 */
@property (nonatomic, copy) NSString *sampleId;

/**
 样品自定义字段
 */
@property (nonatomic, strong) NSMutableArray *sampleAttributes;

/**
 单位2 列：米
 */
@property (nonatomic, copy) NSString *primaryUnit;

/**
 样品英文名称
 */
@property (nonatomic, copy) NSString *nameEn;

/**
 样品名称
 */
@property (nonatomic, copy) NSString *name;

/**
 修改时间
 */
@property (nonatomic, copy) NSString *modifyTime;

/**
 打印标签备注——废弃
 */
@property (nonatomic, copy) NSString *lableRemark;

/**
 编号
 */
@property (nonatomic, copy) NSString *itemNo;

/**
 发布状态(0:未发布 1:已发布)
 */
@property (nonatomic, copy) NSString *isPublished;

/**
 曾用编号（废弃，兼容）
 */
@property (nonatomic, copy) NSString *formerItemNo;

/**
 库位（废弃，兼容）
 */
@property (nonatomic, copy) NSString *depotPosition;

/**
 创建时间
 */
@property (nonatomic, copy) NSString *createTime;

/**
 成分
 */
@property (nonatomic, copy) NSString *component;

/**
 公司ID*
 */
@property (nonatomic, copy) NSString *companyId;

/**
 自定义字段
 */
@property (nonatomic, strong) NSArray *attributes;


@property (nonatomic, assign) BOOL isSelected;


@end

NS_ASSUME_NONNULL_END
