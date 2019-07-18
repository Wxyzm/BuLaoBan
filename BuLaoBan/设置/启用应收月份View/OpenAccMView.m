//
//  OpenAccMView.m
//  BuLaoBan
//
//  Created by souxiuyun on 2019/5/4.
//  Copyright © 2019 XX. All rights reserved.
//

#import "OpenAccMView.h"
#import "DatePickerView.h"
@interface OpenAccMView ()
@property (nonatomic, strong) DatePickerView *datepicker;
@property (nonatomic, strong) YLButton*dateBtn;
@property (nonatomic, strong) UISwitch *openSwitch;

@end


@implementation OpenAccMView{
    
    NSString *_dataStr;
}

-(instancetype)init{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(300, 64, ScreenWidth-300, 500);
        self.backgroundColor = UIColorFromRGB(BackColorValue);
        _dataStr = @"";
        [self setup];
    }
    return self;
}

- (void)setup{
    
    UIView *topView = [BaseViewFactory viewWithFrame:CGRectMake(0, 0, ScreenWidth-300, 50) color:UIColorFromRGB(WhiteColorValue)];
    [self addSubview:topView];
    
    UILabel *dateLab = [BaseViewFactory labelWithFrame:CGRectMake(20, 0, 56, 50) textColor:UIColorFromRGB(BlackColorValue) font:APPFONT13 textAligment:NSTextAlignmentLeft andtext:@"选择年月"];
    [topView addSubview:dateLab];

    _dateBtn = [BaseViewFactory ylButtonWithFrame:CGRectMake(82, 10, 130, 30) font:APPFONT13 title:@"选择年月" titleColor:UIColorFromRGB(0x858585) backColor:UIColorFromRGB(WhiteColorValue)];
    [_dateBtn setTitleRect:CGRectMake(10, 0, 90, 30)];
    [_dateBtn setImageRect:CGRectMake(104, 6, 16, 18)];
    [_dateBtn setImage:[UIImage imageNamed:@"date"] forState:UIControlStateNormal];
    _dateBtn.layer.cornerRadius = 2;
    _dateBtn.layer.borderColor = UIColorFromRGB(LineColorValue).CGColor;
    _dateBtn.layer.borderWidth = 1;
    _dateBtn.titleLabel.textAlignment = NSTextAlignmentLeft;
    [_dateBtn addTarget:self action:@selector(dateBtnCLick) forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:_dateBtn];

    _openSwitch = [[UISwitch alloc] initWithFrame:CGRectMake(ScreenWidth-400-72, 10, 52, 31)];
    [topView addSubview:_openSwitch];
    [_openSwitch addTarget:self action:@selector(valueChanged:) forControlEvents:(UIControlEventValueChanged)];

    UIView *lineView = [BaseViewFactory viewWithFrame:CGRectMake(0, 49, ScreenWidth-400, 1) color:UIColorFromRGB(LineColorValue)];
    [topView addSubview:lineView];
    
    UILabel * nameLab = [BaseViewFactory labelWithFrame:CGRectMake(20, 50, 400, 50) textColor:UIColorFromRGB(0x9B9B9B) font:APPFONT12 textAligment:NSTextAlignmentLeft andtext:@"应收管理初始化数据录入前，收款单无法录入。"];
    [self addSubview:nameLab];
    
}



- (void)dateBtnCLick{
    if (!_datepicker) {
        _datepicker = [[DatePickerView alloc]init];
        _datepicker.dateType =3;
    }
    [_datepicker showViewWithFrame:CGRectMake(482, 132, 300, 320)];
    //日期选择
    WeakSelf(self)
    _datepicker.returnBlock = ^(NSInteger dateType, NSString *dateStr) {
        _dataStr = dateStr;
        [weakself.dateBtn setTitleColor:UIColorFromRGB(BlueColorValue) forState:UIControlStateNormal];
        [weakself.dateBtn setTitle:dateStr forState:UIControlStateNormal];
        if (dateStr.length<=0) {
            [weakself.dateBtn setTitleColor:UIColorFromRGB(0x858585) forState:UIControlStateNormal];
            [weakself.dateBtn setTitle:@"选择年月" forState:UIControlStateNormal];
        }else{
            if (_openSwitch.isOn) {
                [weakself upDatas];
            }
        }
    };

}

- (void)valueChanged:(UISwitch *)swi{
    if(swi.isOn){
        //打开
        if ([self.dateBtn.titleLabel.text isEqualToString:@"选择年月"]) {
            [HUD show:@"请选择年月"];
            [_openSwitch setOn:NO];
            return;
        }
    }else{
        if (!swi.isOn) {
            [HUD show:@"应收打开后无法关闭"];
            [_openSwitch setOn:YES];
            return;
        }
        //关闭
//        _dataStr = @"1980-01";
//        [self.dateBtn setTitle:@"选择年月" forState:UIControlStateNormal];
//        [self.dateBtn setTitleColor:UIColorFromRGB(0x858585) forState:UIControlStateNormal];
    }
    [self upDatas];
    
}

#pragma mark ==== set

-(void)setInfoDic:(NSDictionary *)infoDic{
    _infoDic = infoDic;
   
    NSString * receivableStartDate = @"";
    receivableStartDate = [infoDic objectForKey:@"receivableStartDate"]?[infoDic objectForKey:@"receivableStartDate"]:@"";
    _dataStr = receivableStartDate;
    if (receivableStartDate.length<=0) {
        [_openSwitch setOn:NO];

    }else{
        [self.dateBtn setTitle:receivableStartDate forState:UIControlStateNormal];
        [self.dateBtn setTitleColor:UIColorFromRGB(BlueColorValue) forState:UIControlStateNormal];
        [_openSwitch setOn:YES];
    }
}

- (void)upDatas{
    if (!_infoDic) {
        return;
    }
    NSMutableDictionary *upDic = [[NSMutableDictionary alloc]init];
    [upDic setObject:_dataStr forKey:@"receivableStartDate"];
    [upDic setObject:_infoDic[@"foreignCurrency"] forKey:@"foreignCurrency"];
    [upDic setObject:_infoDic[@"greyFabricColorMark"] forKey:@"greyFabricColorMark"];
    [upDic setObject:_infoDic[@"greyFabricColorName"] forKey:@"greyFabricColorName"];
    [upDic setObject:_infoDic[@"payableStartDate"] forKey:@"payableStartDate"];
    [upDic setObject:_infoDic[@"sellInventoryReduce"] forKey:@"sellInventoryReduce"];
    [upDic setObject:_infoDic[@"storeStartDate"] forKey:@"storeStartDate"];
    [upDic setObject:_infoDic[@"taxRate"] forKey:@"taxRate"];
    [upDic setObject:_infoDic[@"distributionProcess"] forKey:@"distributionProcess"];
    User *user = [[UserPL shareManager] getLoginUser];
    
    [[HttpClient sharedHttpClient] requestPUTWithURLStr:[NSString stringWithFormat:@"/companys/%@/settings",user.defutecompanyId] paramDic:upDic WithReturnBlock:^(id returnValue) {
     //   [_openSwitch setOn:YES];

    } andErrorBlock:^(NSString *msg) {
        
    }];
    
}



@end
