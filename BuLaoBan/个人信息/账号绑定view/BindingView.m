//
//  BindingView.m
//  BuLaoBan
//
//  Created by apple on 2019/2/28.
//  Copyright © 2019年 XX. All rights reserved.
//

#import "BindingView.h"

@implementation BindingView{
    UILabel *_statuslab;
    
}

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = UIColorFromRGB(WhiteColorValue);
        [self setUp];
    }
    return self;
}

- (void)setUp{
    CGFloat Width = ScreenWidth-400;
    
    UIImageView *imaView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"BindWeChat"]];
    [self addSubview:imaView];
    imaView.frame = CGRectMake(20, 13, 24, 24);
    UILabel *lab = [BaseViewFactory labelWithFrame:CGRectMake(54, 0, 40, 50) textColor:UIColorFromRGB(BlackColorValue) font:APPFONT13 textAligment:NSTextAlignmentLeft andtext:@"微信"];
    [self addSubview:lab];
    
    
    UIImageView *right = [[UIImageView alloc]initWithFrame:CGRectMake(Width-28  , 18.5, 8, 13)];
    right.image = [UIImage imageNamed:@"right"];
    [self addSubview:right];
    
    _statuslab = [BaseViewFactory labelWithFrame:CGRectMake(200, 0, Width-238, 50) textColor:UIColorFromRGB(0x858585) font:APPFONT13 textAligment:NSTextAlignmentRight andtext:@"未绑定"];
    [self addSubview:_statuslab];
    
    
    
}




@end
