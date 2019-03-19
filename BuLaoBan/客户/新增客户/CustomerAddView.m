//
//  CustomerAddView.m
//  BuLaoBan
//
//  Created by souxiuyun on 2019/3/19.
//  Copyright © 2019 XX. All rights reserved.
//

#import "CustomerAddView.h"
#import "ComCustomerDetail.h"
@interface CustomerAddView ()<UITextFieldDelegate>

@end
@implementation CustomerAddView

-(instancetype)init{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
        self.backgroundColor = [UIColor clearColor];
        [self setUP];
        
    }
    return self;
}

- (void)setUP{
    [[NSBundle mainBundle] loadNibNamed:@"CustomerAddView" owner:self options:nil];
    [self addSubview:self.sideView];
    _salerBtn = [BaseViewFactory ylButtonWithFrame:CGRectMake(100, 264, 480, 44) font:APPFONT13 title:@"" titleColor:UIColorFromRGB(BlackColorValue) backColor:UIColorFromRGB(WhiteColorValue)];
    [_salerBtn setImage:[UIImage imageNamed:@"down_chose"] forState:UIControlStateNormal];
    _salerBtn.titleLabel.textAlignment = NSTextAlignmentRight;
    [_salerBtn setTitleRect:CGRectMake(0, 0, 465, 44)];
    [_salerBtn setImageRect:CGRectMake(470, 20, 14, 14)];
    [self.showView addSubview:_salerBtn];
    
    _spartakeBtn= [BaseViewFactory ylButtonWithFrame:CGRectMake(100, 308, 480, 44) font:APPFONT13 title:@"" titleColor:UIColorFromRGB(BlackColorValue) backColor:UIColorFromRGB(WhiteColorValue)];
    [_spartakeBtn setImage:[UIImage imageNamed:@"down_chose"] forState:UIControlStateNormal];
    _spartakeBtn.titleLabel.textAlignment = NSTextAlignmentRight;
    [_spartakeBtn setTitleRect:CGRectMake(0, 0, 465, 44)];
    [_spartakeBtn setImageRect:CGRectMake(470, 20, 14, 14)];
    [self.showView addSubview:_spartakeBtn];
    for (int i = 0; i<9; i++) {
        UIView *LINE = [BaseViewFactory viewWithFrame:CGRectMake(20, 88+44*i-0.5, 580, 1) color:UIColorFromRGB(LineColorValue)];
        [self.showView addSubview:LINE];

    }
    
}


-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [[IQKeyboardManager sharedManager] goNext];
    return YES;
}

-(void)setModel:(ComCustomerDetail *)model{
    _model = model;
    _comNameTxt.text = model.name;
   // _linkManTxt.text = model.
    
    
    
    
}



@end
