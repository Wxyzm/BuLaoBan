//
//  GoodsSearchView.m
//  BuLaoBan
//
//  Created by apple on 2019/2/10.
//  Copyright © 2019年 XX. All rights reserved.
//

#import "GoodsSearchView.h"
@interface GoodsSearchView ()<UITextFieldDelegate>

@end

@implementation GoodsSearchView{
    
    UITextField *_searchTxt;
}

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = UIColorFromRGB(LineColorValue);
        [self setUP];
    }
    return self;
}

- (void)setUP{
    _searchTxt = [BaseViewFactory textFieldWithFrame:CGRectMake(10, 10, 200, 36) font:APPFONT14 placeholder:@"输入货品编号/名称" textColor:UIColorFromRGB(BlackColorValue) placeholderColor:UIColorFromRGB(0x858585) delegate:self];
    _searchTxt.backgroundColor = UIColorFromRGB(WhiteColorValue);
    _searchTxt.leftViewMode = UITextFieldViewModeAlways;
    _searchTxt.layer.cornerRadius = 2;
    _searchTxt.leftView = [BaseViewFactory viewWithFrame:CGRectMake(0, 0, 12, 36) color:[UIColor clearColor]];
    [self addSubview:_searchTxt];
    
    UIButton *seacrchBtn = [BaseViewFactory buttonWithFrame:CGRectMake(220, 10, 72, 36) font:APPFONT13 title:@"高级搜索" titleColor:UIColorFromRGB(BlueColorValue) backColor:UIColorFromRGB(WhiteColorValue)];
    seacrchBtn.layer.cornerRadius = 2;
    [self addSubview:seacrchBtn];
    [seacrchBtn addTarget:self action:@selector(seacrchBtnClick) forControlEvents:UIControlEventTouchUpInside];



}

//搜索
- (void)seacrchBtnClick{
    WeakSelf(self);
    if (weakself.returnBlock) {
        weakself.returnBlock(_searchTxt.text.length>0?_searchTxt.text:@"");
    }
}

@end
