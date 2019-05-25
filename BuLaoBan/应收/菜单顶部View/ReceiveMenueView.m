//
//  ReceiveMenueView.m
//  BuLaoBan
//
//  Created by apple on 2019/2/27.
//  Copyright © 2019年 XX. All rights reserved.
//

#import "ReceiveMenueView.h"


@interface ReceiveMenueView()

@property (nonatomic, strong) UIButton      *backButton;

@property (nonatomic, strong) UIView      *sideView;

@end

@implementation ReceiveMenueView{
    
    BOOL        _isShow;
    
}

-(instancetype)init{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, 0, ScreenWidth-100, ScreenHeight);
        self.backgroundColor = [UIColor clearColor];
        [self initUI];
    }
    return self;
}


- (void)initUI{
    [self addSubview:self.backButton];
    _sideView = [BaseViewFactory viewWithFrame:CGRectMake(0, 120, 200, 120) color:UIColorFromRGB(WhiteColorValue)];
    _sideView.layer.borderColor = UIColorFromRGB(LineColorValue).CGColor;
    _sideView.layer.borderWidth = 1;
    [self addSubview:_sideView];
    NSArray *titleArr = @[@"应收对账单/货品",@"应收对账单/单据",@"应收款统计表"];
    for (int i = 0; i<titleArr.count; i++) {
        YLButton *btn = [YLButton buttonWithbackgroundColor:UIColorFromRGB(WhiteColorValue) titlecolor:UIColorFromRGB(BlackColorValue) cornerRadius:0 andtarget:self action:@selector(typeBtnCLick:) titleFont:APPFONT14 title:titleArr[i]];
        btn.frame = CGRectMake(0, 40*i, 200, 40);
        btn.tag = 1000 + i;
        btn.titleLabel.textAlignment = NSTextAlignmentLeft;
        [btn setTitleRect:CGRectMake(16, 0, 200, 40)];
        [_sideView addSubview:btn];
        if (i!=0) {
            UIView *line = [BaseViewFactory viewWithFrame:CGRectMake(0, 40*i-0.5, 200, 1) color:UIColorFromRGB(LineColorValue)];
            [_sideView addSubview:line];
        }
    }
}

- (void)typeBtnCLick:(YLButton *)btn{
    WeakSelf(self);
    if (weakself.returnBlock) {
        [self dismiss];
        weakself.returnBlock(btn.tag - 1000);
    }
}

#pragma - mark public method
- (void)showinView:(UIView *)view
{
    [view addSubview:self];
    _isShow = YES;
    [UIView animateWithDuration:0.2 animations:^{
        _sideView.hidden = NO;
        
    }];
    
    
}

- (void)dismiss
{
    if (!_isShow) return;
    _isShow = NO;
    [UIView animateWithDuration:0.2 animations:^{
        _sideView.hidden = YES;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}
#pragma mark ========= get

- (UIButton *)backButton
{
    if (!_backButton) {
        _backButton = [[UIButton alloc] initWithFrame:self.bounds];
        _backButton.backgroundColor = [UIColor clearColor];
        _backButton.alpha = 0.3;
        [_backButton addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    }
    return _backButton;
}


@end
