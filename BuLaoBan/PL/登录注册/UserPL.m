//
//  UserPL.m
//  BuLaoBan
//
//  Created by apple on 2019/1/28.
//  Copyright © 2019年 XX. All rights reserved.
//

#import "UserPL.h"
#import "LoginViewController.h"
#import "LBNavigationController.h"
#import "HomeRootViewController.h"
@interface UserPL()
@property (nonatomic,strong)User *user;

@end

@implementation UserPL
static UserPL *sharedManager = nil;
+(UserPL *)shareManager
{
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        sharedManager = [[self alloc]init];
        sharedManager.user = [[User alloc]init];
        //   sharedManager.token = [[Token alloc] init];
        [sharedManager registerDefaults];
    });
    return sharedManager;
    
}

/**
 *  初始化 registerDefaults方法调用时会check NSUserDefaults里是否已经存在了相同的key，如果有则不会把其覆盖。
 */
- (void)registerDefaults{
    NSDictionary *dictionary = @{User_Account:@"",User_Pwd:@"",User_avatar:@"",User_Name:@"",User_Id:@"",User_api_token:@"",User_companyId:@"",User_companyName:@""};
    [[NSUserDefaults standardUserDefaults]registerDefaults:dictionary]; 
    
}

#pragma mark ==========      接口        ==========

/**
 用户登录
 */
- (void)userAccountLoginWithReturnBlock:(PLReturnValueBlock)returnBlock
                          andErrorBlock:(PLErrorCodeBlock)errorBlock
{
    NSDictionary *setdic = @{@"mobile":_user.account,
                             @"password":_user.password
                             };
    [[HttpClient sharedHttpClient] accountLoginWithDic:setdic WithReturnBlock:^(id returnValue) {
        NSDictionary *dic = [HttpClient valueWithJsonString:returnValue];
        if ([dic[@"code"] intValue]==200) {
            User *user = [User mj_objectWithKeyValues:dic];
            user.account = _user.account;
            user.password =  _user.password;
            [self setUser:user];
            [self writeUser];
            returnBlock(@"");
        }else{
            errorBlock(dic[@"message"]);
        }
        
    } andErrorBlock:^(NSString *msg) {
         errorBlock(msg);
    }];
};

/**
 微信登录
 */
- (void)userWXLoginWithDic:(NSDictionary *)upDic
           WithReturnBlock:(PLReturnValueBlock)returnBlock
             andErrorBlock:(PLErrorCodeBlock)errorBlock{
    [[HttpClient sharedHttpClient] requestPOST:@"user/account/platform/login" Withdict:upDic WithReturnBlock:^(id returnValue) {
        NSLog(@"%@",returnValue);
        NSString *authorization = returnValue[@"authorization"];
        if (authorization.length>0) {
            //已绑定
            User *user = [User mj_objectWithKeyValues:returnValue];
            user.account = @"";
            user.password =  @"";
            [self setUser:user];
            [self writeUser];
            returnBlock(@"");
        }else{
            //未绑定
            [HUD show:@"当前微信账号未绑定，请账号登录绑定"];
            errorBlock(@"当前微信账号未绑定，请账号登录绑定");
        }
        
    } andErrorBlock:^(NSString *msg) {
         errorBlock(msg);
    }];
    
    
}



/**
 退出登录
 */
- (void)userAccountLoginoutWithDic:(NSDictionary *)upDic
                   WithReturnBlock:(PLReturnValueBlock)returnBlock
                     andErrorBlock:(PLErrorCodeBlock)errorBlock
{
    [[HttpClient sharedHttpClient] accountLoginoutWithDic:upDic WithReturnBlock:^(id returnValue) {
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

/**
 生成手机验证码
 */
- (void)userAccountCheckCodeWithDic:(NSDictionary *)upDic
                    WithReturnBlock:(PLReturnValueBlock)returnBlock
                      andErrorBlock:(PLErrorCodeBlock)errorBlock
{
    [[HttpClient sharedHttpClient] accountCheckCodeWithDic:upDic WithReturnBlock:^(id returnValue) {
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

/**
 获取图片验证码
 */
- (void)userAccountImageCheckCodeWithReturnBlock:(PLReturnValueBlock)returnBlock
                                   andErrorBlock:(PLErrorCodeBlock)errorBlock
{
    [[HttpClient sharedHttpClient] accountImageCheckCodeWithDic:nil WithReturnBlock:^(id returnValue) {
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
/**
 用户注册
 */
- (void)userAccountRegisterWithDic:(NSDictionary *)upDic
                   WithReturnBlock:(PLReturnValueBlock)returnBlock
                     andErrorBlock:(PLErrorCodeBlock)errorBlock
{
    [[HttpClient sharedHttpClient] accountRegisterWithDic:upDic WithReturnBlock:^(id returnValue) {
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

#pragma mark   ==========获取默认公司ID公司名称
/**
 获取默认公司ID公司名称
 */

- (void)userAccountGetComIdAndComNameWithReturnBlock:(PLReturnValueBlock)returnBlock
                                       andErrorBlock:(PLErrorCodeBlock)errorBlock{
    [[HttpClient sharedHttpClient] accountGetComIdAndComNameWithReturnBlock:^(id returnValue) {
        NSDictionary *dic = [HttpClient valueWithJsonString:returnValue];
        if ([dic[@"code"] intValue]==200) {
            User *user = [self getLoginUser];
            user.defutecompanyId = [dic objectForKey:@"companyId"];
            user.defutecompanyName = [dic objectForKey:@"companyName"];
            [self setUser:user];
            [self writeUser];
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




/**
 *  设置用户数据
 *
 *  @param user user description
 */
- (void)setUserData:(User *)user
{
    _user = user;
}

#pragma mark ========== 向本地写入用户信息
/**
 *  向本地写入用户信息 NSDictionary *dictionary = @{User_Account:@"",User_Pwd:@"",User_avatar:@"",User_Name:@"",User_Id:@"",User_api_token:@""};
 */
- (void)writeUser
{
    [[NSUserDefaults standardUserDefaults]setObject:_user.account forKey:User_Account];
    [[NSUserDefaults standardUserDefaults]setObject:_user.password forKey:User_Pwd];
    [[NSUserDefaults standardUserDefaults]setObject:_user.avatar forKey:User_avatar];
    [[NSUserDefaults standardUserDefaults]setObject:_user.userName forKey:User_Name];
    [[NSUserDefaults standardUserDefaults]setObject:_user.userId forKey:User_Id];
    [[NSUserDefaults standardUserDefaults]setObject:_user.authorization forKey:User_api_token];
    [[NSUserDefaults standardUserDefaults]setObject:_user.defutecompanyId forKey:User_companyId];
    [[NSUserDefaults standardUserDefaults]setObject:_user.defutecompanyName forKey:User_companyName];

    [[NSUserDefaults standardUserDefaults] synchronize];
}


#pragma mark ========== 用户注销

/**
 *  用户注销
 */
- (void)logout{
    
    _user.password = @"";
    _user.userId = @"";
    _user.avatar = @"";
    _user.authorization = @"";
    _user.userName = @"";
    _user.defutecompanyId = @"";
    _user.defutecompanyName = @"";

    [self writeUser];
    [self performSelector:@selector(showLoginView) withObject:nil afterDelay:1.5];
 //   [self showLoginView];
}

/**
 *  显示登录界面
 */
- (void)showLoginView {
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    //    LoginViewController *tabBarVc = [[LoginViewController alloc] init];
    LBNavigationController *lbVc = [[LBNavigationController alloc]initWithRootViewController:[[LoginViewController alloc]init]];
    window.rootViewController = lbVc;
    [window makeKeyAndVisible];
}

/**
 *  显示主界面
 */
- (void)showHomeViewController {
    AppDelegate *app = (AppDelegate *)[[UIApplication  sharedApplication] delegate];
    app.window.rootViewController =
    app.splitViewController;
    app.splitViewController.maximumPrimaryColumnWidth = 100.0;
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window makeKeyAndVisible];
}


#pragma mark ========== 获取登录的用户信息
/**
 *  获取登录的用户信息
 *
 *  @return 登录的用户
 */
- (User*)getLoginUser{
    User *user = [[User alloc]init];
    user.account = [[NSUserDefaults standardUserDefaults]objectForKey:User_Account];
    user.password = [[NSUserDefaults standardUserDefaults]objectForKey:User_Mobile];
    user.avatar = [[NSUserDefaults standardUserDefaults]objectForKey:User_avatar];
    user.authorization = [[NSUserDefaults standardUserDefaults]objectForKey:User_api_token];
    user.userName = [[NSUserDefaults standardUserDefaults]objectForKey:User_Name];
    user.userId = [[NSUserDefaults standardUserDefaults]objectForKey:User_Id];
    user.defutecompanyId = [[NSUserDefaults standardUserDefaults]objectForKey:User_companyId];
    user.defutecompanyName = [[NSUserDefaults standardUserDefaults]objectForKey:User_companyName];
    return user;
}


#pragma mark ========== 判断是否登录
/**
 判断是否登录
 
 @return 是 或否
 */
- (BOOL)userIsLogin{
    
    NSUserDefaults *userdefauls =[NSUserDefaults standardUserDefaults];
    if ([userdefauls objectForKey:User_Id]&&![[userdefauls objectForKey:User_Id] isEqualToString:@""]) {
        return YES;
    }else{
        return NO;
    }
}

@end
