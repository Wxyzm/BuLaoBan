//
//  TopSearchView.m
//  BuLaoBan
//
//  Created by souxiuyun on 2019/4/1.
//  Copyright © 2019 XX. All rights reserved.
//

#import "TopSearchView.h"

@interface TopSearchView ()<UITextFieldDelegate>

@property (nonatomic, strong) UIButton      *backButton;

@property (nonatomic, strong) UIView      *sideView;

@end


@implementation TopSearchView{
    UITextField *_numberTxt;
    UITextField *_nameTxt;
    UITextField *_copTxt;
    UITextField *_specTxt;
    UITextField *_widthMinTxt;
    UITextField *_widthMaxTxt;
    UITextField *_weightMinTxt;
    UITextField *_weightMaxTxt;
    YLButton *_haveImaBtn;
    YLButton *_noImaBtn;
    BOOL _isShow;
    NSInteger _isHaveIma;   //0:无要求  1：有图  2：无图
}

-(instancetype)init{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
        self.backgroundColor = [UIColor clearColor];
        _isHaveIma = 0;
        [self setUP];
    }
    return self;
}
-(void)setUP{
    [self addSubview:self.backButton];
    
    _sideView = [BaseViewFactory viewWithFrame:CGRectMake(ScreenWidth/2-300, 200, 600, 300) color:UIColorFromRGB(WhiteColorValue)];
    [self addSubview:_sideView];
    
    UILabel *topLab = [BaseViewFactory labelWithFrame:CGRectMake(0, 0, 600, 44) textColor:UIColorFromRGB(WhiteColorValue) font:APPFONT14 textAligment:NSTextAlignmentCenter andtext:@"货品高级搜索"];
    topLab.backgroundColor = UIColorFromRGB(BlueColorValue);
    [_sideView addSubview:topLab];
    UIButton *closeBtn = [BaseViewFactory setImagebuttonWithWidth:13 imagePath:@"window_close"];
    [closeBtn addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    closeBtn.frame = CGRectMake(563, 14, 23, 23);
    [_sideView addSubview:closeBtn];
    
   
    
    _numberTxt = [BaseViewFactory textFieldWithFrame:CGRectMake(80, 44, 190, 44) font:APPFONT13 placeholder:@"输入货号" textColor:UIColorFromRGB(BlackColorValue) placeholderColor:nil delegate:self];
    _numberTxt.textAlignment = NSTextAlignmentRight;
    [_sideView addSubview:_numberTxt];

    _nameTxt = [BaseViewFactory textFieldWithFrame:CGRectMake(380, 44, 190, 44) font:APPFONT13 placeholder:@"输入品名" textColor:UIColorFromRGB(BlackColorValue) placeholderColor:nil delegate:self];
    _nameTxt.textAlignment = NSTextAlignmentRight;
    [_sideView addSubview:_nameTxt];
    
    _copTxt = [BaseViewFactory textFieldWithFrame:CGRectMake(80, 84, 190, 44) font:APPFONT13 placeholder:@"输入成分" textColor:UIColorFromRGB(BlackColorValue) placeholderColor:nil delegate:self];
    _copTxt.textAlignment = NSTextAlignmentRight;
    [_sideView addSubview:_copTxt];
    
    _specTxt = [BaseViewFactory textFieldWithFrame:CGRectMake(380, 84, 190, 44) font:APPFONT13 placeholder:@"输入规格" textColor:UIColorFromRGB(BlackColorValue) placeholderColor:nil delegate:self];
    _specTxt.textAlignment = NSTextAlignmentRight;
    [_sideView addSubview:_specTxt];
    
    _widthMinTxt= [BaseViewFactory textFieldWithFrame:CGRectMake(108, 124, 62, 44) font:APPFONT13 placeholder:@"输入门幅" textColor:UIColorFromRGB(BlackColorValue) placeholderColor:nil delegate:self];
    _widthMinTxt.textAlignment = NSTextAlignmentRight;
    [_sideView addSubview:_widthMinTxt];
    
    _widthMaxTxt= [BaseViewFactory textFieldWithFrame:CGRectMake(208, 124, 62, 44) font:APPFONT13 placeholder:@"输入门幅" textColor:UIColorFromRGB(BlackColorValue) placeholderColor:nil delegate:self];
    _widthMaxTxt.textAlignment = NSTextAlignmentRight;
    [_sideView addSubview:_widthMaxTxt];
    
    _weightMinTxt= [BaseViewFactory textFieldWithFrame:CGRectMake(408, 124, 62, 44) font:APPFONT13 placeholder:@"输入克重" textColor:UIColorFromRGB(BlackColorValue) placeholderColor:nil delegate:self];
    _weightMinTxt.textAlignment = NSTextAlignmentRight;
    [_sideView addSubview:_weightMinTxt];
    
    _weightMaxTxt= [BaseViewFactory textFieldWithFrame:CGRectMake(508, 124, 62, 44) font:APPFONT13 placeholder:@"输入克重" textColor:UIColorFromRGB(BlackColorValue) placeholderColor:nil delegate:self];
    _weightMaxTxt.textAlignment = NSTextAlignmentRight;
    [_sideView addSubview:_weightMaxTxt];
    
    _haveImaBtn = [BaseViewFactory ylButtonWithFrame:CGRectMake(116, 164, 51, 40) font:APPFONT13 title:@"有图" titleColor:UIColorFromRGB(0xbdbdbd) backColor:UIColorFromRGB(WhiteColorValue)];
    [_haveImaBtn setImageRect:CGRectMake(8, 14, 12, 12)];
    [_haveImaBtn setTitleRect:CGRectMake(23, 0, 28, 40)];
    [_haveImaBtn setImage:[UIImage imageNamed:@"image_unselect"] forState:UIControlStateNormal];
    [_sideView addSubview:_haveImaBtn];
    [_haveImaBtn addTarget:self action:@selector(haveImaBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    _noImaBtn = [BaseViewFactory ylButtonWithFrame:CGRectMake(211, 164, 51, 40) font:APPFONT13 title:@"无图" titleColor:UIColorFromRGB(0xbdbdbd) backColor:UIColorFromRGB(WhiteColorValue)];
    [_noImaBtn setImageRect:CGRectMake(8, 14, 12, 12)];
    [_noImaBtn setTitleRect:CGRectMake(23, 0, 28, 40)];
    [_noImaBtn setImage:[UIImage imageNamed:@"image_unselect"] forState:UIControlStateNormal];
    [_sideView addSubview:_noImaBtn];
    [_noImaBtn addTarget:self action:@selector(noImaBtnClick) forControlEvents:UIControlEventTouchUpInside];

    UIView *line1 = [BaseViewFactory viewWithFrame:CGRectMake(190, 143.5, 8, 1) color:UIColorFromRGB(BlackColorValue)];
    [_sideView addSubview:line1];

    UIView *line2 = [BaseViewFactory viewWithFrame:CGRectMake(490, 143.5, 8, 1) color:UIColorFromRGB(BlackColorValue)];
    [_sideView addSubview:line2];
    
    NSArray *nameArr = @[@"货号：",@"品名：",@"成分：",@"规格：",@"门幅：",@"克重：",@"图片："];
    for (int i = 0; i<nameArr.count; i++) {
        int a = i/2;
        int b = i%2;
        UILabel *lab = [BaseViewFactory labelWithFrame:CGRectMake(30+300*b, 44+40*a, 42, 40) textColor:UIColorFromRGB(BlackColorValue) font:APPFONT13 textAligment:NSTextAlignmentLeft andtext:nameArr[i]];
        [_sideView addSubview:lab];
        UIView *line = [BaseViewFactory viewWithFrame:CGRectMake(30+300*b, 84+40*a, 240, 1) color:UIColorFromRGB(LineColorValue)];
        [_sideView addSubview:line];

    }
    
    UIButton *searchBtn = [BaseViewFactory buttonWithFrame:CGRectMake(150, 228, 300, 40) font:APPFONT14 title:@"查询" titleColor:UIColorFromRGB(WhiteColorValue) backColor:UIColorFromRGB(BlueColorValue)];
    searchBtn.layer.cornerRadius = 2;
    [searchBtn addTarget:self action:@selector(searchBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [_sideView addSubview:searchBtn];

    
    UIButton *resetBtn = [BaseViewFactory buttonWithFrame:CGRectMake(480, 228, 30, 40) font:APPFONT14 title:@"重置" titleColor:UIColorFromRGB(BlueColorValue) backColor:UIColorFromRGB(WhiteColorValue)];
    [_sideView addSubview:resetBtn];
    [resetBtn addTarget:self action:@selector(resetBtnClick) forControlEvents:UIControlEventTouchUpInside];

    
}

#pragma - m按钮点击

- (void)haveImaBtnClick{
    if (_isHaveIma == 0||_isHaveIma == 2) {
        //有图
        _isHaveIma = 1;
        [_haveImaBtn setImage:[UIImage imageNamed:@"image_select"] forState:UIControlStateNormal];
        [_noImaBtn setImage:[UIImage imageNamed:@"image_unselect"] forState:UIControlStateNormal];
    }else{
        //无要求
        _isHaveIma = 0;
        [_haveImaBtn setImage:[UIImage imageNamed:@"image_unselect"] forState:UIControlStateNormal];
        [_noImaBtn setImage:[UIImage imageNamed:@"image_unselect"] forState:UIControlStateNormal];
    }
    
   

    
}

- (void)noImaBtnClick{
    if (_isHaveIma == 0||_isHaveIma == 1) {
        //有图
        _isHaveIma = 2;
        [_haveImaBtn setImage:[UIImage imageNamed:@"image_unselect"] forState:UIControlStateNormal];
        [_noImaBtn setImage:[UIImage imageNamed:@"image_select"] forState:UIControlStateNormal];
    }else{
        //无要求
        _isHaveIma = 0;
        [_haveImaBtn setImage:[UIImage imageNamed:@"image_unselect"] forState:UIControlStateNormal];
        [_noImaBtn setImage:[UIImage imageNamed:@"image_unselect"] forState:UIControlStateNormal];
    }
}

- (void)searchBtnClick{
    NSMutableDictionary *setDic = [[NSMutableDictionary alloc]init];
    if (_numberTxt.text.length>0) {
        [setDic setValue:_numberTxt.text forKey:@"1"];
    }
    if (_nameTxt.text.length>0) {
        [setDic setValue:_numberTxt.text forKey:@"2"];
    }
    if (_copTxt.text.length>0) {
        [setDic setValue:_copTxt.text forKey:@"3"];
    }
    if (_widthMinTxt.text.length>0) {
        [setDic setValue:_widthMinTxt.text forKey:@"widthMin"];
    }
    if (_widthMaxTxt.text.length>0) {
        [setDic setValue:_widthMaxTxt.text forKey:@"widthMax"];
    }
    if (_weightMinTxt.text.length>0) {
        [setDic setValue:_weightMinTxt.text forKey:@"weightMin"];
    }
    if (_weightMaxTxt.text.length>0) {
        [setDic setValue:_weightMaxTxt.text forKey:@"weightMax"];
    }
    if (_isHaveIma==1) {
        [setDic setValue:@"1" forKey:@"havePics"];
    }else if (_isHaveIma==2){
        [setDic setValue:@"0" forKey:@"havePics"];
    }
    WeakSelf(self);
    if (weakself.returnBlock) {
        weakself.returnBlock(setDic);
    }
    [self dismiss];

}



- (void)resetBtnClick{
    _nameTxt.text = @"";
    _numberTxt.text = @"";
    _copTxt.text = @"";
    _specTxt.text = @"";
    _widthMinTxt.text = @"";
    _widthMaxTxt.text = @"";
    _weightMinTxt.text = @"";
    _weightMaxTxt.text = @"";
    _isHaveIma = 0;
    [_haveImaBtn setImage:[UIImage imageNamed:@"image_unselect"] forState:UIControlStateNormal];
    [_noImaBtn setImage:[UIImage imageNamed:@"image_unselect"] forState:UIControlStateNormal];
}


#pragma - mark public method
- (void)showView
{
    AppDelegate *app = (AppDelegate *)[[UIApplication  sharedApplication] delegate];
    [app.splitViewController.view addSubview:self];
    _isShow = YES;
    [UIView animateWithDuration:0.2 animations:^{
        
    }];
}

- (void)dismiss
{
    if (!_isShow) return;
    _isShow = NO;
    [UIView animateWithDuration:0.2 animations:^{
        
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        _backButton.alpha = 0.3;
    }];
}

#pragma mark ========= get

- (UIButton *)backButton
{
    if (!_backButton) {
        _backButton = [[UIButton alloc] initWithFrame:self.bounds];
        _backButton.backgroundColor = [UIColor blackColor];
        _backButton.alpha = 0.3;
    }
    return _backButton;
}


@end
