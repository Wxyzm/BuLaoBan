//
//  UserInfoPL.h
//  BuLaoBan
//
//  Created by souxiuyun on 2019/3/5.
//  Copyright © 2019 XX. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface UserInfoPL : NSObject


#pragma mark   ==========User_Profile - 获取用户个人资料
/**
 获取用户个人资料
 */
+ (void)Profile_profileGetUserAccountInfoWithReturnBlock:(ReturnBlock)returnBlock
                                           andErrorBlock:(ErrorBlock)errorBlock;

@end

NS_ASSUME_NONNULL_END
