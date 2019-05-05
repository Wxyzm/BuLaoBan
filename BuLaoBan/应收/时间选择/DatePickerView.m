//
//  DatePickerView.m
//  BuLaoBan
//
//  Created by souxiuyun on 2019/3/11.
//  Copyright © 2019 XX. All rights reserved.
//

#import "DatePickerView.h"
#import "PGDatePickManager.h"

@interface DatePickerView ()<PGDatePickerDelegate>

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
    _datePicker.delegate = self;
    _datePicker.autoSelected = YES;
    _datePicker.language = @"zh-Hans";
    [_sideView addSubview:_datePicker];
    
    _titleLab = [BaseViewFactory labelWithFrame:CGRectMake(16, 14, 80, 22)  textColor:UIColorFromRGB(BlackColorValue) font:APPFONT16 textAligment:NSTextAlignmentLeft andtext:@""];
    [_sideView addSubview:_titleLab];
    _dateLab = [BaseViewFactory labelWithFrame:CGRectMake(120, 14, 146, 22)  textColor:UIColorFromRGB(BlueColorValue) font:APPFONT16 textAligment:NSTextAlignmentRight andtext:@""];
    [_sideView addSubview:_dateLab];
    
    UIImageView* rightIma = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"right"]];
    [_sideView addSubview:rightIma];
    rightIma.frame = CGRectMake(276, 19, 8, 13);
    
    _downBtn = [BaseViewFactory buttonWithFrame:CGRectMake(0, 270, 300, 50) font:APPFONT15 title:@"清空筛选条件" titleColor:UIColorFromRGB(BlueColorValue) backColor:UIColorFromRGB(BackColorValue)];
    [_sideView addSubview:_downBtn];
    [_downBtn addTarget:self  action:@selector(downBtnClick) forControlEvents:UIControlEventTouchUpInside];
}


#pragma mark ========= 清空选项

- (void)downBtnClick{
    WeakSelf(self);
    if (weakself.returnBlock) {
        weakself.returnBlock(_dateType, @"");
    }
    [self dismiss];
}


#pragma mark ====== 时间选择
-(void)datePicker:(PGDatePicker *)datePicker didSelectDate:(NSDateComponents *)dateComponents{
    NSLog(@"%@",dateComponents);
    NSDate *date = [NSDate dateFromComponents:dateComponents];
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc]init];//创建一个日期格式化器
    dateFormatter.dateFormat=@"yyyy-MM-dd";//指定转date得日期格式化形式
    if (_dateType == 3) {
        dateFormatter.dateFormat=@"yyyy-MM";//指定转date得日期格式化形式
    }
    NSString *dateStr= [dateFormatter stringFromDate:date];
    _dateLab.text = dateStr;
    WeakSelf(self);
    if (weakself.returnBlock) {
        weakself.returnBlock(_dateType, dateStr);
    }
}




#pragma - mark public method
- (void)showViewWithFrame:(CGRect)frame
{
    
    if (_dateType ==1) {
        _titleLab.text = @"开始日期";
    }else{
        _titleLab.text = @"结束日期";
    }
    frame.size.width =300;
    frame.size.height =320;

    _sideView.frame =frame;
    
    AppDelegate *app = (AppDelegate *)[[UIApplication  sharedApplication] delegate];
    [app.splitViewController.view addSubview:self];
    _isShow = YES;
    [UIView animateWithDuration:0.2 animations:^{
        _sideView.frame =frame;
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


-(void)setDateType:(NSInteger)dateType{
    _dateType = dateType;
    if (dateType == 3) {
        _datePicker.datePickerMode =  PGDatePickerModeYearAndMonth;
    }
    
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
