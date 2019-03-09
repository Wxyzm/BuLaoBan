//
//  UserPL.h
//  BuLaoBan
//
//  Created by apple on 2019/1/28.
//  Copyright © 2019年 XX. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface UserPL : NSObject
/**
 *  创建单利管理类
 */
+ (UserPL *)shareManager;

#pragma mark ==========      接口        ==========

/**
 用户登录
 */
- (void)userAccountLoginWithReturnBlock:(PLReturnValueBlock)returnBlock
                          andErrorBlock:(PLErrorCodeBlock)errorBlock;

/**
 退出登录
 */
- (void)userAccountLoginoutWithDic:(NSDictionary *)upDic
                   WithReturnBlock:(PLReturnValueBlock)returnBlock
                     andErrorBlock:(PLErrorCodeBlock)errorBlock;

/**
 生成手机验证码
 */
- (void)userAccountCheckCodeWithDic:(NSDictionary *)upDic
                WithReturnBlock:(PLReturnValueBlock)returnBlock
                  andErrorBlock:(PLErrorCodeBlock)errorBlock;

/**
 获取图片验证码
 */
- (void)userAccountImageCheckCodeWithReturnBlock:(PLReturnValueBlock)returnBlock
                                   andErrorBlock:(PLErrorCodeBlock)errorBlock;
/**
 用户注册
 */
- (void)userAccountRegisterWithDic:(NSDictionary *)upDic
                   WithReturnBlock:(PLReturnValueBlock)returnBlock
                     andErrorBlock:(PLErrorCodeBlock)errorBlock;

#pragma mark   ==========获取默认公司ID公司名称
/**
 获取默认公司ID公司名称
 */

 - (void)userAccountGetComIdAndComNameWithReturnBlock:(PLReturnValueBlock)returnBlock
                                        andErrorBlock:(PLErrorCodeBlock)errorBlock;
 
/**
 *  设置用户数据
 *
 *  @param user user description
 */
- (void)setUserData:(User *)user;


#pragma mark ========== 向本地写入用户信息
/**
 *  向本地写入用户信息
 */
- (void)writeUser;


#pragma mark ========== 用户注销

/**
 *  用户注销
 */
- (void)logout;

#pragma mark ========== 前往登录页
/**
 *  显示主界面
 */
- (void)showHomeViewController;
#pragma mark ========== 获取登录的用户信息
/**
 *  获取登录的用户信息
 *
 *  @return 登录的用户
 */
- (User*)getLoginUser;


#pragma mark ========== 判断是否登录
/**
 判断是否登录
 
 @return 是 或否
 */
- (BOOL)userIsLogin;


@end

NS_ASSUME_NONNULL_END
