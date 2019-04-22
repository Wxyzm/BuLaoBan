//
//  IdentityController.m
//  BuLaoBan
//
//  Created by souxiuyun on 2019/4/19.
//  Copyright © 2019 XX. All rights reserved.
//

#import "IdentityController.h"

@interface IdentityController ()

@end

@implementation IdentityController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"身份选择";
    [self setBarBackBtnWithImage:nil];
    [self setUP];
}

- (void)setUP{
    YLButton *bossBtn = [BaseViewFactory ylButtonWithFrame:CGRectMake(ScreenWidth/2-220, 180, 120, 162) font:APPFONT16 title:@"我是老板" titleColor:UIColorFromRGB(BlackColorValue) backColor:UIColorFromRGB(WhiteColorValue)];
    [bossBtn setImageRect:CGRectMake(0, 0, 120, 120)];
    [bossBtn setTitleRect:CGRectMake(0, 140, 120, 22)];
    [bossBtn setImage:[UIImage imageNamed:@"boss"] forState:UIControlStateNormal];
    [self.view addSubview:bossBtn];
    [bossBtn addTarget:self action:@selector(bossBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    YLButton *sellerBtn = [BaseViewFactory ylButtonWithFrame:CGRectMake(ScreenWidth/2+100, 180, 120, 162) font:APPFONT16 title:@"我是员工" titleColor:UIColorFromRGB(BlackColorValue) backColor:UIColorFromRGB(WhiteColorValue)];
    [sellerBtn setImageRect:CGRectMake(0, 0, 120, 120)];
    [sellerBtn setTitleRect:CGRectMake(0, 140, 120, 22)];
    [sellerBtn setImage:[UIImage imageNamed:@"seller"] forState:UIControlStateNormal];
    [self.view addSubview:sellerBtn];
    [sellerBtn addTarget:self action:@selector(sellerBtnClick) forControlEvents:UIControlEventTouchUpInside];
}

- (void)bossBtnClick{
    
    
    
}


- (void)sellerBtnClick{
    
    
    
}

@end
