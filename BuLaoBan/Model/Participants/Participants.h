//
//  Participants.h
//  BuLaoBan
//
//  Created by souxiuyun on 2019/3/20.
//  Copyright © 2019 XX. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Participants : NSObject

/**
 用户头像
 */
@property (nonatomic, copy) NSString *avatar;
/**
 参与者权限是否可变(0:不可变，1:可变)
 */
@property (nonatomic, copy) NSString *changeable;
/**
 用户id
 */
@property (nonatomic, copy) NSString *userId;
/**
 用户名
 */
@property (nonatomic, copy) NSString *userName;

@end

NS_ASSUME_NONNULL_END
