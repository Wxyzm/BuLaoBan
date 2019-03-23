//
//  AccountEditView.m
//  BuLaoBan
//
//  Created by souxiuyun on 2019/3/22.
//  Copyright © 2019 XX. All rights reserved.
//

#import "AccountEditView.h"

@interface AccountEditView()<UITextFieldDelegate>

@property (nonatomic,strong) UILabel *nmeLab;




@end

@implementation AccountEditView{
    
    UILabel *_toplab;
    UITextField *_nameTxt;
    UITextField *_numberTxt;
}

-(instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = UIColorFromRGB(WhiteColorValue);
        [self setUP];
    }
    return self;
}

- (void)setUP{
    
  _toplab = [BaseViewFactory labelWithFrame:CGRectMake(0, 0, 600, 44) textColor:UIColorFromRGB(WhiteColorValue) font:APPFONT(14) textAligment:NSTextAlignmentCenter andtext:@"新增账户"];
    [self addSubview:_toplab];
 
    
    UIButton *closeBtn = [BaseViewFactory setImagebuttonWithWidth:16 imagePath:@"window_close"];
    [closeBtn addTarget:self action:@selector(closeBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:closeBtn];
    closeBtn.frame = CGRectMake(564, 14, 16, 16);
    
    _nameTxt = [BaseViewFactory textFieldWithFrame:CGRectMake(120, 88, 460, 44) font:APPFONT13 placeholder:@"输入账户名称" textColor:UIColorFromRGB(BlackColorValue) placeholderColor:nil delegate:self];
    [self addSubview:_nameTxt];

    _numberTxt = [BaseViewFactory textFieldWithFrame:CGRectMake(120, 132, 460, 44) font:APPFONT13 placeholder:@"输入账户名称" textColor:UIColorFromRGB(BlackColorValue) placeholderColor:nil delegate:self];
    [self addSubview:_numberTxt];
    
    NSArray *arr = @[@"账户类型",@"账户名称",@"账号"];
    for (int i = 0; i<3; i++) {
        UILabel *lab = [BaseViewFactory labelWithFrame:CGRectMake(20, 44+44*i, 100, 44) textColor:UIColorFromRGB(BlackColorValue) font:APPFONT(13) textAligment:NSTextAlignmentLeft andtext:arr[i]];
        [self addSubview:lab];
        
        UIView *line = [BaseViewFactory viewWithFrame:CGRectMake(20, 87.5+44*i, 580, 1) color:UIColorFromRGB(LineColorValue)];
        [self addSubview:line];
    }




}


#pragma mark -- 按钮点击

- (void)closeBtnClick{
    
    
}


@end
