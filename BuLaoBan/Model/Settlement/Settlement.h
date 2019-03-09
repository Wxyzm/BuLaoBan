//
//  Settlement.h
//  BuLaoBan
//
//  Created by apple on 2019/2/25.
//  Copyright © 2019年 XX. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

//加载的方式
typedef NS_ENUM(NSInteger, ValueType) {
    ValueType_Input         = 1,
    ValueType_Select        = 2,
    ValueType_Memo          = 3
};

@interface Settlement : NSObject

/**
 名称
 */
@property (nonatomic, copy) NSString *title;

/**
 展示值
 */
@property (nonatomic, copy) NSString *showValue;

/**
 单位
 */
@property (nonatomic, copy) NSString *unit;

/**
 model类型
 */
@property (nonatomic, assign) ValueType ValueType;


/**
 是否显示红色数字
 */
@property (nonatomic, assign) BOOL isRedText;

@end

NS_ASSUME_NONNULL_END
