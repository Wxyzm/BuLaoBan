//
//  CompanyUsers.h
//  BuLaoBan
//
//  Created by souxiuyun on 2019/3/28.
//  Copyright © 2019 XX. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CompanyUsers : NSObject

/**
 员工ID
 */
@property (nonatomic,copy) NSString *companyUserId;

/**
 用户ID
 */
@property (nonatomic,copy) NSString *userId;

/**
 头像
 */
@property (nonatomic,copy) NSString *avatar;

/**
 姓名
 */
@property (nonatomic,copy) NSString *name;

/**
 邮箱
 */
@property (nonatomic,copy) NSString *email;

/**
角色Id
 */
@property (nonatomic,copy) NSString *roleId;

/**
 角色名称
 */
@property (nonatomic,copy) NSString *roleName;

/**
 加入公司的时间
 */
@property (nonatomic,copy) NSString *joinTime;

/**
 最后登录时间
 */
@property (nonatomic,copy) NSString *lastLoginTime;

/**
 最后登录IP
 */
@property (nonatomic,copy) NSString *lastLoginIP;

/**
 用户组
 */
@property (nonatomic,strong) NSMutableArray *groups;

/**
 电话
 */
@property (nonatomic,copy) NSString *mobile;

@end

NS_ASSUME_NONNULL_END
