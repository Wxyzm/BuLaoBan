//
//  SettleKeyBoardView.m
//  BuLaoBan
//
//  Created by apple on 2019/2/25.
//  Copyright © 2019年 XX. All rights reserved.
//

#import "SettleKeyBoardView.h"

@interface SettleKeyBoardView ()

@property (nonatomic, strong) NSMutableArray *KeyboardArr;  //数字键盘

@end

@implementation SettleKeyBoardView{
    NSArray *_titleArr;
    
}


-(instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = UIColorFromRGB(0xdcdcdc);
        [self setUP];
    }
    return self;
}


- (void)setUP{
    _titleArr = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"0",@"00",@"."];
    for (int i = 0; i<_titleArr.count; i++) {
        int a = i/3;
        int b = i%3;
        YLButton *btn = [BaseViewFactory ylButtonWithFrame:CGRectMake(32 + 120*b, 35 +80*a, 100, 70) font:APPFONT16 title:_titleArr[i] titleColor:UIColorFromRGB(BlackColorValue) backColor:UIColorFromRGB(WhiteColorValue)];
        btn.tag = 1000 +i;
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
    }
    YLButton *btn = [BaseViewFactory ylButtonWithFrame:CGRectMake(392, 35 , 100, 70) font:APPFONT16 title:@"" titleColor:UIColorFromRGB(BlackColorValue) backColor:UIColorFromRGB(WhiteColorValue)];
    btn.tag = 1000 +12;
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [btn setImage:[UIImage imageNamed:@"sc"] forState:UIControlStateNormal];
    [btn setImageRect:CGRectMake(38, 26, 25, 18)];
    [self addSubview:btn];
    
    YLButton *deletebtn = [BaseViewFactory ylButtonWithFrame:CGRectMake(392, 115 , 100, 70) font:APPFONT16 title:@"-" titleColor:UIColorFromRGB(BlackColorValue) backColor:UIColorFromRGB(WhiteColorValue)];
    deletebtn.tag = 1000 +13;
    [deletebtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:deletebtn];
    
    YLButton *setbtn = [BaseViewFactory ylButtonWithFrame:CGRectMake(392, 195 , 100, 150) font:APPFONT16 title:@"结算" titleColor:UIColorFromRGB(WhiteColorValue) backColor:UIColorFromRGB(BlueColorValue)];
    setbtn.tag = 1000 +14;
    [setbtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:setbtn];
    
}


- (void)btnClick:(YLButton *)btn{
    
    WeakSelf(self);
    NSInteger tag = btn.tag -1000;
    if (tag ==12){
        //删除
        weakself.returnBlock(@"");
       
        
    }else if (tag ==13){
        weakself.returnBlock(@"-");
    }else if (tag ==14){
        weakself.returnBlock(@"set");
    }
    else{
        //拼接
        weakself.returnBlock(_titleArr[tag]);
    }
    
}






@end
