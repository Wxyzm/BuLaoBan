//
//  UserInfoModel.h
//  BuLaoBan
//
//  Created by souxiuyun on 2019/3/5.
//  Copyright © 2019 XX. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface UserInfoModel : NSObject

/**
 用户名*
 */
@property (nonatomic, copy) NSString *userName;

/**
 头像
 */
@property (nonatomic, copy) NSString *avatar;

/**
 邮箱
 */
@property (nonatomic, copy) NSString *email;

/**
 微信号
 */
@property (nonatomic, copy) NSString *weixin;

/**
 职位
 */
@property (nonatomic, copy) NSString *position;

/**
 所在地
 */
@property (nonatomic, copy) NSString *address;

/**
 联系电话
 */
@property (nonatomic, copy) NSString *telephone;
/**
 手机
 */
@property (nonatomic, copy) NSString *mobile;

/**
 生日
 */
@property (nonatomic, copy) NSString *birthday;

/**
 传真
 */
@property (nonatomic, copy) NSString *fax;

/**
 公司名字
 */
@property (nonatomic, copy) NSString *companyName;

/**
 公司简介
 */
@property (nonatomic, copy) NSString *companyDesc;

/**
 主营业务
 */
@property (nonatomic, copy) NSString *scope;

/**
 经纬度（经度,纬度 顺序隔开）
 */
@property (nonatomic, copy) NSString *theodolite;

/**
 图片ID（多个以英文逗号隔开）
 */
@property (nonatomic, strong) NSMutableArray *pics;


/**
 可见的模块（用英文逗号隔开）
 */
@property (nonatomic, strong) NSMutableArray *visibleModules;












@end

NS_ASSUME_NONNULL_END
