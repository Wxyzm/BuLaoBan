//
//  ReceivablesView.m
//  BuLaoBan
//
//  Created by souxiuyun on 2019/3/22.
//  Copyright © 2019 XX. All rights reserved.
//

#import "ReceivablesView.h"

@implementation ReceivablesView{
    
    
}

-(void)awakeFromNib{
    [super awakeFromNib];
    
    _accountBtn  = [BaseViewFactory ylButtonWithFrame:CGRectMake(100, 132, 480, 44) font:APPFONT13 title:@"" titleColor:UIColorFromRGB(BlackColorValue) backColor:UIColorFromRGB(WhiteColorValue)];
    [_accountBtn setImage:[UIImage imageNamed:@"down_chose"] forState:UIControlStateNormal];
    _accountBtn.titleLabel.textAlignment = NSTextAlignmentRight;
    [_accountBtn setTitleRect:CGRectMake(0, 0, 465, 44)];
    [_accountBtn setImageRect:CGRectMake(470, 20, 14, 14)];
    [self addSubview:_accountBtn];
    
    
    for (int i = 0; i<4; i++) {
        UIView *line = [BaseViewFactory viewWithFrame:CGRectMake(20, 87.5+44*i, 580, 1) color:UIColorFromRGB(LineColorValue)];
        [self addSubview:line];
    }
    
    
    
    
}




@end
