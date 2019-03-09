//
//  Component.h
//  BuLaoBan
//
//  Created by apple on 2019/2/12.
//  Copyright © 2019年 XX. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Component : NSObject

/**
 成分名称
 */
@property (nonatomic, copy) NSString *componentName;

/**
 成分英文名称
 */
@property (nonatomic, copy) NSString *componentEnName;

/**
 成分百分比值（不超过100）
 */
@property (nonatomic, copy) NSString *componentValue;



@end

NS_ASSUME_NONNULL_END
