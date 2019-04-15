//
//  UserInfoPL.m
//  BuLaoBan
//
//  Created by souxiuyun on 2019/3/5.
//  Copyright © 2019 XX. All rights reserved.
//

#import "UserInfoPL.h"

@implementation UserInfoPL

#pragma mark   ==========User_Profile - 获取用户个人资料
/**
 获取用户个人资料
 */
+ (void)Profile_profileGetUserAccountInfoWithReturnBlock:(ReturnBlock)returnBlock
                                           andErrorBlock:(ErrorBlock)errorBlock{
    [[HttpClient sharedHttpClient] profileGetUserAccountInfoWithReturnBlock:^(id returnValue) {
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





@end
