//
//  HttpClient.h
//  ZhongFangTong
//
//  Created by apple on 2018/6/5.
//  Copyright © 2018年 XX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"


// NetWorkReturn
typedef void (^PLReturnValueBlock) (id returnValue);
typedef void (^PLErrorCodeBlock) (NSString *msg);

typedef void (^ReturnBlock) (id returnValue);      //网络请求成功
typedef void (^ErrorBlock) (NSString *msg);

@interface HttpClient : NSObject

+ (HttpClient *)sharedHttpClient;




#pragma mark   ========== Config

//get方式获取
- (void)requestGET:(NSString *)url
       Withdict:(NSDictionary *)dict
   WithReturnBlock:(ReturnBlock)returnBlock
     andErrorBlock:(ErrorBlock)errorBlock;

//post方式获取
- (void)requestPOST:(NSString *)url
           Withdict:(NSDictionary *)dict
    WithReturnBlock:(ReturnBlock)returnBlock
      andErrorBlock:(ErrorBlock)errorBlock;
//PUT 请求
- (void)requestPUTWithURLStr:(NSString *)urlStr
                    paramDic:(NSDictionary *)paramDic
             WithReturnBlock:(ReturnBlock)returnBlock
               andErrorBlock:(ErrorBlock)errorBlock;

//Delete 请求
- (void)requestDeleteWithURLStr:(NSString *)urlStr
                       paramDic:(NSDictionary *)paramDic
                WithReturnBlock:(ReturnBlock)returnBlock
                  andErrorBlock:(ErrorBlock)errorBlock;

//json解析
+ (id)valueWithJsonString:(NSString *)jsonString;

#pragma mark   ==========////////  登录注册   ////////==========
/**
 用户登录
 */
- (void)accountLoginWithDic:(NSDictionary *)upDic
            WithReturnBlock:(ReturnBlock)returnBlock
              andErrorBlock:(ErrorBlock)errorBlock;

/**
 退出登录
 */
- (void)accountLoginoutWithDic:(NSDictionary *)upDic
               WithReturnBlock:(ReturnBlock)returnBlock
                 andErrorBlock:(ErrorBlock)errorBlock;

/**
 生成手机验证码
 */
- (void)accountCheckCodeWithDic:(NSDictionary *)upDic
                WithReturnBlock:(ReturnBlock)returnBlock
                  andErrorBlock:(ErrorBlock)errorBlock;

/**
 获取图片验证码
 */
- (void)accountImageCheckCodeWithDic:(NSDictionary *)upDic
                     WithReturnBlock:(ReturnBlock)returnBlock
                       andErrorBlock:(ErrorBlock)errorBlock;
/**
 用户注册
 */
- (void)accountRegisterWithDic:(NSDictionary *)upDic
               WithReturnBlock:(ReturnBlock)returnBlock
                 andErrorBlock:(ErrorBlock)errorBlock;

#pragma mark   ==========获取默认公司ID公司名称
/**
获取默认公司ID公司名称
 */
- (void)accountGetComIdAndComNameWithReturnBlock:(ReturnBlock)returnBlock
                                   andErrorBlock:(ErrorBlock)errorBlock;


#pragma mark   ==========////////  Sample   ////////==========
#pragma mark   ==========修改样品
///**
// 修改样品
// */
//- (void)sampleSamplesRegisterWithsampleId:(NSString *)sampleId
//                          WithReturnBlock:(ReturnBlock)returnBlock
//                            andErrorBlock:(ErrorBlock)errorBlock;

#pragma mark   ==========删除样品
/**
 修改样品
 */

#pragma mark   ==========新增样品
/**
 新增样品
 */
- (void)sampleSamplesAddWithDic:(NSDictionary *)upDic
                WithReturnBlock:(ReturnBlock)returnBlock
                  andErrorBlock:(ErrorBlock)errorBlock;

#pragma mark   ==========样品搜索
/**
 样品搜索
 */
- (void)sampleSamplesSearchWithDic:(NSDictionary *)upDic
                   WithReturnBlock:(ReturnBlock)returnBlock
                     andErrorBlock:(ErrorBlock)errorBlock;

#pragma mark   ==========移动图片
#pragma mark   ==========获取样品列表
/**
 获取样品列表
 */
- (void)sampleSamplesRegisterWithDic:(NSDictionary *)upDic
                     WithReturnBlock:(ReturnBlock)returnBlock
                       andErrorBlock:(ErrorBlock)errorBlock;

#pragma mark   ==========获取样品详情
/**
 获取样品详情
 */
- (void)sampleSamplesDetailWithsampleId:(NSString *)sampleId
                        WithReturnBlock:(ReturnBlock)returnBlock
                        andErrorBlock:(ErrorBlock)errorBlock;
#pragma mark   ==========转为正式样品




#pragma mark   ==========////////  User_Profile - 个人设置   ////////==========
#pragma mark   ==========User_Profile - 获取用户个人资料
/**
 获取用户个人资料
 */
- (void)profileGetUserAccountInfoWithReturnBlock:(ReturnBlock)returnBlock
                                   andErrorBlock:(ErrorBlock)errorBlock;

#pragma mark   ==========////////  Contact   ////////==========






@end
