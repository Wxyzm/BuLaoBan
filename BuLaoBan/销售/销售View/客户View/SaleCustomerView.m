//
//  SaleCustomerView.m
//  BuLaoBan
//
//  Created by apple on 2019/2/19.
//  Copyright © 2019年 XX. All rights reserved.
//

#import "SaleCustomerView.h"

@interface SaleCustomerView ()


@end
@implementation SaleCustomerView{
    
    UILabel *_wareLab;
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
    UILabel *numLab = [BaseViewFactory labelWithFrame:CGRectMake(0, 0, 52, 50) textColor:UIColorFromRGB(BlackColorValue) font:APPFONT14 textAligment:NSTextAlignmentRight andtext:@"客户*"];
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc]initWithString:@"客户*"];
    [attStr addAttribute:NSForegroundColorAttributeName value:UIColorFromRGB(0xFC3030) range:NSMakeRange(2, 1)];
    numLab.attributedText = attStr;
    [self addSubview:numLab];
    
    _customerBtn = [BaseViewFactory ylButtonWithFrame:CGRectMake(55, 10, 150, 30) font:APPFONT13 title:@"选择客户" titleColor:UIColorFromRGB(BlueColorValue) backColor:UIColorFromRGB(WhiteColorValue)];
    [_customerBtn setTitleRect:CGRectMake(10, 0, 130, 30)];
    _customerBtn.layer.cornerRadius = 2;
    _customerBtn.layer.borderColor = UIColorFromRGB(LineColorValue).CGColor;
    _customerBtn.layer.borderWidth = 1;
    _customerBtn.titleLabel.textAlignment = NSTextAlignmentLeft;
    [_customerBtn addTarget:self action:@selector(customerBtnCLick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_customerBtn];

    UILabel *kindLab = [BaseViewFactory labelWithFrame:CGRectMake(210, 0, 36, 50) textColor:UIColorFromRGB(BlackColorValue) font:APPFONT14 textAligment:NSTextAlignmentRight andtext:@"类型"];
    [self addSubview:kindLab];
    
    _kindBtn = [BaseViewFactory ylButtonWithFrame:CGRectMake(257, 10, 150, 30) font:APPFONT13 title:@"" titleColor:UIColorFromRGB(BlueColorValue) backColor:UIColorFromRGB(WhiteColorValue)];
    [_kindBtn setTitleRect:CGRectMake(10, 0, 130, 30)];
    [_kindBtn setImageRect:CGRectMake(128, 10, 10, 6)];
    [_kindBtn setTitle:@"剪样" forState:UIControlStateNormal];
    _kindBtn.layer.cornerRadius = 2;
    _kindBtn.layer.borderColor = UIColorFromRGB(LineColorValue).CGColor;
    _kindBtn.layer.borderWidth = 1;
    _kindBtn.titleLabel.textAlignment = NSTextAlignmentLeft;
    [_kindBtn addTarget:self action:@selector(kindBtnCLick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_kindBtn];
    
    
   _wareLab = [BaseViewFactory labelWithFrame:CGRectMake(412, 0, 36, 50) textColor:UIColorFromRGB(BlackColorValue) font:APPFONT14 textAligment:NSTextAlignmentRight andtext:@"仓库"];
    [self addSubview:_wareLab];
    _wareBtn = [BaseViewFactory ylButtonWithFrame:CGRectMake(459, 10, 150, 30) font:APPFONT13 title:@"选择仓库" titleColor:UIColorFromRGB(BlueColorValue) backColor:UIColorFromRGB(WhiteColorValue)];
    [_wareBtn setTitleRect:CGRectMake(10, 0, 130, 30)];
    [_wareBtn setImageRect:CGRectMake(128, 10, 10, 6)];
    _wareBtn.layer.cornerRadius = 2;
    _wareBtn.layer.borderColor = UIColorFromRGB(LineColorValue).CGColor;
    _wareBtn.layer.borderWidth = 1;
    _wareBtn.titleLabel.textAlignment = NSTextAlignmentLeft;
    [_wareBtn addTarget:self action:@selector(wareBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_wareBtn];
    
    
    _scanBtn = [BaseViewFactory ylButtonWithFrame:CGRectMake(ScreenWidth-200, 10, 80, 30) font:APPFONT13 title:@"扫码选货" titleColor:UIColorFromRGB(BlueColorValue) backColor:UIColorFromRGB(WhiteColorValue)];
    [_scanBtn setTitleRect:CGRectMake(10, 0, 130, 30)];
    _scanBtn.hidden = YES;
    _scanBtn.layer.cornerRadius = 2;
    _scanBtn.layer.borderColor = UIColorFromRGB(BlueColorValue).CGColor;
    _scanBtn.layer.borderWidth = 1;
    [_scanBtn addTarget:self action:@selector(scanBtnCLick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_scanBtn];
    [self wareBtnIsshow:NO];

}
- (void)wareBtnIsshow:(BOOL)isShow{
    if (isShow) {
        _wareBtn.hidden = NO;
        _wareLab.hidden = NO;
    }else{
        _wareBtn.hidden = YES;
        _wareLab.hidden = YES;
    }
}


/**
 选择客户
 */
- (void)customerBtnCLick{
    WeakSelf(self);
    if (weakself.returnBlock) {
        weakself.returnBlock(0);
    }
}

/**
 类型
 */
- (void)kindBtnCLick{
    WeakSelf(self);
    if (weakself.returnBlock) {
        weakself.returnBlock(1);
    }
}

/**
 扫码选货
 */
- (void)scanBtnCLick{
    WeakSelf(self);
    if (weakself.returnBlock) {
        weakself.returnBlock(2);
    }
}


/**
 选择仓库
 */
- (void)wareBtnClick{
    WeakSelf(self);
    if (weakself.returnBlock) {
        weakself.returnBlock(3);
    }
}

@end
