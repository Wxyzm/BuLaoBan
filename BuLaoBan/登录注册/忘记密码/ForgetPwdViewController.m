//
//  ForgetPwdViewController.m
//  BuLaoBan
//
//  Created by apple on 2019/1/24.
//  Copyright © 2019年 XX. All rights reserved.
//

#import "ForgetPwdViewController.h"

@interface ForgetPwdViewController ()<UITextFieldDelegate>

@end

@implementation ForgetPwdViewController{
    
    UIButton *_messYzmBtn;      //手机验证码
    NSMutableArray *_infoArr;
    NSArray *_plaArr;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    self .title = @"忘记密码";
    [self setBarBackBtnWithImage:nil];
    [self initUI];}

- (void)initUI{
    
    
    _messYzmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_messYzmBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    _messYzmBtn.titleLabel.font = APPFONT14;
    [_messYzmBtn setTitleColor:UIColorFromRGB(0x20A0FF) forState:UIControlStateNormal];
    [_messYzmBtn addTarget:self action:@selector(messageYzmBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    _infoArr = [NSMutableArray arrayWithCapacity:0];

    NSArray *imageNameArr = @[@"phone",@"yanzm",@"password"];
    _plaArr =@[@"输入手机号",@"输入手机验证码",@"输入新密码"];
    
    for (int i = 0; i<3; i++) {
        UIView *txtView = [self textFieldWithFrame:CGRectMake(52, 0, 200, 40) font:APPFONT14 placeholder:_plaArr[i] textColor:UIColorFromRGB(BlackColorValue) placeholderColor:UIColorFromRGB(LitterBlackColorValue) delegate:self imageName:imageNameArr[i] andTag:1000+i];
        txtView.frame = CGRectMake(ScreenWidth/2-200, 60+56*i, 400, 40);
        [self.view addSubview:txtView];
        [_infoArr addObject:@""];

        if (i==1) {
            [txtView addSubview:_messYzmBtn];
            _messYzmBtn.frame = CGRectMake(290, 0, 110, 40);
        }
    }
    
    YLButton *sureBtn = [BaseViewFactory ylButtonWithFrame:CGRectMake(ScreenWidth/2-200, 228, 400, 40) font:APPFONT18 title:@"确定" titleColor:UIColorFromRGB(WhiteColorValue) backColor:UIColorFromRGB(BlueColorValue)];
    sureBtn.layer.cornerRadius = 20;
    [self.view  addSubview:sureBtn];
    [sureBtn addTarget:self action:@selector(sureBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
}






#pragma mark ======== 按钮点击

/**
 短信验证码
 */
- (void)messageYzmBtnClick{
    
    NSString *namelength = _infoArr[0];
    if (namelength.length<=0) {
        [HUD show:@"请输入手机号"];
        return;
    }
    NSDictionary *dic = @{@"mobile":namelength,
                          @"businessType":[NSNumber numberWithInt:1],
                          @"imageCheckCode":@"",
                          @"imageName":@""
                          };
    [[UserPL shareManager] userAccountCheckCodeWithDic:dic WithReturnBlock:^(id returnValue) {
        [HUD show:@"短信发送成功，请注意查收"];
    } andErrorBlock:^(NSString *msg) {
        [HUD show:msg];
    }];
}

/**
 确定
 */
- (void)sureBtnClick{
    for (int i = 0; i<_plaArr.count; i++) {
        NSString *namelength = _infoArr[i];
        if (namelength.length<=0) {
            [HUD show:[NSString stringWithFormat:@"请输入%@",_plaArr[i]]];
            return;
        }
    }
    [HUD showLoading:nil];
    NSString *pwd = _infoArr[2];

    NSDictionary *DIC = @{@"mobile":_infoArr[0],@"checkCode":_infoArr[1],@"newPassword":pwd.hu_md5};
    [[HttpClient sharedHttpClient] requestPUTWithURLStr:@"/user/account/password" paramDic:DIC WithReturnBlock:^(id returnValue) {
        [HUD cancel];
        [HUD show:@"修改成功"];
        [self.navigationController popToRootViewControllerAnimated:YES];
    } andErrorBlock:^(NSString *msg) {
         [HUD cancel];
    }];
    
}
#pragma mark ======== textFieldDelegate
-(BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    [_infoArr replaceObjectAtIndex:textField.tag-1000 withObject:textField.text.length>0?textField.text:@""];
    return YES;
}


#pragma mark ======== 创建View
- (UIView *)textFieldWithFrame:(CGRect)frame
                          font:(UIFont *)font
                   placeholder:(NSString *)placeholder
                     textColor:(UIColor *)color
              placeholderColor:(UIColor *)placeholderColor
                      delegate:(id<UITextFieldDelegate>)delegate
                     imageName:(NSString *)imageName
                        andTag:(NSInteger)tag
{
    UIView *view = [BaseViewFactory viewWithFrame:CGRectZero color:UIColorFromRGB(WhiteColorValue)];
    view.layer.cornerRadius = 20;
    view.layer.borderWidth = 1;
    view.layer.borderColor = UIColorFromRGB(BackColorValue).CGColor;
    
    UIImageView *imageView = [BaseViewFactory icomWithHeight:24 imagePath:imageName];
    [view addSubview:imageView];
    imageView.frame = CGRectMake(26-imageView.size.width/2, 8, imageView.size.width, 24);
    
    UITextField *textField = [[UITextField alloc] initWithFrame:frame];
    textField.font = font;
    textField.textColor = color;
    textField.placeholder = placeholder;
    textField.delegate = delegate;
    textField.tag = tag;
    if (placeholderColor)
        textField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:placeholder attributes:@{NSForegroundColorAttributeName:placeholderColor}];
    [textField setAutocorrectionType:UITextAutocorrectionTypeNo];
    [textField setAutocapitalizationType:UITextAutocapitalizationTypeNone];
    [view addSubview:textField];
    
    
    return view;
}

@end
