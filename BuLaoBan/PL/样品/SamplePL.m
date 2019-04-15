//
//  SamplePL.m
//  BuLaoBan
//
//  Created by apple on 2019/2/10.
//  Copyright © 2019年 XX. All rights reserved.
//

#import "SamplePL.h"

@implementation SamplePL
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
                         andErrorBlock:(PLErrorCodeBlock)errorBlock
{
    [[HttpClient sharedHttpClient] sampleSamplesAddWithDic:upDic WithReturnBlock:^(id returnValue) {
        NSDictionary *dic = [HttpClient valueWithJsonString:returnValue];
        if ([dic[@"code"] intValue]==200) {
            returnBlock(dic);
        }else{
           [HUD show:dic[@"message"]];
                 if ([dic[@"code"] intValue]==401) {
                     [[UserPL shareManager] logout];
                 }
            errorBlock(dic[@"message"]);
        }
    } andErrorBlock:^(NSString *msg) {
        [HUD show:msg];
        errorBlock(msg);
    }];
    
}

#pragma mark   ==========样品搜索
/**
 样品搜索
 */
+ (void)Sample_sampleSamplesSearchWithDic:(NSDictionary *)upDic
                          WithReturnBlock:(PLReturnValueBlock)returnBlock
                            andErrorBlock:(PLErrorCodeBlock)errorBlock
{
    [[HttpClient sharedHttpClient] sampleSamplesSearchWithDic:upDic WithReturnBlock:^(id returnValue) {
        NSDictionary *dic = [HttpClient valueWithJsonString:returnValue];
        if ([dic[@"code"] intValue]==200) {
            returnBlock(dic);
        }else{
           [HUD show:dic[@"message"]];
                 if ([dic[@"code"] intValue]==401) {
                     [[UserPL shareManager] logout];
                 }
            errorBlock(dic[@"message"]);
        }
    } andErrorBlock:^(NSString *msg) {
        [HUD show:msg];
        errorBlock(msg);
    }];
    
}
#pragma mark   ==========移动图片
#pragma mark   ==========获取样品列表
/**
 获取样品列表
 */
+ (void)Sample_sampleSamplesRegisterWithDic:(NSDictionary *)upDic
                            WithReturnBlock:(PLReturnValueBlock)returnBlock
                              andErrorBlock:(PLErrorCodeBlock)errorBlock
{
    [[HttpClient sharedHttpClient] sampleSamplesRegisterWithDic:upDic WithReturnBlock:^(id returnValue) {
        NSDictionary *dic = [HttpClient valueWithJsonString:returnValue];
        if ([dic[@"code"] intValue]==200) {
            returnBlock(dic);
        }else{
           [HUD show:dic[@"message"]];
                 if ([dic[@"code"] intValue]==401) {
                     [[UserPL shareManager] logout];
                 }
            errorBlock(dic[@"message"]);
        }
    } andErrorBlock:^(NSString *msg) {
        [HUD show:msg];
        errorBlock(msg);
    }];
    
}
#pragma mark   ==========获取样品详情
/**
 获取样品详情
 */
+ (void)Sample_sampleSamplesDetailWithsampleId:(NSString *)sampleId
                               WithReturnBlock:(PLReturnValueBlock)returnBlock
                                 andErrorBlock:(PLErrorCodeBlock)errorBlock
{
    [[HttpClient sharedHttpClient] sampleSamplesDetailWithsampleId:sampleId WithReturnBlock:^(id returnValue) {
        NSDictionary *dic = [HttpClient valueWithJsonString:returnValue];
        if ([dic[@"code"] intValue]==200) {
            returnBlock(dic);
        }else{
           [HUD show:dic[@"message"]];
                 if ([dic[@"code"] intValue]==401) {
                     [[UserPL shareManager] logout];
                 }
            errorBlock(dic[@"message"]);
        }
    } andErrorBlock:^(NSString *msg) {
        [HUD show:msg];
        errorBlock(msg);
    }];
    
}
#pragma mark   ==========转为正式样品
@end
