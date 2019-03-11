//
//  DatePickerView.m
//  BuLaoBan
//
//  Created by souxiuyun on 2019/3/11.
//  Copyright © 2019 XX. All rights reserved.
//

#import "DatePickerView.h"
#import "PGDatePickManager.h"

@interface DatePickerView ()

@property (nonatomic, strong) UIButton *backButton;
@property (nonatomic, strong) UIView      *sideView;

@end

@implementation DatePickerView{
     BOOL        _isShow;
}
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
    [self addSubview:self.backButton];
    _sideView = [BaseViewFactory viewWithFrame:CGRectMake(ScreenWidth, 0, 300, 320) color:UIColorFromRGB(WhiteColorValue)];
    [self addSubview:_sideView];
    _datePicker = [[PGDatePicker alloc]init];
    _datePicker.frame = CGRectMake(0, 60, 300, 200);
    _datePicker.datePickerMode = PGDatePickerModeDate;
    _datePicker.rowHeight = 40;
    _datePicker.autoSelected = YES;
    _datePicker.language = @"zh-Hans";
    [_sideView addSubview:_datePicker];
    
}


#pragma - mark public method
- (void)showView
{
    
    _sideView.frame =CGRectMake(ScreenWidth, 0, 300, 320);
    
    AppDelegate *app = (AppDelegate *)[[UIApplication  sharedApplication] delegate];
    [app.splitViewController.view addSubview:self];
    _isShow = YES;
    [UIView animateWithDuration:0.2 animations:^{
        _sideView.frame =CGRectMake(ScreenWidth-300, 0, 300, 320);
    }];
    
    
}

- (void)dismiss
{
    if (!_isShow) return;
    _isShow = NO;
    [UIView animateWithDuration:0.2 animations:^{
        _sideView.frame =CGRectMake(ScreenWidth, 0, 300, 320);
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
        [_backButton addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    }
    return _backButton;
}

@end
