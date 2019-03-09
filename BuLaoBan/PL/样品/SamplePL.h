//
//  SamplePL.h
//  BuLaoBan
//
//  Created by apple on 2019/2/10.
//  Copyright © 2019年 XX. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SamplePL : NSObject
#pragma mark   ==========删除样品
/**
 修改样品
 */

#pragma mark   ==========新增样品
/**
 新增样品
 */
+ (void)Sample_sampleSamplesAddWithDic:(NSDictionary *)upDic
                       WithReturnBlock:(PLReturnValueBlock)returnBlock
                         andErrorBlock:(PLErrorCodeBlock)errorBlock;

#pragma mark   ==========样品搜索
/**
 样品搜索
 */
+ (void)Sample_sampleSamplesSearchWithDic:(NSDictionary *)upDic
                          WithReturnBlock:(PLReturnValueBlock)returnBlock
                            andErrorBlock:(PLErrorCodeBlock)errorBlock;
#pragma mark   ==========移动图片
#pragma mark   ==========获取样品列表
/**
 获取样品列表
 */
+ (void)Sample_sampleSamplesRegisterWithDic:(NSDictionary *)upDic
                            WithReturnBlock:(PLReturnValueBlock)returnBlock
                              andErrorBlock:(PLErrorCodeBlock)errorBlock;
#pragma mark   ==========获取样品详情
/**
 获取样品详情
 */
+ (void)Sample_sampleSamplesDetailWithsampleId:(NSString *)sampleId
                               WithReturnBlock:(PLReturnValueBlock)returnBlock
                                 andErrorBlock:(PLErrorCodeBlock)errorBlock;
#pragma mark   ==========转为正式样品
@end

NS_ASSUME_NONNULL_END
