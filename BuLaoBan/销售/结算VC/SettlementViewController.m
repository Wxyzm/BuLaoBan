//
//  SettlementViewController.m
//  BuLaoBan
//
//  Created by apple on 2019/2/22.
//  Copyright © 2019年 XX. All rights reserved.
//  所有好走的路，都是下坡路

#import "SettlementViewController.h"
#import "SettlementInputCell.h"
#import "SettleKeyBoardView.h"

#import "Settlement.h"

@interface SettlementViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) BaseTableView *ListTab;               //左侧列表

@property (nonatomic, strong) BaseTableView *settleTab;              //结算列表

@property (nonatomic, strong)SettleKeyBoardView *keyBoardView;
@end

@implementation SettlementViewController{
    
    NSMutableArray *_dataArr1;    //左侧dataarr
    NSMutableArray *_dataArr2;    //右侧dataarr
    UISwitch *_mprintSwitch;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"结算";
    [self setBarBackBtnWithImage:nil];
    [self initData];
    [self initUI];
}

- (void)initData{
    _dataArr1 = [NSMutableArray arrayWithCapacity:0];
    _dataArr2 = [NSMutableArray arrayWithCapacity:0];
    NSArray *titlearr1 = @[@"销货单号",@"业务日期",@"客户",@"业务员",@"货品数量",@"合计金额",@"其他费用",@"总计",@"备注"];
    NSArray *valueArr1 = @[@"XS201712200001",@"2019-01-18",@"吉布纺织（欠款:500.00元)",@"小王",@"2款, 4匹, 100.00米",@"1000.00元",@"50.00元",@"1050.00元",@"备注"];
    NSMutableArray  *arr1 = [NSMutableArray arrayWithCapacity:0];
    NSMutableArray  *arr2 = [NSMutableArray arrayWithCapacity:0];
    NSMutableArray  *arr3 = [NSMutableArray arrayWithCapacity:0];

    
    for (int i = 0; i<titlearr1.count; i++) {
        Settlement *settleModel = [[Settlement alloc]init];
        settleModel.title = titlearr1[i];
        settleModel.showValue = valueArr1[i];
        if (i==1||i==2||i==3) {
            settleModel.ValueType = ValueType_Select;
        }else if (i==8){
            settleModel.ValueType = ValueType_Memo;
        }else{
            settleModel.ValueType = ValueType_Input;
        }
        if (i==2||i==5||i==6||i==6) {
            settleModel.isRedText = YES;
        }
        if (i<=3) {
            [arr1 addObject:settleModel];
        }else if (i<=6){
            [arr2 addObject:settleModel];

        }else{
            [arr3 addObject:settleModel];

        }
    }
    [_dataArr1 addObject:arr1];
    [_dataArr1 addObject:arr2];
    [_dataArr1 addObject:arr3];

    NSArray *titlearr2 = @[@"本单应收",@"本单已收",@"本单欠款",@"结算账户",@"实收金额",@"开单后打印"];
    NSArray *valueArr2 = @[@"1050.00元",@"0.00元",@"0.00元",@"支付宝",@"元",@""];
    
    NSMutableArray  *tarr1 = [NSMutableArray arrayWithCapacity:0];
    NSMutableArray  *tarr2 = [NSMutableArray arrayWithCapacity:0];

    for (int i = 0; i<titlearr2.count; i++) {
        Settlement *settleModel = [[Settlement alloc]init];
        settleModel.title = titlearr2[i];
        settleModel.showValue = valueArr2[i];
        if (i==3) {
            settleModel.ValueType = ValueType_Select;
        }else{
            settleModel.ValueType = ValueType_Input;
        }
        if (i==0||i==1||i==2) {
            settleModel.isRedText = YES;
        }
        if (i<=3) {
            [tarr1 addObject:settleModel];
        }else{
            [tarr2 addObject:settleModel];
            
        }
    }
    [_dataArr2 addObject:tarr1];
    [_dataArr2 addObject:tarr2];

}


- (void)initUI{
    [self.view addSubview:self.ListTab];
    [self.view addSubview:self.settleTab];
    UIView *line = [BaseViewFactory viewWithFrame:CGRectMake(400, 0, 1, ScreenHeight-64) color:UIColorFromRGB(LineColorValue)];
    [self.view addSubview:line];
    
    _keyBoardView = [[SettleKeyBoardView alloc]initWithFrame:CGRectMake(ScreenWidth-524-100, 330, 524, 374)];
    [self.view addSubview:_keyBoardView];
    _keyBoardView.returnBlock = ^(NSString * _Nonnull selectStr) {
      
    };
}

#pragma mark ====== tableviewdelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (tableView == self.ListTab)
    {
        return 3;
    }
    return 2;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (tableView == self.ListTab)
    {
        if (section==0)
        {
            return 0.0001;
        }
        return 10;
    }
    if (section==0)
    {
        return 0.0001;
    }
    return 10;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (tableView == self.ListTab)
    {
        if (section==0)
        {
            return [UIView new];
        }
        return [BaseViewFactory viewWithFrame:CGRectMake(0, 0, 400, 10) color:UIColorFromRGB(BackColorValue)];
    }
    if (section==0)
    {
        return [UIView new];
    }
    return [BaseViewFactory viewWithFrame:CGRectMake(0, 0, 400, 10) color:UIColorFromRGB(BackColorValue)];
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (tableView == self.ListTab)
    {
        if (indexPath.section ==2) {
            if (indexPath.row==1) {
                return 120;
            }
        }
        return 50;
    }
    if (indexPath.section ==1) {
       return 70;
    }
    return 50;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView == self.ListTab)
    {
        NSMutableArray *dataArr = _dataArr1[section];
        return dataArr.count;
    }
    NSMutableArray *dataArr = _dataArr2[section];
    return dataArr.count;
}



-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.ListTab)
    {
        NSMutableArray *dataArr = _dataArr1[indexPath.section];
        Settlement *model = dataArr[indexPath.row];
        if (model.ValueType == ValueType_Memo) {
            //备注
        }
        static NSString *leftCellid = @"leftCellid";
        SettlementInputCell *cell = [tableView dequeueReusableCellWithIdentifier:leftCellid];
        if (!cell) {
            cell = [[SettlementInputCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:leftCellid];
        }
        cell.Settlement = model;
        if (indexPath.section == 0) {
            if (indexPath.row ==3) {
                cell.lineView.hidden = YES;
            }
        }else if (indexPath.section == 1){
            if (indexPath.row ==2) {
                cell.lineView.hidden = YES;
            }
        }else{
           cell.lineView.hidden = NO;
        }
        
        return cell;
    }
    NSMutableArray *dataArr = _dataArr2[indexPath.section];
    Settlement *model = dataArr[indexPath.row];
    if (indexPath.section ==1&&indexPath.row ==1) {
        static NSString *btnCellid = @"Cellid";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:btnCellid];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:btnCellid];
            cell.contentView.backgroundColor = UIColorFromRGB(BackColorValue);
            UILabel *showLab = [BaseViewFactory labelWithFrame:CGRectMake(253, 0, 180, 50) textColor:UIColorFromRGB(BlackColorValue) font:APPFONT16 textAligment:NSTextAlignmentRight andtext:@"开单后打印"];
            [cell.contentView addSubview:showLab];
            _mprintSwitch = [[UISwitch alloc] initWithFrame:CGRectMake(454, 10, 52, 31)];
            [cell.contentView addSubview:_mprintSwitch];

        }
        return cell;
    }
    
    
    static NSString *leftCellid = @"rightCellid";
    SettlementInputCell *cell = [tableView dequeueReusableCellWithIdentifier:leftCellid];
    if (!cell) {
        cell = [[SettlementInputCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:leftCellid];
    }
    cell.Settlement = model;
    if (indexPath.section == 0) {
        if (indexPath.row ==3) {
            cell.lineView.hidden = YES;
        }
    }else if (indexPath.section == 1){
        if (indexPath.row ==0) {
            cell.lineView.hidden = YES;
        }
    }else{
        cell.lineView.hidden = NO;
    }
    
    return cell;
    
}




#pragma mark ====== get

-(BaseTableView *)ListTab{
    
    
    if (!_ListTab) {
        _ListTab = [[BaseTableView alloc] initWithFrame:CGRectMake(0, 0, 400, ScreenHeight-64) style:UITableViewStylePlain];
        _ListTab.delegate = self;
        _ListTab.dataSource = self;
        _ListTab.backgroundColor = UIColorFromRGB(BackColorValue);
        _ListTab.separatorStyle = UITableViewCellSeparatorStyleNone;
        _ListTab.bounces = NO;

        if (@available(iOS 11.0, *)) {
            _ListTab.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {
            
        }
    }
    return _ListTab;
    
}


-(BaseTableView *)settleTab{
    
    
    if (!_settleTab) {
        _settleTab = [[BaseTableView alloc] initWithFrame:CGRectMake(400, 0, 524, ScreenHeight-64-374) style:UITableViewStylePlain];
        _settleTab.delegate = self;
        _settleTab.dataSource = self;
        _settleTab.backgroundColor = UIColorFromRGB(BackColorValue);
        _settleTab.separatorStyle = UITableViewCellSeparatorStyleNone;
        _settleTab.bounces = NO;
        if (@available(iOS 11.0, *)) {
            _settleTab.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {
            
        }
    }
    return _settleTab;
    
}



@end
