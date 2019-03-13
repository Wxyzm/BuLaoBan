//
//  DIYSearchKeyBoardView.m
//  BuLaoBan
//
//  Created by apple on 2019/2/19.
//  Copyright © 2019年 XX. All rights reserved.
//

#import "DIYSearchKeyBoardView.h"

@interface DIYSearchKeyBoardView ()<UITextFieldDelegate>

@property (nonatomic, strong) UITextField *numTxt;          //输入货号
@property (nonatomic, strong) NSMutableArray *KeyboardArr;  //数字键盘



@end

@implementation DIYSearchKeyBoardView{
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
    
    UIView *view = [BaseViewFactory viewWithFrame:CGRectMake(0, 0, 220, 60) color:UIColorFromRGB(0xbdbdbd)];
    [self addSubview:view];
    _numTxt = [BaseViewFactory textFieldWithFrame:CGRectMake(10, 7, 200, 44) font:APPFONT14 placeholder:@"输入货号" textColor:UIColorFromRGB(BlackColorValue) placeholderColor:UIColorFromRGB(PLAColorValue) delegate:self];
    _numTxt.keyboardType = UIKeyboardTypeASCIICapable;
    _numTxt.leftViewMode =UITextFieldViewModeAlways;
    _numTxt.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 12, 44)];
    [view addSubview:_numTxt];
    _numTxt.backgroundColor = UIColorFromRGB(WhiteColorValue);
    [_numTxt addTarget:self
                   action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
    _titleArr = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"",@"0",@"-"];
    for (int i = 0; i<_titleArr.count; i++) {
        int a = i/3;
        int b = i%3;
        YLButton *btn = [BaseViewFactory ylButtonWithFrame:CGRectMake(10 + 70*b, 76 +70*a, 60, 60) font:APPFONT16 title:_titleArr[i] titleColor:UIColorFromRGB(BlackColorValue) backColor:UIColorFromRGB(WhiteColorValue)];
        btn.tag = 1000 +i;
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
        
        if (i == 9) {
            [btn setImage:[UIImage imageNamed:@"sc"] forState:UIControlStateNormal];
            [btn setImageRect:CGRectMake(20, 21, 19, 14)];
        }
        
    }
    YLButton *azbtn = [BaseViewFactory ylButtonWithFrame:CGRectMake(10, 362, 200, 50) font:APPFONT16 title:@"A ~ Z" titleColor:UIColorFromRGB(BlackColorValue) backColor:UIColorFromRGB(WhiteColorValue)];
    azbtn.tag = 1000 +12;
    [azbtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:azbtn];
}


- (void)btnClick:(YLButton *)btn{
    
    NSInteger tag = btn.tag -1000;
    if (tag ==12) {
        //A ~ Z
        [_numTxt becomeFirstResponder];
    }else if (tag ==9){
        //删除
        if (_numTxt.text.length>0) {
          _numTxt.text = [_numTxt.text substringToIndex:_numTxt.text.length - 1];
        }
        WeakSelf(self);
        if (weakself.returnBlock) {
            weakself.returnBlock(_numTxt.text);
        }
    }else{
       //拼接
        _numTxt.text = [NSString stringWithFormat:@"%@%@",_numTxt.text,_titleArr[tag]];
        WeakSelf(self);
        if (weakself.returnBlock) {
            weakself.returnBlock(_numTxt.text);
        }
    }
   
}

#pragma mark ====== textfieldDidChange
- (void)textFieldDidChange:(UITextField *)textField
{
    WeakSelf(self);
    if (weakself.returnBlock) {
        weakself.returnBlock(textField.text);
    }
}





@end
