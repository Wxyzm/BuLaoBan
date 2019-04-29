//
//  GoodsCompView.m
//  BuLaoBan
//
//  Created by apple on 2019/2/12.
//  Copyright © 2019年 XX. All rights reserved.
//

#import "GoodsCompView.h"
#import "CompView.h"
#import "Component.h"
@implementation GoodsCompView{
    NSArray *_titleArr;
    NSMutableArray *_BtnArr;
}


-(instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = UIColorFromRGB(WhiteColorValue);
        _BtnArr = [NSMutableArray arrayWithCapacity:0];
        _titleArr =@[@"P:100%",@"C:100%",@"R:100%",@"T:95% SP:5%",@"R:95% SP:5%",@"C:95% SP:5%",@"T:50% R:50%",@"T:65% R:35%",@"T:70% R:30%",@"T:50% C:50%",@"T:65% C:35%",@"T:70% C:30%",@"T:70% L:5%",@"R:85% L:15%"];
        [self initUI];
        
    }
    return self;
}

- (void)initUI{
    
    
    for (int i = 0; i<_titleArr.count; i++) {
        int a = i/4;
        int b = i%4;
        
        UIButton *btn = [BaseViewFactory buttonWithFrame:CGRectMake(40+130*b, 64+50*a, 100, 30) font:APPFONT13 title:_titleArr[i] titleColor:UIColorFromRGB(BlackColorValue) backColor:UIColorFromRGB(WhiteColorValue)];
        btn.layer.cornerRadius = 2;
        btn.tag = 1000 +i;
        btn.layer.borderColor = UIColorFromRGB(BlackColorValue).CGColor;
        btn.layer.borderWidth = 1;
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
        [_BtnArr addObject:btn];
    }
    UILabel *topLab = [BaseViewFactory labelWithFrame:CGRectMake(0, 0, 600, 44) textColor:UIColorFromRGB(WhiteColorValue) font:APPFONT14 textAligment:NSTextAlignmentCenter andtext:@"货品成分"];
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



/**
 保存
 */
- (void)setBtnClick{
    
    
    WeakSelf(self);
    if (weakself.choseBlock) {
        weakself.choseBlock(@"");
    }
    
}
/**
 关闭
 */
- (void)closeBtnCLock{
    WeakSelf(self);
    if (weakself.choseBlock) {
        weakself.choseBlock(@"");
    }
    
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

- (void)refreshWithOutSelected{
    for (UIButton *allBtn in _BtnArr) {
        allBtn.selected = NO;
        [allBtn setTitleColor:UIColorFromRGB(BlackColorValue) forState:UIControlStateNormal];
        allBtn.backgroundColor = UIColorFromRGB(WhiteColorValue);
        allBtn.layer.borderWidth = 1;
    }
}

@end
