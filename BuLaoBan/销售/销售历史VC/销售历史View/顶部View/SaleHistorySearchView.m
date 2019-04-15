//
//  SaleHistorySearchView.m
//  BuLaoBan
//
//  Created by apple on 2019/2/27.
//  Copyright © 2019年 XX. All rights reserved.
//

#import "SaleHistorySearchView.h"
@interface SaleHistorySearchView ()<UITextFieldDelegate>



@end
@implementation SaleHistorySearchView

-(instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = UIColorFromRGB(0xdcdcdc);
        [self initUI];
    }
    return self;
}

- (void)initUI{
    _searchTxt = [BaseViewFactory textFieldWithFrame:CGRectMake(10, 10, 200, 36) font:APPFONT14 placeholder:@"输入客户" textColor:UIColorFromRGB(BlackColorValue) placeholderColor:UIColorFromRGB(0x858585) delegate:self];
    _searchTxt.backgroundColor = UIColorFromRGB(WhiteColorValue);
    _searchTxt.leftViewMode = UITextFieldViewModeAlways;
    _searchTxt.layer.cornerRadius = 2;
    _searchTxt.leftView = [BaseViewFactory viewWithFrame:CGRectMake(0, 0, 12, 36) color:[UIColor clearColor]];
    [self addSubview:_searchTxt];
    
    UIButton *seacrchBtn = [BaseViewFactory buttonWithFrame:CGRectMake(220, 10, 72, 36) font:APPFONT13 title:@"高级搜索" titleColor:UIColorFromRGB(BlueColorValue) backColor:UIColorFromRGB(WhiteColorValue)];
    seacrchBtn.layer.cornerRadius = 2;
    [self addSubview:seacrchBtn];
    [seacrchBtn addTarget:self action:@selector(seacrchBtnClick) forControlEvents:UIControlEventTouchUpInside];

    
    
    UIView *backView = [BaseViewFactory viewWithFrame:CGRectMake(0, 56, 300, 48) color:UIColorFromRGB(BackColorValue)];
    [self addSubview:backView];
    
    _numLab = [BaseViewFactory labelWithFrame:CGRectMake(10, 0, 280, 48) textColor:UIColorFromRGB(BlackColorValue) font:APPFONT13 textAligment:NSTextAlignmentLeft andtext:@"共0条单据"];
    [backView addSubview:_numLab];
    
}


/**
 sousuo
 */
- (void)seacrchBtnClick{
    
    
    
}

@end
