//
//  User.h
//  BuLaoBan
//
//  Created by apple on 2019/1/28.
//  Copyright © 2019年 XX. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface User : NSObject

/**
 账号
 */
@property (nonatomic, copy) NSString *account;

/**
 密码
 */
@property (nonatomic, copy) NSString *password;

/**
 用户头像
 */
@property (nonatomic, copy) NSString *avatar;

/**
 用户名
 */
@property (nonatomic, copy) NSString *userName;

/**
 用户ID
 */
@property (nonatomic, copy) NSString *userId;
       
/**
 用户token
 */
@property (nonatomic, copy) NSString *authorization;



@property (nonatomic, copy) NSString *defutecompanyId;
@property (nonatomic, copy) NSString *defutecompanyName;


@end

NS_ASSUME_NONNULL_END
