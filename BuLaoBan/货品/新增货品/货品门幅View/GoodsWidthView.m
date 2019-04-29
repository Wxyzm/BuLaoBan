//
//  GoodsWidthView.m
//  BuLaoBan
//
//  Created by apple on 2019/2/12.
//  Copyright © 2019年 XX. All rights reserved.
//

#import "GoodsWidthView.h"

@implementation GoodsWidthView{
    NSArray *_titleArr;
    NSMutableArray *_BtnArr;
}

-(instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = UIColorFromRGB(WhiteColorValue);
        _BtnArr = [NSMutableArray arrayWithCapacity:0];
        _titleArr =@[@"110cm",@"115cm",@"120cm",@"125cm",@"130cm",@"135cm",@"140cm",@"145cm",@"150cm",@"155cm",@"160cm",@"165cm",@"170cm",@"175cm",@"180cm",@"185cm",@"56/57inch",@"57/58inch"];
        [self initUI];
        
    }
    return self;
}

- (void)initUI{
    
    for (int i = 0; i<_titleArr.count; i++) {
        int a = i/5;
        int b = i%5;
        
        UIButton *btn = [BaseViewFactory buttonWithFrame:CGRectMake(40+110*b, 64+50*a, 80, 30) font:APPFONT13 title:_titleArr[i] titleColor:UIColorFromRGB(BlackColorValue) backColor:UIColorFromRGB(WhiteColorValue)];
        btn.layer.cornerRadius = 2;
        btn.tag = 1000 +i;
        btn.layer.borderColor = UIColorFromRGB(BlackColorValue).CGColor;
        btn.layer.borderWidth = 1;
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
        [_BtnArr addObject:btn];
    }
    UILabel *topLab = [BaseViewFactory labelWithFrame:CGRectMake(0, 0, 600, 44) textColor:UIColorFromRGB(WhiteColorValue) font:APPFONT14 textAligment:NSTextAlignmentCenter andtext:@"货品门幅"];
    topLab.backgroundColor = UIColorFromRGB(BlueColorValue);
    [self addSubview:topLab];
    UIButton *closeBtn = [BaseViewFactory setImagebuttonWithWidth:13 imagePath:@"window_close"];
    [closeBtn addTarget:self action:@selector(closeBtnCLock) forControlEvents:UIControlEventTouchUpInside];
    closeBtn.frame = CGRectMake(563, 14, 23, 23);
    [self addSubview:closeBtn];
    
    UIButton *setBtn = [BaseViewFactory buttonWithFrame:CGRectMake(150, 264, 300, 40) font:APPFONT14 title:@"保存" titleColor:UIColorFromRGB(WhiteColorValue) backColor:UIColorFromRGB(BlueColorValue)];
    setBtn.layer.cornerRadius = 2;
    [self addSubview:setBtn];
    [setBtn addTarget:self action:@selector(setBtnClick) forControlEvents:UIControlEventTouchUpInside];
}

- (void)btnClick:(UIButton *)btn{
    for (UIButton *allBtn in _BtnArr) {
        allBtn.selected = NO;
        [allBtn setTitleColor:UIColorFromRGB(BlackColorValue) forState:UIControlStateNormal];
        allBtn.backgroundColor = UIColorFromRGB(WhiteColorValue);
        allBtn.layer.borderWidth = 1;
    }
    btn.selected = YES;
    [btn setTitleColor:UIColorFromRGB(WhiteColorValue) forState:UIControlStateNormal];
    btn.backgroundColor = UIColorFromRGB(BlueColorValue);
    btn.layer.borderWidth = 0;
    
    WeakSelf(self);
    if (weakself.choseBlock) {
        weakself.choseBlock(_titleArr[btn.tag - 1000]);
    }
}

- (void)closeBtnCLock{
    WeakSelf(self);
    if (weakself.choseBlock) {
        weakself.choseBlock(@"");
    }
}

- (void)setBtnClick{
    
    WeakSelf(self);
    if (weakself.choseBlock) {
        weakself.choseBlock(@"");
    }
}

- (void)refreshWithOutSelected{
    for (UIButton *allBtn in _BtnArr) {
        allBtn.selected = NO;
        [allBtn setTitleColor:UIColorFromRGB(BlackColorValue) forState:UIControlStateNormal];
        allBtn.backgroundColor = UIColorFromRGB(WhiteColorValue);
        allBtn.layer.borderWidth = 1;
    }
}
@end
