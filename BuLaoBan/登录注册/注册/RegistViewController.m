//
//  RegistViewController.m
//  BuLaoBan
//
//  Created by apple on 2019/1/24.
//  Copyright © 2019年 XX. All rights reserved.
//

#import "RegistViewController.h"

@interface RegistViewController ()<UITextFieldDelegate>
@property (nonatomic, strong) NSDictionary  *imageDic;  //防止scroll滑动影响侧滑返回 默认NO

@end

@implementation RegistViewController{
    
    NSMutableArray *_infoArr;
    UIButton *_imaYzmBtn;       //图片验证码
    UIButton *_messYzmBtn;      //手机验证码
    NSArray *_plaArr;
    UIImageView *_codeIma;
    NSTimer         *_myTimer;              //计时器
    NSInteger       _second;                //计时秒数
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self .title = @"注册";
    [self setBarBackBtnWithImage:nil];
    [self initUI];
    [self imaYzmBtnClick];
}

- (void)initUI{
    
    _imaYzmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_imaYzmBtn setTitle:@"换一张" forState:UIControlStateNormal];
    _imaYzmBtn.titleLabel.font = APPFONT14;
    [_imaYzmBtn setTitleColor:UIColorFromRGB(0x20A0FF) forState:UIControlStateNormal];
    [_imaYzmBtn addTarget:self action:@selector(imaYzmBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    _messYzmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_messYzmBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    _messYzmBtn.titleLabel.font = APPFONT14;
    [_messYzmBtn setTitleColor:UIColorFromRGB(0x20A0FF) forState:UIControlStateNormal];
    [_messYzmBtn addTarget:self action:@selector(messageYzmBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    
    _infoArr = [NSMutableArray arrayWithCapacity:0];
    NSArray *imageNameArr = @[@"phone",@"name",@"password",@"yanzm",@"yanzm"];
    _plaArr =@[@"输入手机号",@"输入用户名",@"输入密码",@"输入图片验证码",@"输入手机验证码"];
    _codeIma = [[UIImageView alloc]initWithFrame:CGRectMake(250, 5, 70, 30)];
    for (int i = 0; i<5; i++) {
        UIView *txtView = [self textFieldWithFrame:CGRectMake(52, 0, 200, 40) font:APPFONT14 placeholder:_plaArr[i] textColor:UIColorFromRGB(BlackColorValue) placeholderColor:UIColorFromRGB(LitterBlackColorValue) delegate:self imageName:imageNameArr[i] andTag:1000+i];
        txtView.frame = CGRectMake(ScreenWidth/2-200, 60+56*i, 400, 40);
        [self.view addSubview:txtView];
        [_infoArr addObject:@""];
        if (i==4) {
            [txtView addSubview:_messYzmBtn];
            _messYzmBtn.frame = CGRectMake(290, 0, 110, 40);
        }else if (i==3){
            [txtView addSubview:_imaYzmBtn];
            _imaYzmBtn.frame = CGRectMake(328, 0, 62, 40);
            [txtView addSubview:_codeIma];

        }
    }
    
    YLButton *registBtn = [BaseViewFactory ylButtonWithFrame:CGRectMake(ScreenWidth/2-200, 354, 400, 40) font:APPFONT18 title:@"注册" titleColor:UIColorFromRGB(WhiteColorValue) backColor:UIColorFromRGB(BlueColorValue)];
    registBtn.layer.cornerRadius = 20;
    [self.view  addSubview:registBtn];
    [registBtn addTarget:self action:@selector(registBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc]initWithString:@"注册即表示同意《布管家用户协议》"];
    [AttributedStr addAttribute:NSForegroundColorAttributeName value:UIColorFromRGB(0x20A0FF) range:NSMakeRange(7, 9)];
    UILabel *xieyilab = [BaseViewFactory labelWithFrame:CGRectMake(0, 424, ScreenWidth, 18) textColor:UIColorFromRGB(BlackColorValue) font:APPFONT12 textAligment:NSTextAlignmentCenter andtext:@""];
    [self.view addSubview:xieyilab];
    [xieyilab setAttributedText:AttributedStr];
    
    UIButton *xieyiBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:xieyiBtn];
    [xieyiBtn addTarget:self action:@selector(xieyiBtnClick) forControlEvents:UIControlEventTouchUpInside];
    xieyiBtn.frame = CGRectMake(ScreenWidth/2-200, 424, 400, 18);
    
    
  
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
    NSString *imagelength = _infoArr[3];
    if (imagelength.length<=0) {
        [HUD show:@"请输入图片验证码"];
        return;
    }
    
    NSDictionary *dic = @{@"mobile":namelength,
                          @"businessType":[NSNumber numberWithInt:0],
                          @"imageCheckCode":imagelength,
                          @"imageName":_imageDic[@"imageName"]
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
    [_messYzmBtn setTitle:[NSString stringWithFormat:@"%02ds后再获取",(int)_second] forState:UIControlStateNormal];
    _myTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(scrollTimer) userInfo:nil repeats:YES];
}


//计时时钟 每秒刷新
- (void)scrollTimer
{
    dispatch_async(dispatch_get_main_queue(), ^{
        if (--_second > 0){
            NSString *message = [NSString stringWithFormat:@"%02ds后再获取",(int)_second];
            [_messYzmBtn setTitle:message forState:UIControlStateNormal];
            _messYzmBtn.userInteractionEnabled = NO;
            
        } else {
            //关闭定时器
            _messYzmBtn.userInteractionEnabled = YES;
            _messYzmBtn.titleLabel.alpha = 1;
            [_messYzmBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
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

/**
 图片验证码
 */
- (void)imaYzmBtnClick{
     WeakSelf(self);
    [[UserPL shareManager] userAccountImageCheckCodeWithReturnBlock:^(id returnValue) {
        weakself.imageDic = returnValue;
        [self->_codeIma sd_setImageWithURL:[NSURL URLWithString:returnValue[@"imageKey"]]];
    } andErrorBlock:^(NSString *msg) {
        [HUD show:msg];
    }];
    
   /*
    "code":"200",
    "message":"",
    "imageKey":"http:\\123.png",
    "imageName":"123"
    */
    
}


/**
 查看协议
 */
- (void)xieyiBtnClick{
    
    
}

/**
 注册
 */
-(void)registBtnClick{
    
    for (int i = 0; i<_plaArr.count; i++) {
        NSString *namelength = _infoArr[i];
        if (namelength.length<=0) {
            [HUD show:[NSString stringWithFormat:@"请输入%@",_plaArr[i]]];
            return;
        }
    }
    NSString *pwd = _infoArr[2];
    NSDictionary *dic =@{@"mobile":_infoArr[0],
                         @"password":pwd.hu_md5,
                         @"userName":_infoArr[1],
                         @"checkCode":_infoArr[4],
                         @"platType":@"",
                         @"unionId":@"",
                         @"openAccount":@"",
                         @"avatar":@"",
                         };
    [[UserPL shareManager] userAccountRegisterWithDic:dic WithReturnBlock:^(id returnValue) {
        [HUD show:@"注册成功"];
        [self.navigationController popToRootViewControllerAnimated:YES];
        
    } andErrorBlock:^(NSString *msg) {
        
    }];
    
//    [[HttpClient sharedHttpClient] POST:@"/user/account/register" dict:dic success:^(NSDictionary *resultDic) {
//        NSLog(@"%@",resultDic);
//        if ([resultDic[@"code"] intValue]==200) {
//            [HUD show:@"注册成功"];
//
//        }else{
//            [HUD show:resultDic[@"message"]];
//
//        }
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        [HUD show:[NSString stringWithFormat:@"%@",error]];
//
//    }];
    
    
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
