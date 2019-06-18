//
//  SaleHeaderView.m
//  BuLaoBan
//
//  Created by apple on 2019/2/19.
//  Copyright © 2019年 XX. All rights reserved.
//

#import "SaleHeaderView.h"


@interface SaleHeaderView ()


@end

@implementation SaleHeaderView


-(instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = UIColorFromRGB(WhiteColorValue);
        [self setUP];
    }
    return self;
}


- (void)setUP{
    
    
    UILabel *topLab = [BaseViewFactory labelWithFrame:CGRectMake(0, 20, 924, 20) textColor:UIColorFromRGB(BlackColorValue) font:APPFONT17 textAligment:NSTextAlignmentCenter andtext:@"销售开单"];
    [self addSubview:topLab];
    
    
    UIButton *hisBtn = [BaseViewFactory buttonWithFrame:CGRectMake(10, 20, 76, 44) font:APPFONT14 title:@"销售历史" titleColor:UIColorFromRGB(BlueColorValue) backColor:UIColorFromRGB(WhiteColorValue)];
    [self addSubview:hisBtn];
    [hisBtn addTarget:self action:@selector(hisBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *amountBtn = [BaseViewFactory buttonWithFrame:CGRectMake(86, 20, 96, 44) font:APPFONT14 title:@"销售统计表" titleColor:UIColorFromRGB(BlueColorValue) backColor:UIColorFromRGB(WhiteColorValue)];
    [self addSubview:amountBtn];
    [amountBtn addTarget:self action:@selector(amountBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *GDBtn = [BaseViewFactory buttonWithFrame:CGRectMake(ScreenWidth - 100 -44 -86 - 44 - 20, 20, 48, 44) font:APPFONT14 title:@"挂单" titleColor:UIColorFromRGB(BlueColorValue) backColor:UIColorFromRGB(WhiteColorValue)];
    [self addSubview:GDBtn];
    [GDBtn addTarget:self action:@selector(GDBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    _getBtn= [BaseViewFactory buttonWithFrame:CGRectMake(ScreenWidth - 100 -44 -86 - 20, 20, 86, 44) font:APPFONT14 title:@"取单" titleColor:UIColorFromRGB(BlueColorValue) backColor:UIColorFromRGB(WhiteColorValue)];
    [self addSubview:_getBtn];
    [_getBtn addTarget:self action:@selector(getBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    UIView *line = [BaseViewFactory viewWithFrame:CGRectMake(0, 63, ScreenWidth-100, 1) color:UIColorFromRGB(BackColorValue)];
    [self addSubview:line];
    
    UIButton *resetBtn = [BaseViewFactory buttonWithFrame:CGRectMake(ScreenWidth - 100 -44 - 20, 20, 48, 44) font:APPFONT14 title:@"新开" titleColor:UIColorFromRGB(BlueColorValue) backColor:UIColorFromRGB(WhiteColorValue)];
    [self addSubview:resetBtn];
    [resetBtn addTarget:self action:@selector(resetBtnClick) forControlEvents:UIControlEventTouchUpInside];

}

-(void)setgetBtnNumber:(NSInteger)number{
    [_getBtn setTitle:[NSString stringWithFormat:@"取单(%ld)",number] forState:UIControlStateNormal];
    
}


/**
 查看历史
 */
- (void)hisBtnClick{
    WeakSelf(self);
    if (weakself.returnBlock) {
        weakself.returnBlock(0);
    }
    
}

/**
 销售统计表
 */
- (void)amountBtnClick{
    WeakSelf(self);
    if (weakself.returnBlock) {
        weakself.returnBlock(1);
    }
}

/**
 挂单
 */
- (void)GDBtnClick{
    WeakSelf(self);
    if (weakself.returnBlock) {
        weakself.returnBlock(2);
    }
}

/**
 取单
 */
- (void)getBtnClick{
    WeakSelf(self);
    if (weakself.returnBlock) {
        weakself.returnBlock(3);
    }
}

- (void)resetBtnClick{
    WeakSelf(self);
    if (weakself.returnBlock) {
        weakself.returnBlock(4);
    }
}


@end
