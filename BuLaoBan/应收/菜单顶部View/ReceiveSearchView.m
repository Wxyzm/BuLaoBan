//
//  ReceiveSearchView.m
//  BuLaoBan
//
//  Created by apple on 2019/2/27.
//  Copyright © 2019年 XX. All rights reserved.
//

#import "ReceiveSearchView.h"
@interface ReceiveSearchView()

/**
 开始时间
 */
@property (nonatomic, strong) YLButton    *startTimeBtn;

/**
 结束时间
 */
@property (nonatomic, strong) YLButton    *endTimeBtn;

/**
 选择客户
 */
@property (nonatomic, strong) YLButton    *customerBtn;

/**
 业务员
 */
@property (nonatomic, strong) YLButton    *salesmanBtn;

@end

@implementation ReceiveSearchView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = UIColorFromRGB(BackColorValue);
        [self setUp];
    }
    return self;
}

- (void)setUp{
    UILabel *timeLab = [BaseViewFactory labelWithFrame:CGRectMake(20, 0, 28, 50) textColor:UIColorFromRGB(BlackColorValue) font:APPFONT13 textAligment:NSTextAlignmentLeft andtext:@"日期"];
    [self addSubview:timeLab];
    
    _startTimeBtn = [YLButton buttonWithbackgroundColor:UIColorFromRGB(WhiteColorValue) titlecolor:UIColorFromRGB(0x858585) cornerRadius:2 andtarget:self action:@selector(topBtnClick:) titleFont:APPFONT13 title:@"开始日期"];
    _startTimeBtn.layer.borderWidth = 1;
    _startTimeBtn.layer.borderColor = UIColorFromRGB(LineColorValue).CGColor;
    _startTimeBtn.titleLabel.textAlignment = NSTextAlignmentLeft;
    _startTimeBtn.titleRect = CGRectMake(10, 0, 84, 30);
    _startTimeBtn.frame = CGRectMake(56, 10, 130, 30);
    _startTimeBtn.tag = 1000;
    [self addSubview:_startTimeBtn];

    _endTimeBtn = [YLButton buttonWithbackgroundColor:UIColorFromRGB(WhiteColorValue) titlecolor:UIColorFromRGB(0x858585) cornerRadius:2 andtarget:self action:@selector(topBtnClick:) titleFont:APPFONT13 title:@"结束日期"];
    _endTimeBtn.layer.borderWidth = 1;
    _endTimeBtn.layer.borderColor = UIColorFromRGB(LineColorValue).CGColor;
    _endTimeBtn.titleLabel.textAlignment = NSTextAlignmentLeft;
    _endTimeBtn.titleRect = CGRectMake(10, 0, 84, 30);
    _endTimeBtn.frame = CGRectMake(192, 10, 130, 30);
    _endTimeBtn.tag = 1001;
    [self addSubview:_endTimeBtn];
    
    UILabel *customerLab = [BaseViewFactory labelWithFrame:CGRectMake(338, 0, 28, 50) textColor:UIColorFromRGB(BlackColorValue) font:APPFONT13 textAligment:NSTextAlignmentLeft andtext:@"客户"];
    [self addSubview:customerLab];
    
    _customerBtn  = [YLButton buttonWithbackgroundColor:UIColorFromRGB(WhiteColorValue) titlecolor:UIColorFromRGB(0x858585) cornerRadius:2 andtarget:self action:@selector(topBtnClick:) titleFont:APPFONT13 title:@"选择客户"];
    _customerBtn.layer.borderWidth = 1;
    _customerBtn.layer.borderColor = UIColorFromRGB(LineColorValue).CGColor;
    _customerBtn.titleLabel.textAlignment = NSTextAlignmentLeft;
    _customerBtn.titleRect = CGRectMake(10, 0, 110, 30);
    _customerBtn.frame = CGRectMake(375, 10, 130, 30);
    _customerBtn.tag = 1002;
    [self addSubview:_customerBtn];
    
    UILabel *salesmanLab = [BaseViewFactory labelWithFrame:CGRectMake(541, 0, 41, 50) textColor:UIColorFromRGB(BlackColorValue) font:APPFONT13 textAligment:NSTextAlignmentLeft andtext:@"业务员"];
    [self addSubview:salesmanLab];
    
    _salesmanBtn  = [YLButton buttonWithbackgroundColor:UIColorFromRGB(WhiteColorValue) titlecolor:UIColorFromRGB(0x858585) cornerRadius:2 andtarget:self action:@selector(topBtnClick:) titleFont:APPFONT13 title:@"对应业务员"];
    _salesmanBtn.layer.borderWidth = 1;
    _salesmanBtn.layer.borderColor = UIColorFromRGB(LineColorValue).CGColor;
    _salesmanBtn.titleLabel.textAlignment = NSTextAlignmentLeft;
    _salesmanBtn.titleRect = CGRectMake(10, 0, 100, 30);
    _salesmanBtn.frame = CGRectMake(591, 10, 120, 30);
    _salesmanBtn.tag = 1003;
    [self addSubview:_salesmanBtn];
    
    YLButton *searchBtn = [YLButton buttonWithbackgroundColor:UIColorFromRGB(BlueColorValue) titlecolor:UIColorFromRGB(WhiteColorValue) cornerRadius:2 andtarget:self action:@selector(topBtnClick:) titleFont:APPFONT13 title:@"查询"];
    searchBtn.tag = 1004;
    searchBtn.frame = CGRectMake(727, 10, 60, 30);
    [self addSubview:searchBtn];
    
    YLButton *resetBtn = [YLButton buttonWithbackgroundColor:UIColorFromRGB(BackColorValue) titlecolor:UIColorFromRGB(BlueColorValue) cornerRadius:2 andtarget:self action:@selector(topBtnClick:) titleFont:APPFONT13 title:@"重置"];
    resetBtn.tag = 1005;
    resetBtn.frame = CGRectMake(803, 10, 46, 30);
    [self addSubview:resetBtn];

    
}


- (void)topBtnClick:(YLButton *)btn{
    UIWindow * window=[[[UIApplication sharedApplication] delegate] window];
    CGRect rect=[btn convertRect:btn.bounds toView:window];
    rect.origin.y +=btn.height+18;
    WeakSelf(self);
    if (weakself.returnBlock) {
        weakself.returnBlock(btn.tag-1000,rect);
    }
    if (btn.tag - 1000 ==5) {
        //重置
        [self allReload];
    }
    
}

#pragma mark === public method

/**
 设置按钮标题
 
 @param tag 0:开始日期 1:结束日期 2:客户 3：业务员
 */
- (void)setTitle:(NSString *)title withTag:(NSInteger)tag{
    switch (tag) {
        case 0:{
            [_startTimeBtn setTitle:title forState:UIControlStateNormal];
            [_startTimeBtn setTitleColor:UIColorFromRGB(BlueColorValue) forState:UIControlStateNormal];
            break;
        }
        case 1:{
            [_endTimeBtn setTitle:title forState:UIControlStateNormal];
            [_endTimeBtn setTitleColor:UIColorFromRGB(BlueColorValue) forState:UIControlStateNormal];
            break;
        }
        case 2:{
            [_customerBtn setTitle:title forState:UIControlStateNormal];
            [_customerBtn setTitleColor:UIColorFromRGB(BlueColorValue) forState:UIControlStateNormal];
            break;
        }
        case 3:{
            [_salesmanBtn setTitle:title forState:UIControlStateNormal];
            [_salesmanBtn setTitleColor:UIColorFromRGB(BlueColorValue) forState:UIControlStateNormal];
            break;
        }
        default:
            break;
    }
    
    
}
/**
 重置标题
 
 @param tag 0:开始日期 1:结束日期 2:客户 3：业务员
 */
- (void)clearBtnTitleWithTag:(NSInteger)tag{
    
    switch (tag) {
        case 0:{
            [_startTimeBtn setTitle:@"开始日期" forState:UIControlStateNormal];
            [_startTimeBtn setTitleColor:UIColorFromRGB(0x858585) forState:UIControlStateNormal];
            break;
        }
        case 1:{
            [_endTimeBtn setTitle:@"结束日期" forState:UIControlStateNormal];
            [_endTimeBtn setTitleColor:UIColorFromRGB(0x858585) forState:UIControlStateNormal];
            break;
        }
        case 2:{
            [_customerBtn setTitle:@"选择客户" forState:UIControlStateNormal];
            [_customerBtn setTitleColor:UIColorFromRGB(0x858585) forState:UIControlStateNormal];
            break;
        }
        case 3:{
            [_salesmanBtn setTitle:@"对应业务员" forState:UIControlStateNormal];
            [_salesmanBtn setTitleColor:UIColorFromRGB(0x858585) forState:UIControlStateNormal];
            break;
        }
        default:
            break;
    }
}

/**
 全部重置
 */
- (void)allReload{
    [_startTimeBtn setTitle:@"开始日期" forState:UIControlStateNormal];
    [_startTimeBtn setTitleColor:UIColorFromRGB(0x858585) forState:UIControlStateNormal];
    [_endTimeBtn setTitle:@"结束日期" forState:UIControlStateNormal];
    [_endTimeBtn setTitleColor:UIColorFromRGB(0x858585) forState:UIControlStateNormal];
    [_customerBtn setTitle:@"选择客户" forState:UIControlStateNormal];
    [_customerBtn setTitleColor:UIColorFromRGB(0x858585) forState:UIControlStateNormal];
    [_salesmanBtn setTitle:@"对应业务员" forState:UIControlStateNormal];
    [_salesmanBtn setTitleColor:UIColorFromRGB(0x858585) forState:UIControlStateNormal];
}
/**
 全部重置
 */
- (void)ReloadWithoutCustomer{
    [_startTimeBtn setTitle:@"开始日期" forState:UIControlStateNormal];
    [_startTimeBtn setTitleColor:UIColorFromRGB(0x858585) forState:UIControlStateNormal];
    [_endTimeBtn setTitle:@"结束日期" forState:UIControlStateNormal];
    [_endTimeBtn setTitleColor:UIColorFromRGB(0x858585) forState:UIControlStateNormal];
    //    [_customerBtn setTitle:@"选择客户" forState:UIControlStateNormal];
    //    [_customerBtn setTitleColor:UIColorFromRGB(0x858585) forState:UIControlStateNormal];
    //    [_salesmanBtn setTitle:@"对应业务员" forState:UIControlStateNormal];
    //    [_salesmanBtn setTitleColor:UIColorFromRGB(0x858585) forState:UIControlStateNormal];
}

@end
