//
//  RightMenueView.m
//  BuLaoBan
//
//  Created by souxiuyun on 2019/3/6.
//  Copyright © 2019 XX. All rights reserved.
//

#import "RightMenueView.h"
@interface RightMenueView ()

@property (nonatomic, strong) UIView *sideView;      //显示内容


@property (nonatomic, strong) UIButton *backButton;  //背景Button

@end

@implementation RightMenueView{
    NSArray *_titleArr;
}


-(instancetype)initWithTitleArr:(NSArray *)titleArr{
    self = [super init];
    if (self) {
        _titleArr = titleArr;
        self.hidden = YES;
        self.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
        self.backgroundColor = [UIColor clearColor];
        [self setUP];
    }
    return self;
}

- (void)setUP{
    [self addSubview:self.backButton];
    
    _sideView = [BaseViewFactory viewWithFrame:CGRectMake(ScreenWidth-300, 64, 200, 40*_titleArr.count) color:UIColorFromRGB(WhiteColorValue)];
    [self addSubview:_sideView];
    _sideView.layer.borderWidth = 1;
    _sideView.layer.borderColor = UIColorFromRGB(LineColorValue).CGColor;
    if (_titleArr.count<=0) {
        return;
    }
    
    for (int i = 0; i<_titleArr.count; i++) {
        UILabel *lab = [BaseViewFactory labelWithFrame:CGRectMake(16, 40*i, 200, 40) textColor:UIColorFromRGB(BlackColorValue) font:APPFONT14 textAligment:NSTextAlignmentLeft andtext:_titleArr[i]];
        [_sideView addSubview:lab];
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.tag = 1000 + i;
        btn.frame = CGRectMake(16, 40*i, 200, 40);
        
        [btn addTarget:self action:@selector(menueBtnCLick:) forControlEvents:UIControlEventTouchUpInside];
        [_sideView addSubview:btn];
        if (i!=0) {
            UIView *line = [BaseViewFactory viewWithFrame:CGRectMake(0, 40*i -0.5 , 200, 1) color:UIColorFromRGB(LineColorValue)];
            [_sideView addSubview:line];
        }
    }

}


#pragma mark ========= 点击d菜单

- (void)menueBtnCLick:(UIButton *)btn{
    
    self.hidden = YES;
    WeakSelf(self);
    if (weakself) {
        weakself.returnBlock(btn.tag-1000);
    }
}

- (void)backButtonClick{
    self.hidden = YES;
}

#pragma mark ========= get

- (UIButton *)backButton
{
    if (!_backButton) {
        _backButton = [[UIButton alloc] initWithFrame:self.bounds];
        _backButton.backgroundColor = [UIColor clearColor];
        [_backButton addTarget:self action:@selector(backButtonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _backButton;
}

@end
