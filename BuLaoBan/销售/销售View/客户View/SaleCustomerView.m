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
@implementation SaleCustomerView

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
    _kindBtn.layer.cornerRadius = 2;
    _kindBtn.layer.borderColor = UIColorFromRGB(LineColorValue).CGColor;
    _kindBtn.layer.borderWidth = 1;
    _kindBtn.titleLabel.textAlignment = NSTextAlignmentLeft;
    [_kindBtn addTarget:self action:@selector(kindBtnCLick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_kindBtn];
    
    _scanBtn = [BaseViewFactory ylButtonWithFrame:CGRectMake(ScreenWidth-200, 10, 80, 30) font:APPFONT13 title:@"扫码选货" titleColor:UIColorFromRGB(BlueColorValue) backColor:UIColorFromRGB(WhiteColorValue)];
    [_scanBtn setTitleRect:CGRectMake(10, 0, 130, 30)];
    _scanBtn.layer.cornerRadius = 2;
    _scanBtn.layer.borderColor = UIColorFromRGB(BlueColorValue).CGColor;
    _scanBtn.layer.borderWidth = 1;
    [_scanBtn addTarget:self action:@selector(scanBtnCLick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_scanBtn];

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

@end
