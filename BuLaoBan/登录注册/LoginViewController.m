//
//  LoginViewController.m
//  BuLaoBan
//
//  Created by apple on 2019/1/24.
//  Copyright © 2019年 XX. All rights reserved. 
//

#import "LoginViewController.h"
#import "RegistViewController.h"    //注册
#import "ForgetPwdViewController.h" //忘记密码
#import "IdentityController.h"      //角色选择

#import "WXApiManager.h"

@interface LoginViewController ()<WXAuthDelegate>

@end

@implementation LoginViewController{
    UITextField *_phoneTxt;
    UITextField *_passWTxt;
    UIImageView *_faceIma;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.needHideNavBar = YES;
    self.view.backgroundColor = UIColorFromRGB(WhiteColorValue);
    [self initUI];
}
- (void)initUI{
    
    UIView *faceImaView = [BaseViewFactory viewWithFrame:CGRectZero color:UIColorFromRGB(BackColorValue)];
    faceImaView.layer.cornerRadius = 40;
    [self.view addSubview:faceImaView];
    _faceIma = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 60, 60)];
    [faceImaView addSubview:_faceIma];
    _faceIma.clipsToBounds = YES;
    _faceIma.layer.cornerRadius = 30;
    _faceIma.backgroundColor = UIColorFromRGB(BlueColorValue);
    
    NSLog(@"%f,%f",ScreenWidth,ScreenHeight);
    UILabel *topLab = [BaseViewFactory labelWithFrame:CGRectZero textColor:UIColorFromRGB(BlackColorValue) font:APPFONT(20) textAligment:NSTextAlignmentCenter andtext:@"布管家"];
    [self.view addSubview:topLab];
    User *user = [[UserPL shareManager] getLoginUser];

    _phoneTxt = [BaseViewFactory textFieldWithFrame:CGRectZero font:APPFONT14 placeholder:@"输入手机号" textColor:UIColorFromRGB(BlackColorValue) placeholderColor:UIColorFromRGB(LitterBlackColorValue) delegate:nil];
    _phoneTxt.keyboardType = UIKeyboardTypeNumberPad;
    _phoneTxt.layer.cornerRadius = 20;
    _phoneTxt.layer.borderColor = UIColorFromRGB(BackColorValue).CGColor;
    _phoneTxt.layer.borderWidth = 1;
    _phoneTxt.leftViewMode = UITextFieldViewModeAlways;
    _phoneTxt.leftView = [self leftViewWithImageName:@"phone"];
    [self.view  addSubview:_phoneTxt];
    _phoneTxt.text = user.account;
    
    _passWTxt = [BaseViewFactory textFieldWithFrame:CGRectZero font:APPFONT14 placeholder:@"输入密码" textColor:UIColorFromRGB(BlackColorValue) placeholderColor:UIColorFromRGB(LitterBlackColorValue) delegate:nil];
    _passWTxt.keyboardType = UIKeyboardTypeASCIICapable;
    _passWTxt.layer.cornerRadius = 20;
    _passWTxt.secureTextEntry = YES;
    _passWTxt.layer.borderColor = UIColorFromRGB(BackColorValue).CGColor;
    _passWTxt.layer.borderWidth = 1;
    _passWTxt.leftViewMode = UITextFieldViewModeAlways;
    _passWTxt.leftView = [self leftViewWithImageName:@"password"];
    [self.view  addSubview:_passWTxt];

    YLButton *loginBtn = [BaseViewFactory ylButtonWithFrame:CGRectZero font:APPFONT18 title:@"登录" titleColor:UIColorFromRGB(WhiteColorValue) backColor:UIColorFromRGB(BlueColorValue)];
    loginBtn.layer.cornerRadius = 20;
    [self.view  addSubview:loginBtn];
    [loginBtn addTarget:self action:@selector(loginBtnClick) forControlEvents:UIControlEventTouchUpInside];

    UIView *forView = [BaseViewFactory viewWithFrame:CGRectZero color:UIColorFromRGB(WhiteColorValue)];
    [self.view  addSubview:forView];
    UIButton *forBtn = [BaseViewFactory buttonWithFrame:CGRectMake(0, 0, 104, 22) font:APPFONT16 title:@"忘记密码" titleColor:UIColorFromRGB(LitterBlackColorValue) backColor:UIColorFromRGB(WhiteColorValue)];
    [forBtn addTarget:self action:@selector(forBtnClick) forControlEvents:UIControlEventTouchUpInside];

    [forView addSubview:forBtn];
    UIButton *registBtn = [BaseViewFactory buttonWithFrame:CGRectMake(104, 0, 104, 22) font:APPFONT16 title:@"现在注册" titleColor:UIColorFromRGB(LitterBlackColorValue) backColor:UIColorFromRGB(WhiteColorValue)];
    [forView addSubview:registBtn];
    UIView *line = [BaseViewFactory viewWithFrame:CGRectMake(104, 0, 1, 22) color:UIColorFromRGB(LitterBlackColorValue)];
    [registBtn addTarget:self action:@selector(registBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [forView addSubview:line];
    
    UIView *threeView = [BaseViewFactory viewWithFrame:CGRectZero color:UIColorFromRGB(WhiteColorValue)];
    [self.view  addSubview:threeView];
    UIView *hline = [BaseViewFactory viewWithFrame:CGRectMake(0, 9.5, 120, 1) color:UIColorFromRGB(LitterBlackColorValue)];
    [threeView addSubview:hline];
    UIView *hline1 = [BaseViewFactory viewWithFrame:CGRectMake(280, 9.5, 120, 1) color:UIColorFromRGB(LitterBlackColorValue)];
    [threeView addSubview:hline1];
    UILabel *threeLab = [BaseViewFactory labelWithFrame:CGRectMake(120, 0, 160, 20) textColor:UIColorFromRGB(LitterBlackColorValue) font:APPFONT(14) textAligment:NSTextAlignmentCenter andtext:@"使用第三方绑定登录"];
    [threeView addSubview:threeLab];
    YLButton *xwBtn = [BaseViewFactory ylButtonWithFrame:CGRectMake(175, 50, 60, 82) font:APPFONT14 title:@"微信登录" titleColor:UIColorFromRGB(LitterBlackColorValue) backColor:UIColorFromRGB(WhiteColorValue)];
    [xwBtn setImageRect:CGRectMake(5, 0, 50, 50)];
    [xwBtn setTitleRect:CGRectMake(0, 62, 60, 20)];
    xwBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [xwBtn setImage:[UIImage imageNamed:@"WeChat"] forState:UIControlStateNormal];
    [threeView addSubview:xwBtn];
    [xwBtn addTarget:self action:@selector(WXBtnClick) forControlEvents:UIControlEventTouchUpInside];

    threeView.sd_layout
    .bottomSpaceToView(self.view, 108)
    .widthIs(400)
    .heightIs(132)
    .centerXEqualToView(self.view);
    
    forView.sd_layout
    .bottomSpaceToView(threeView, 40)
    .widthIs(208)
    .heightIs(22)
    .centerXEqualToView(self.view);
    
    loginBtn.sd_layout
    .bottomSpaceToView(forView, 30)
    .widthIs(400)
    .heightIs(40)
    .centerXEqualToView(self.view);
    
    _passWTxt.sd_layout
    .bottomSpaceToView(loginBtn, 16)
    .widthIs(400)
    .heightIs(40)
    .centerXEqualToView(self.view);
    
    _phoneTxt.sd_layout
    .bottomSpaceToView(_passWTxt, 16)
    .widthIs(400)
    .heightIs(40)
    .centerXEqualToView(self.view);
    
    topLab.sd_layout
    .bottomSpaceToView(_phoneTxt, 40)
    .widthIs(400)
    .heightIs(21)
    .centerXEqualToView(self.view);
    
    faceImaView.sd_layout
    .bottomSpaceToView(topLab, 15)
    .widthIs(80)
    .heightIs(80)
    .centerXEqualToView(self.view);
}


#pragma mark ====== 按钮点击
/**
 登录
 */
- (void)loginBtnClick{
    if (_phoneTxt.text.length<=0) {
        [HUD show:@"请输入手机号"];
        return;
    }
    if (_passWTxt.text.length<=0) {
        [HUD show:@"请输密码"];
        return;
    }
    User *user = [[User alloc]init];
    user.account = _phoneTxt.text;
    user.password =_passWTxt.text.hu_md5;
    [[UserPL shareManager] setUserData:user];
    [[UserPL shareManager] userAccountLoginWithReturnBlock:^(id returnValue) {
        [self loadUserCompanyID];
    } andErrorBlock:^(NSString *msg) {
        [HUD show:msg];
    }];
}

- (void)loadUserCompanyID{
    [[UserPL shareManager] userAccountGetComIdAndComNameWithReturnBlock:^(id returnValue) {
        [HUD show:@"登录成功"];
        if ([returnValue[@"companyName"] isEqualToString:@"示例样品间"]) {
            //前往角色选择
            IdentityController *idVc = [[IdentityController alloc]init];
            [self.navigationController pushViewController:idVc animated:YES];
        }else{
            [self performSelector:@selector(gotoHomeVC) withObject:nil afterDelay:0.5];
        }
    } andErrorBlock:^(NSString *msg) {
        
    }];
}

- (void)gotoHomeVC{
    [[UserPL shareManager] showHomeViewController];
}

/**
 注册
 */
- (void)registBtnClick{
    RegistViewController *reVc = [[RegistViewController alloc]init];
    [self.navigationController pushViewController:reVc animated:YES];
}

/**
 忘记密码
 */
- (void)forBtnClick{
    ForgetPwdViewController *forVc = [[ForgetPwdViewController alloc]init];
    [self.navigationController pushViewController:forVc animated:YES];
}


/**
 微信登录
 */
- (void)WXBtnClick{
    [[WXApiManager sharedManager] sendAuthRequestWithController:self
                                                       delegate:self];
}

#pragma mark - WXAuthDelegate
- (void)wxAuthSucceed:(NSString *)code {
    NSDictionary *dic = @{@"platCode":code,
                          @"platType":@"1",
                          };
    [[UserPL shareManager] userWXLoginWithDic:dic WithReturnBlock:^(id returnValue) {
         [self loadUserCompanyID];
    } andErrorBlock:^(NSString *msg) {
        
    }];
}

- (void)wxAuthDenied {
    [HUD show:@"授权失败"];
}

- (UIView *)leftViewWithImageName:(NSString *)imagename{
    UIView *leftView = [BaseViewFactory viewWithFrame:CGRectMake(0, 0, 52, 40) color:UIColorFromRGB(WhiteColorValue)];
    UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:imagename]];
    [leftView addSubview:imageView];
    imageView.frame = CGRectMake(18, 8, 18, 24);
    return leftView;
}

@end
