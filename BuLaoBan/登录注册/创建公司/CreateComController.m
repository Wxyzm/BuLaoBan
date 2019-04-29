//
//  CreateComController.m
//  BuLaoBan
//
//  Created by souxiuyun on 2019/4/19.
//  Copyright © 2019 XX. All rights reserved.
//

#import "CreateComController.h"
#import "KindChoseController.h"

@interface CreateComController ()<UITextFieldDelegate>

@end

@implementation CreateComController{
    UITextField *_comNameTxt;
    YLButton *_kindBtn;
    UITextField *_nameTxt;
    UITextField *_phoneTxt;
    NSInteger kind;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setBarBackBtnWithImage:nil];
    self.title = @"创建公司";
    self.view.backgroundColor = UIColorFromRGB(BackColorValue);
    [self initUI];
}

- (void)initUI{
    UIView *topView = [BaseViewFactory viewWithFrame:CGRectMake(0, 0, ScreenWidth, 200) color:UIColorFromRGB(WhiteColorValue)];
    [self.view addSubview:topView];
    
    NSArray *titleArr = @[@"公司全称*",@"公司类型",@"联系人",@"手机号码"];
    for (int i = 0; i<4; i++) {
        UILabel *namelab = [BaseViewFactory labelWithFrame:CGRectMake(30, 50*i, 200, 50) textColor:UIColorFromRGB(BlackColorValue) font:APPFONT16 textAligment:NSTextAlignmentLeft andtext:@""];
        [topView addSubview:namelab];
        
        if (i==0) {
            namelab.attributedText = [self modifyDigitalColor:UIColorFromRGB(RedColorValue) normalColor:UIColorFromRGB(BlackColorValue) aneText:titleArr[i]];
        }else{
            namelab.text = titleArr[i];
            UIView *line = [BaseViewFactory viewWithFrame:CGRectMake(30, 50*i-0.5, ScreenWidth-60, 1) color:UIColorFromRGB(BackColorValue)];
            [topView addSubview:line];
            
        }
    }
    _comNameTxt = [BaseViewFactory textFieldWithFrame:CGRectMake(200, 0, ScreenWidth-230, 50) font:APPFONT14 placeholder:@"输入公司全称(创建后不可修改)" textColor:UIColorFromRGB(BlackColorValue) placeholderColor:nil delegate:self];
    _comNameTxt.textAlignment = NSTextAlignmentRight;
    [topView addSubview:_comNameTxt];

    _kindBtn = [BaseViewFactory ylButtonWithFrame:CGRectMake(ScreenWidth-30-100, 50, 100, 50) font:APPFONT14 title:@"选择类型" titleColor:UIColorFromRGB(0xBDBDBD) backColor:UIColorFromRGB(WhiteColorValue)];
    _kindBtn.titleLabel.textAlignment = NSTextAlignmentRight;
    [_kindBtn setTitleRect:CGRectMake(0, 0, 72, 50)];
    [_kindBtn setImageRect:CGRectMake(92, 18, 8, 14)];
    [_kindBtn setImage:[UIImage imageNamed:@"right"] forState:UIControlStateNormal];
    [topView addSubview:_kindBtn];
    [_kindBtn addTarget:self action:@selector(kindBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    _nameTxt  = [BaseViewFactory textFieldWithFrame:CGRectMake(200, 100, ScreenWidth-230, 50) font:APPFONT14 placeholder:@"输入联系人姓名" textColor:UIColorFromRGB(BlackColorValue) placeholderColor:nil delegate:self];
    _nameTxt.textAlignment = NSTextAlignmentRight;
    [topView addSubview:_nameTxt];
    
    _phoneTxt  = [BaseViewFactory textFieldWithFrame:CGRectMake(200, 150, ScreenWidth-230, 50) font:APPFONT14 placeholder:@"默认注册的手机号" textColor:UIColorFromRGB(BlackColorValue) placeholderColor:nil delegate:self];
    _phoneTxt.textAlignment = NSTextAlignmentRight;
    [topView addSubview:_phoneTxt];

    UIButton *setBtn = [BaseViewFactory buttonWithFrame:CGRectMake(ScreenWidth/2-200, 400, 400, 40) font:APPFONT18 title:@"确定" titleColor:UIColorFromRGB(WhiteColorValue) backColor:UIColorFromRGB(BlueColorValue)];
    setBtn.layer.cornerRadius = 20;
    [setBtn addTarget:self action:@selector(setBtnCLick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:setBtn];

}

- (void)kindBtnClick{
    
    KindChoseController *kindVc = [[KindChoseController alloc]init];
    kindVc.returnBlock = ^(NSInteger index) {
        kind = index;
        NSArray *titlrArr = @[@"供应商",@"客户",@"其他"];
        [_kindBtn setTitle:titlrArr[index -1] forState:UIControlStateNormal];
        [_kindBtn setTitleColor:UIColorFromRGB(BlackColorValue) forState:UIControlStateNormal];
    };
    [self.navigationController pushViewController:kindVc animated:YES];    
}

//提交
- (void)setBtnCLick{
    if (_comNameTxt.text.length<=0) {
        [HUD show:@"输入公司全称"];
        return;
    }
    
    NSMutableDictionary *setDic = [[NSMutableDictionary alloc]init];
    [setDic setObject:_comNameTxt.text forKey:@"name"];
    //公司类型（1:供应商 2:客户 3: 其他）
    if (kind) {
        [setDic setObject:[NSString stringWithFormat:@"%ld",kind] forKey:@"nature"];
    }
    if (_nameTxt.text.length>0) {
        [setDic setObject:_nameTxt.text forKey:@"linkman"];
    }
    if (_phoneTxt.text.length>0) {
        [setDic setObject:_phoneTxt.text forKey:@"telephone"];
    }
    [[HttpClient sharedHttpClient] requestPOST:@"/companys" Withdict:setDic WithReturnBlock:^(id returnValue) {
        [HUD show:@"创建成功"];
        User *user = [[UserPL shareManager] getLoginUser];
        user.defutecompanyName = _comNameTxt.text;
        user.defutecompanyId = returnValue[@"companyId"];
        [[UserPL shareManager] setUserData:user];
        [[UserPL shareManager] writeUser];
        [[UserPL shareManager] showHomeViewController];
    } andErrorBlock:^(NSString *msg) {
        
    }];
 
}


/**
修改字符串中数字颜色, 并返回对应富文本
@param color 数字颜色, 包括小数
@param normalColor 默认颜色
@return 结果富文本
*/
- (NSMutableAttributedString *)modifyDigitalColor:(UIColor *)color normalColor:(UIColor *)normalColor aneText:(NSString *)text
{
    NSRegularExpression *regular = [NSRegularExpression regularExpressionWithPattern:@"([0-9]\\d*\\.?\\d*)" options:0 error:NULL];
    NSArray<NSTextCheckingResult *> *ranges = [regular matchesInString:text options:0 range:NSMakeRange(0, [text length])];
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:text attributes:@{NSForegroundColorAttributeName : normalColor}];
    for (int i = 0; i < ranges.count; i++) {
        [attStr setAttributes:@{NSForegroundColorAttributeName : color} range:ranges[i].range];
    }
    return attStr;
}

@end
