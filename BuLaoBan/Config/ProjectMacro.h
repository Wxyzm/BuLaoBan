//
//  ProjectMacro.h
//  DaMinEPC
//
//  Created by apple on 2017/12/22.
//  Copyright © 2017年 XX. All rights reserved.
//

#ifndef ProjectMacro_h
#define ProjectMacro_h

#define PAGE_SIZE_NUMBER  @"20"


// 获取屏幕高度.
#define ScreenHeight [[UIScreen mainScreen] bounds].size.height
// 获取屏幕宽度
#define ScreenWidth [[UIScreen mainScreen] bounds].size.width

//字体大小
#define APPFONT(x) [UIFont systemFontOfSize:(x)]

#define WeakSelf(type)  __weak typeof(type) weak##type = type;


//////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////    设置颜色   /////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////
// 设置颜色.
#define UIColorFromRGB_Alpha(rgbValue, a) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:a]

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define Color_RGB(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0  alpha:1.0]
#define Color_RGB_Alpha(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0  alpha:(a)]
//--------------      常用颜色     -------------------------
#define WhiteColorValue          0xffffff       //白色
#define BlackColorValue          0x333333       //黑色正文
#define LitterBlackColorValue    0x9c9c9c       //浅黑说明
#define BlueColorValue           0x20A0FF
#define LineColorValue           0xDCDCDC       //分割线颜色
#define PLAColorValue            0x858585       //placeholderColor

#define BackColorValue           0xefefef       //背景色
#define NAVColorValue            0x3f7be9       //背景色
#define GrayColorValue           0xcccccc       //灰色字体
#define RedColorValue            0xFC3030       //红色


//////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////  账号、密码 /////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////
#define IS_FIRST_LOAD          @"IS_FIRST_LOAD"          //是否第一次加载
#define AppVerison             @"appverison"             //app当前版本号
#define User_Id                @"User_Id"                //用户id
#define User_Mobile            @"User_Mobile"            //用户电话
#define User_Account           @"User_Account"           //用户账号
#define User_Pwd               @"User_Pwd"               //用户密码
#define User_Name              @"User_Name"              //用户姓名
#define User_avatar            @"User_avatar"            //用户头像
#define User_api_token         @"User_api_token"         //用户安全令牌
#define User_login_type        @"User_login_type"        //用户登录方式
#define User_openId            @"User_openId"            //用户微信登录Id
#define User_companyId         @"User_companyId"         //默认公司ID
#define User_companyName       @"User_companyName"       //默认公司名称

//用户登录
#define UserLoginMsg            @"userLoginMsg"
//用户登出
#define UserLogutMsg            @"userLogutMsg"

#define ImageURL                @"http://zcczlkj.oss-cn-hangzhou.aliyuncs.com/"

//http://zcczlkj.oss-cn-hangzhou.aliyuncs.com/service/0879852cda23ae13ede90a9b97912f99.png

//////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////  通知/////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////

#define HomeViewShouldRefresh    @"HomeViewShouldRefresh"            //用户是否登录

/**
 *  判断是否是空字符串 空字符串 = yes
 *
 *  @param string
 *
 *  @return
 */
#define  IsEmptyStr(string) string == nil || string == NULL ||[string isKindOfClass:[NSNull class]]|| [string isEqualToString:@""] ||[[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0 ? YES : NO

#define  EmptyStr(string) string == nil || string == NULL ||[string isKindOfClass:[NSNull class]]|| [string isEqualToString:@""] ||[[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0 ? @"" : string
//--------------    iphone各机型判断    -------------------------
//////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////    iphone各机型判断   /////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////

#define iPad               CGSizeEqualToSize(CGSizeMake(768, 1024), [[UIScreen mainScreen] bounds].size)
#define iPhone5               CGSizeEqualToSize(CGSizeMake(320, 568), [[UIScreen mainScreen] bounds].size)
#define iPhone6               CGSizeEqualToSize(CGSizeMake(375, 667), [[UIScreen mainScreen] bounds].size)
#define iPhone6p               CGSizeEqualToSize(CGSizeMake(414, 736), [[UIScreen mainScreen] bounds].size)
#define iPhoneX               CGSizeEqualToSize(CGSizeMake(375, 812), [[UIScreen mainScreen] bounds].size)

//////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////     常用高度控制   /////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////
#define TABBAR_HEIGHT           (iPhoneX?72:49)  //tabbar的默认高度
#define STATUSBAR_HEIGHT        (iPhoneX?44:20)  //状态栏高度
#define NaviHeight64   (STATUSBAR_HEIGHT+44)//navigation+statue默认高度

//////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////     常用字体大小  /////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////
#define APPFONT(x) [UIFont systemFontOfSize:(x)]
#define APPFONT12 [UIFont systemFontOfSize:12]
#define APPFONT13 [UIFont systemFontOfSize:13]
#define APPFONT14 [UIFont systemFontOfSize:14]
#define APPFONT15 [UIFont systemFontOfSize:15]
#define APPFONT16 [UIFont systemFontOfSize:16]
#define APPFONT17 [UIFont systemFontOfSize:17]
#define APPFONT18 [UIFont systemFontOfSize:18]
#define APPBLODFONTT(x) [UIFont boldSystemFontOfSize:(x)]


//////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////    加载方式   ///////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////

#define PageSize          @"10"    //分页加载时  每页的数量
#define NET_TIME_OUT      20

//#define kbaseUrl        @"https://buguanjia.com/api/"      //接口
#define kbaseUrl        @"http://smartdovedev.iask.in:17946/api"      //接口








#ifdef DEBUG
#define NSLog(FORMAT, ...) fprintf(stderr,"\n %s:%d   %s\n",[[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String],__LINE__, [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);
#else
#define NSLog(...)
#endif
#endif /* ProjectMacro_h */
