//
//  ChangePwdView.m
//  BuLaoBan
//
//  Created by apple on 2019/2/28.
//  Copyright © 2019年 XX. All rights reserved.
//

#import "ChangePwdView.h"
@interface ChangePwdView()<UITextFieldDelegate>



@end
@implementation ChangePwdView{
    
    UITextField *_phoneTxt;
    UITextField *_yzmTxt;
    UITextField *_pwdTxt;
    UIButton *_yzmBtn;
    NSTimer         *_myTimer;              //计时器
    NSInteger       _second;                //计时秒数
}

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = UIColorFromRGB(WhiteColorValue);
        [self setUp];
    }
    return self;
}

- (void)setUp{
    
    CGFloat Width = ScreenWidth-400;

    _phoneTxt = [BaseViewFactory textFieldWithFrame:CGRectMake(100, 0, Width-120, 50) font:APPFONT13 placeholder:@"默认注册的手机号" textColor:UIColorFromRGB(BlackColorValue) placeholderColor:UIColorFromRGB(0x9b9b9b) delegate:self];
    _phoneTxt.textAlignment = NSTextAlignmentRight;

    [self addSubview:_phoneTxt];
    
    _yzmTxt = [BaseViewFactory textFieldWithFrame:CGRectMake(100,50 , Width-205, 50) font:APPFONT13 placeholder:@"输入验证码" textColor:UIColorFromRGB(BlackColorValue) placeholderColor:UIColorFromRGB(0x9b9b9b) delegate:self];
    _yzmTxt.textAlignment = NSTextAlignmentRight;

    [self addSubview:_yzmTxt];
    
    _pwdTxt = [BaseViewFactory textFieldWithFrame:CGRectMake(100, 100, Width-120, 50) font:APPFONT13 placeholder:@"输入新密码" textColor:UIColorFromRGB(BlackColorValue) placeholderColor:UIColorFromRGB(0x9b9b9b) delegate:self];
    _pwdTxt.textAlignment = NSTextAlignmentRight;
    [self addSubview:_pwdTxt];
    
    _yzmBtn = [BaseViewFactory buttonWithFrame:CGRectMake(Width-98, 50, 78, 50) font:APPFONT13 title:@"获取验证码" titleColor:UIColorFromRGB(BlueColorValue) backColor:UIColorFromRGB(WhiteColorValue)];
    [_yzmBtn addTarget:self action:@selector(yzmBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_yzmBtn];

    
    NSArray *titlrArr = @[@"手机号",@"手机验证码",@"新密码"];
    for (int i = 0; i<3; i++) {
        UILabel *lab = [BaseViewFactory labelWithFrame:CGRectMake(20, 50*i, 100, 50) textColor:UIColorFromRGB(BlackColorValue) font:APPFONT13 textAligment:NSTextAlignmentLeft andtext:titlrArr[i]];
        [self addSubview:lab];
        
        UIView *line = [BaseViewFactory viewWithFrame:CGRectMake(0, 50*i+49.5, Width, 1) color:UIColorFromRGB(LineColorValue)];
        [self addSubview:line];
        
    }

}

- (void)yzmBtnClick{
    if (_phoneTxt.text.length<=0) {
        [HUD show:@"请输入手机号"];
        return;
    }
    NSDictionary *dic = @{@"mobile":_phoneTxt.text,
                          @"businessType":[NSNumber numberWithInt:1]
                          };
    [[UserPL shareManager] userAccountCheckCodeWithDic:dic WithReturnBlock:^(id returnValue) {
        [HUD show:@"短信发送成功，请注意查收"];
         [self timerStart];
    } andErrorBlock:^(NSString *msg) {
        [HUD show:msg];
    }];
    
}

//倒计时
- (void)timerStart
{
    _second = 60;
    [self endTimer];
    [_yzmBtn setTitle:[NSString stringWithFormat:@"%02ds后再获取",(int)_second] forState:UIControlStateNormal];
    _myTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(scrollTimer) userInfo:nil repeats:YES];
}


//计时时钟 每秒刷新
- (void)scrollTimer
{
    dispatch_async(dispatch_get_main_queue(), ^{
        if (--_second > 0){
            NSString *message = [NSString stringWithFormat:@"%02ds后再获取",(int)_second];
            [_yzmBtn setTitle:message forState:UIControlStateNormal];
            _yzmBtn.userInteractionEnabled = NO;
            
        } else {
            //关闭定时器
            _yzmBtn.userInteractionEnabled = YES;
            _yzmBtn.titleLabel.alpha = 1;
            [_yzmBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
            [_myTimer invalidate];
            _myTimer = nil;
        }
    });
}

- (void)endTimer
{
    
    [_myTimer invalidate];
    _myTimer = nil;
}


- (NSDictionary *)returnUpDic{
    if (_phoneTxt.text.length<=0) {
        [HUD show:@"请输入手机号"];
        return nil;
    }
    if (_yzmTxt.text.length<=0) {
        [HUD show:@"请输入验证码"];
        return nil;
    }
    if (_pwdTxt.text.length<=0) {
        [HUD show:@"请输入新密码"];
        return nil;
    }
    NSDictionary *dic = @{@"mobile":_phoneTxt.text,
                          @"checkCode":_yzmTxt.text,
                          @"newPassword":_pwdTxt.text.hu_md5
                          };
    return dic;
}



@end
