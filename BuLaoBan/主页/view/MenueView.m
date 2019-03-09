//
//  MenueView.m
//  BuLaoBan
//
//  Created by apple on 2019/1/28.
//  Copyright © 2019年 XX. All rights reserved.
//

#import "MenueView.h"

@implementation MenueView{
    
    NSMutableArray *_btnArr;
    
}

-(instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = UIColorFromRGB(WhiteColorValue);
        _btnArr = [NSMutableArray arrayWithCapacity:0];
        [self setUP];
    }
    
    return self;
}


- (void)setUP{
    NSArray *titleArr = @[@"销售",@"应收",@"货品",@"客户",@"设置"];
    NSArray *imageNameArr = @[@"sale_menue",@"receiva_menue",@"goods_menue",@"customer_menue",@"set_menue"];

    for (int i = 0; i<5; i++) {
        YLButton *leftBtn = [BaseViewFactory ylButtonWithFrame:CGRectMake(0, 95+90*i, 100, 90) font:APPFONT14 title:titleArr[i] titleColor:UIColorFromRGB(BlackColorValue) backColor:UIColorFromRGB(WhiteColorValue)];
        [leftBtn addTarget:self action:@selector(leftBtnCLick:) forControlEvents:UIControlEventTouchUpInside];
        [leftBtn setImage:[UIImage imageNamed:imageNameArr[i]] forState:UIControlStateNormal];
        leftBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        leftBtn.tag = 1000 + i;
        [self addSubview:leftBtn];
        [leftBtn setTitleRect:CGRectMake(0, 56, 100, 18)];
        [leftBtn setImageRect:CGRectMake(32, 10, 36, 36)];
        [_btnArr addObject:leftBtn];
        if (i == 0) {
            leftBtn.on = YES;
            leftBtn.backgroundColor = UIColorFromRGB(BackColorValue);
        }else if (i ==4){
            //设置
            leftBtn.frame = CGRectMake(0, ScreenHeight-130, 100, 90);
            
        }
        
    }
   
    
    _faceIma = [[UIImageView alloc]initWithFrame:CGRectMake(25, 25, 50, 50)];
    [self addSubview:_faceIma];
    _faceIma.clipsToBounds = YES;
    _faceIma.layer.cornerRadius = 25;
    _faceIma.backgroundColor = UIColorFromRGB(BackColorValue);
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:btn];
    btn.frame = CGRectMake(25, 25, 50, 50);
    [btn addTarget:self action:@selector(faceBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
}


- (void)leftBtnCLick:(YLButton *)btn{
    for (YLButton *leftBtn in _btnArr) {
        leftBtn.on = NO;
        leftBtn.backgroundColor = UIColorFromRGB(WhiteColorValue);

    }
    btn.selected = YES;
    btn.backgroundColor = UIColorFromRGB(BackColorValue);
    WeakSelf(self);
    if (weakself.returnBlock) {
        weakself.returnBlock(btn.tag - 1000+1);
    }
}



- (void)faceBtnClick{
    for (YLButton *leftBtn in _btnArr) {
        leftBtn.on = NO;
        leftBtn.backgroundColor = UIColorFromRGB(WhiteColorValue);
        
    }
    WeakSelf(self);
    if (weakself.returnBlock) {
        weakself.returnBlock(0);
    }
}





@end
