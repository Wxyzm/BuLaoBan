//
//  SaleSTopView.m
//  BuLaoBan
//
//  Created by souxiuyun on 2019/4/2.
//  Copyright © 2019 XX. All rights reserved.
//

#import "SaleSTopView.h"

@interface SaleSTopView()<UITextFieldDelegate>
/**
 开始时间
 */
@property (nonatomic, strong) YLButton    *startTimeBtn;

/**
 结束时间
 */
@property (nonatomic, strong) YLButton    *endTimeBtn;

/**
 货号
 */
@property (nonatomic, strong) UIView    *numberView;
@property (nonatomic, strong) UITextField  *numberTxt;


/**
 客户
 */
@property (nonatomic, strong) UIView    *customerView;
@property (nonatomic, strong) YLButton  *customerBtn;

/**
 业务员
 */
@property (nonatomic, strong) UIView    *saleManView;
@property (nonatomic, strong) YLButton  *saleManBtn;

@property (nonatomic, strong) UIButton  *searchBtn;
@property (nonatomic, strong) UIButton  *resetBtn;

@property (nonatomic, strong) UILabel  *moneyLab;      //销货金额
@property (nonatomic, strong) UILabel  *numberLab;     //销货次数
@property (nonatomic, strong) UILabel  *cusNumberLab;  //客户数量
@property (nonatomic, strong) UILabel  *unitNumberLab; //销货单品数


@end

@implementation SaleSTopView{
    NSMutableArray *_topBtnArr;
    NSInteger _selectedIndex;
    
}

-(instancetype)init{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, 0, ScreenWidth-100, 160);
        self.backgroundColor = UIColorFromRGB(WhiteColorValue);
        _topBtnArr = [NSMutableArray arrayWithCapacity:0];
        _selectedIndex = 0;
        [self setUP];
    }
    
    return self;
}

- (void)setUP{
    
    UIView *btnView = [BaseViewFactory viewWithFrame:CGRectMake((ScreenWidth-100)/2-134, 10, 272, 30) color:UIColorFromRGB(WhiteColorValue)];
    btnView.layer.borderColor = UIColorFromRGB(LineColorValue).CGColor;
    btnView.layer.borderWidth = 1;
    [self addSubview:btnView];
    
    UIView *backView = [BaseViewFactory viewWithFrame:CGRectMake(0, 50, ScreenWidth-100, 50) color:UIColorFromRGB(0xf5f5f5)];
    [self addSubview:backView];
    
    
    NSArray *titleArr = @[@"按货品",@"按客户",@"按业务员"];
    NSArray *dateArr = @[@"今天",@"昨天",@"本月"];

    for (int i= 0; i<3; i++) {
        UIButton *btn = [BaseViewFactory buttonWithFrame:CGRectMake(1+90*i, 0, 90, 30) font:APPFONT13 title:titleArr[i] titleColor:UIColorFromRGB(BlackColorValue) backColor:UIColorFromRGB(WhiteColorValue)];
        btn.tag = 1000 +i;
        [btn addTarget:self action:@selector(topBtnCLick:) forControlEvents:UIControlEventTouchUpInside];
        [btnView addSubview:btn];
        [_topBtnArr addObject:btn];
        if (i == _selectedIndex) {
            btn.backgroundColor = UIColorFromRGB(BlueColorValue);
            [btn setTitleColor:UIColorFromRGB(WhiteColorValue) forState:UIControlStateNormal];
        }
        
        UIButton *datebtn = [BaseViewFactory buttonWithFrame:CGRectMake(20+46*i, 0, 30, 50) font:APPFONT13 title:dateArr[i] titleColor:UIColorFromRGB(BlackColorValue) backColor:UIColorFromRGB(0xf5f5f5)];
        datebtn.tag = 2000 +i;
        [datebtn addTarget:self action:@selector(dateBtnCLick:) forControlEvents:UIControlEventTouchUpInside];
        [backView addSubview:datebtn];
    }
    for (int i= 0; i<2; i++) {
        UIView *line = [BaseViewFactory viewWithFrame:CGRectMake(90+90*i, 0, 1, 30) color:UIColorFromRGB(LineColorValue)];
        [btnView addSubview:line];
    }
    
    _startTimeBtn = [YLButton buttonWithbackgroundColor:UIColorFromRGB(WhiteColorValue) titlecolor:UIColorFromRGB(0x858585) cornerRadius:2 andtarget:self action:@selector(startTimeBtnClick) titleFont:APPFONT13 title:@"开始日期"];
    [_startTimeBtn setImage:[UIImage imageNamed:@"date"] forState:UIControlStateNormal];
    _startTimeBtn.layer.borderWidth = 1;
    _startTimeBtn.layer.borderColor = UIColorFromRGB(LineColorValue).CGColor;
    _startTimeBtn.titleLabel.textAlignment = NSTextAlignmentLeft;
    _startTimeBtn.titleRect = CGRectMake(10, 0, 84, 30);
    _startTimeBtn.frame = CGRectMake(158, 10, 130, 30);
    _startTimeBtn.imageRect = CGRectMake(104, 6, 16, 18);
    [backView addSubview:_startTimeBtn];
    
    _endTimeBtn = [YLButton buttonWithbackgroundColor:UIColorFromRGB(WhiteColorValue) titlecolor:UIColorFromRGB(0x858585) cornerRadius:2 andtarget:self action:@selector(endTimeBtnClick) titleFont:APPFONT13 title:@"结束日期"];
    _endTimeBtn.layer.borderWidth = 1;
    _endTimeBtn.layer.borderColor = UIColorFromRGB(LineColorValue).CGColor;
    _endTimeBtn.titleLabel.textAlignment = NSTextAlignmentLeft;
    _endTimeBtn.titleRect = CGRectMake(10, 0, 84, 30);
    _endTimeBtn.frame = CGRectMake(294, 10, 130, 30);
    _endTimeBtn.imageRect = CGRectMake(104, 6, 16, 18);
    [_endTimeBtn setImage:[UIImage imageNamed:@"date"] forState:UIControlStateNormal];
    [backView addSubview:_endTimeBtn];
    
    [backView addSubview:self.numberView];
    [backView addSubview:self.customerView];
    [backView addSubview:self.saleManView];
    
    _searchBtn = [BaseViewFactory buttonWithFrame:CGRectZero font:APPFONT13 title:@"查询" titleColor:UIColorFromRGB(WhiteColorValue) backColor:UIColorFromRGB(BlueColorValue)];
    _searchBtn.layer.cornerRadius = 2;
    [backView addSubview:_searchBtn];

    _resetBtn= [BaseViewFactory buttonWithFrame:CGRectZero font:APPFONT13 title:@"重置" titleColor:UIColorFromRGB(BlueColorValue) backColor:UIColorFromRGB(0xf5f5f5)];
    _resetBtn.layer.cornerRadius = 2;
    [backView addSubview:_resetBtn];
    //设置头部显示标签
    [self showSelectedView];
    //金额等统计
    
    _moneyLab = [BaseViewFactory labelWithFrame:CGRectMake(0, 129, 200, 18) textColor:UIColorFromRGB(RedColorValue) font:APPFONT16 textAligment:NSTextAlignmentCenter andtext:@"￥0.00"];
    [self addSubview:_moneyLab];
    
    _numberLab = [BaseViewFactory labelWithFrame:CGRectMake(200, 129, 200, 18) textColor:UIColorFromRGB(RedColorValue) font:APPFONT16 textAligment:NSTextAlignmentCenter andtext:@"0"];
    [self addSubview:_numberLab];
    
    _cusNumberLab = [BaseViewFactory labelWithFrame:CGRectMake(400, 129, 200, 18) textColor:UIColorFromRGB(RedColorValue) font:APPFONT16 textAligment:NSTextAlignmentCenter andtext:@"0"];
    [self addSubview:_cusNumberLab];
    
    _unitNumberLab = [BaseViewFactory labelWithFrame:CGRectMake(600, 129, 200, 18) textColor:UIColorFromRGB(RedColorValue) font:APPFONT16 textAligment:NSTextAlignmentCenter andtext:@"0"];
    [self addSubview:_unitNumberLab];
    
    NSArray *monArr = @[@"销货金额",@"销货次数",@"客户数量",@"销货单品数"];
    for (int i= 0; i<4; i++) {
        UILabel *nameLab = [BaseViewFactory labelWithFrame:CGRectMake(200*i, 109, 200, 15) textColor:UIColorFromRGB(BlackColorValue) font:APPFONT12 textAligment:NSTextAlignmentCenter andtext:monArr[i]];
        [self addSubview:nameLab];
        UIView *line = [BaseViewFactory viewWithFrame:CGRectMake(200*i+199.5, 115, 1, 30) color:UIColorFromRGB(LineColorValue)];
        [self addSubview:line];
    }
   
    
}



#pragma mark ====== 按钮点击

- (void)topBtnCLick:(UIButton *)btn{
    _selectedIndex = btn.tag - 1000;
    for (UIButton *theBtn in _topBtnArr) {
        theBtn.backgroundColor = UIColorFromRGB(WhiteColorValue);
        [theBtn setTitleColor:UIColorFromRGB(BlackColorValue) forState:UIControlStateNormal];
    }
    btn.backgroundColor = UIColorFromRGB(BlueColorValue);
    [btn setTitleColor:UIColorFromRGB(WhiteColorValue) forState:UIControlStateNormal];
    [self showSelectedView];
    
}


- (void)dateBtnCLick:(UIButton *)btn{
    
    
}

- (void)startTimeBtnClick{
    
}

- (void)endTimeBtnClick{
    
    
}
#pragma mark ====== 展示View

/**
 展示View
 */
- (void)showSelectedView{
    if (_selectedIndex ==0) {
        _numberView.hidden = NO;
        _customerView.hidden = NO;
        _saleManView.hidden = YES;
        _numberView.frame = CGRectMake(440, 10, 156, 30);
        _customerView.frame = CGRectMake(612, 10, 156, 30);
        _searchBtn.frame = CGRectMake(785, 10, 60, 30);
        _resetBtn.frame = CGRectMake(861, 10, 60, 30);
        
    }else if (_selectedIndex ==1){
        _numberView.hidden = YES;
        _customerView.hidden = NO;
        _saleManView.hidden = YES;
        _customerView.frame = CGRectMake(440, 10, 156, 30);
        _searchBtn.frame = CGRectMake(613, 10, 60, 30);
        _resetBtn.frame = CGRectMake(689, 10, 60, 30);
    }else if (_selectedIndex ==2){
        _numberView.hidden = YES;
        _customerView.hidden = YES;
        _saleManView.hidden = NO;
        _saleManView.frame = CGRectMake(440, 10, 156, 30);
        _searchBtn.frame = CGRectMake(613, 10, 60, 30);
        _resetBtn.frame = CGRectMake(689, 10, 60, 30);
    }
}

#pragma mark --- get
-(UIView *)numberView{
    if (!_numberView) {
        _numberView = [BaseViewFactory viewWithFrame:CGRectZero color:UIColorFromRGB(0xf5f5f5)];
        _numberTxt = [BaseViewFactory textFieldWithFrame:CGRectMake(36, 0, 120, 30) font:APPFONT13 placeholder:@"" textColor:UIColorFromRGB(BlackColorValue) placeholderColor:nil delegate:self];
        _numberTxt.backgroundColor = UIColorFromRGB(WhiteColorValue);
        [_numberView addSubview:_numberTxt];
        _numberTxt.layer.borderWidth = 1;
        _numberTxt.layer.borderColor = UIColorFromRGB(LineColorValue).CGColor;
        _numberTxt.text = @"选择客户";
        _numberTxt.leftViewMode = UITextFieldViewModeAlways;
        _numberTxt.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 10, 30)];
        UILabel *nameLab = [BaseViewFactory labelWithFrame:CGRectMake(0, 0, 30, 30) textColor:UIColorFromRGB(BlackColorValue) font:APPFONT13 textAligment:NSTextAlignmentLeft andtext:@"货号"];
        [_numberView addSubview:nameLab];
    }
    
    return _numberView;
}


-(UIView *)customerView{
    if (!_customerView) {
        _customerView = [BaseViewFactory viewWithFrame:CGRectZero color:UIColorFromRGB(0xf5f5f5)];
      
        UILabel *nameLab = [BaseViewFactory labelWithFrame:CGRectMake(0, 0, 30, 30) textColor:UIColorFromRGB(BlackColorValue) font:APPFONT13 textAligment:NSTextAlignmentLeft andtext:@"客户"];
        [_customerView addSubview:nameLab];
        
        _customerBtn  = [BaseViewFactory ylButtonWithFrame:CGRectMake(36, 0, 120, 30) font:APPFONT13 title:@"" titleColor:UIColorFromRGB(BlackColorValue) backColor:UIColorFromRGB(WhiteColorValue)];
        [_customerBtn setImage:[UIImage imageNamed:@"down_chose"] forState:UIControlStateNormal];
        _customerBtn.titleLabel.textAlignment = NSTextAlignmentLeft;
        [_customerBtn setTitleRect:CGRectMake(10, 0, 94, 30)];
        [_customerBtn setImageRect:CGRectMake(104, 14, 10, 10)];
        _customerBtn.layer.borderWidth = 1;
        _customerBtn.layer.borderColor = UIColorFromRGB(LineColorValue).CGColor;
        [_customerView addSubview:_customerBtn];
        [_customerBtn setTitle:@"选择客户" forState:UIControlStateNormal];
    }
    
    return _customerView;
}

-(UIView *)saleManView{
    if (!_saleManView) {
        _saleManView = [BaseViewFactory viewWithFrame:CGRectZero color:UIColorFromRGB(0xf5f5f5)];
        
        UILabel *nameLab = [BaseViewFactory labelWithFrame:CGRectMake(0, 0, 30, 30) textColor:UIColorFromRGB(BlackColorValue) font:APPFONT13 textAligment:NSTextAlignmentLeft andtext:@"销售"];
        [_saleManView addSubview:nameLab];
        
        _saleManBtn  = [BaseViewFactory ylButtonWithFrame:CGRectMake(36, 0, 120, 30) font:APPFONT13 title:@"" titleColor:UIColorFromRGB(BlackColorValue) backColor:UIColorFromRGB(WhiteColorValue)];
        [_saleManBtn setImage:[UIImage imageNamed:@"down_chose"] forState:UIControlStateNormal];
        _saleManBtn.titleLabel.textAlignment = NSTextAlignmentLeft;
        [_saleManBtn setTitleRect:CGRectMake(10, 0, 94, 30)];
        [_saleManBtn setImageRect:CGRectMake(104, 14, 10, 10)];
        _saleManBtn.layer.borderWidth = 1;
        _saleManBtn.layer.borderColor = UIColorFromRGB(LineColorValue).CGColor;
        [_saleManView addSubview:_saleManBtn];
        [_saleManBtn setTitle:@"选择客户" forState:UIControlStateNormal];

    }
    
    return _saleManView;
}



@end
