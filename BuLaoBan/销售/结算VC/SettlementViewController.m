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
#import "SettleVcModel.h"
#import "Settlement.h"
#import "SettleMoneyCell.h"

@interface SettlementViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) BaseTableView *ListTab;               //左侧列表

@property (nonatomic, strong) BaseTableView *settleTab;              //结算列表

@property (nonatomic, strong)SettleKeyBoardView *keyBoardView;

@property (nonatomic, strong)NSString *accStr;
@property (nonatomic, assign)BOOL isHaveDian;
@property (nonatomic, strong)NSMutableArray *dataArr1;    //左侧dataarr
@property (nonatomic, strong)NSMutableArray *dataArr2;    //右侧dataarr

@end

@implementation SettlementViewController{

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
    NSDate *date=[NSDate date];
    NSDateFormatter *format1=[[NSDateFormatter alloc] init];
    [format1 setDateFormat:@"yyyy-MM-dd"];
    NSString *dateStr;
    dateStr=[format1 stringFromDate:date];
    _accStr = @"";
    _dataArr1 = [NSMutableArray arrayWithCapacity:0];
    _dataArr2 = [NSMutableArray arrayWithCapacity:0];
    NSArray *titlearr1 = @[@"业务日期",@"客户",@"业务员",@"货品数量",@"合计金额",@"其他费用",@"总计",@"备注"];
    NSArray *valueArr1 = @[dateStr,_model.comName,_model.sellerName,[NSString stringWithFormat:@"%ld款, %ld匹, %.2f米",_model.styleNum,_model.pieceNum,_model.meetNum],[NSString stringWithFormat:@"%.2f元",_model.goofsMoney],@"",[NSString stringWithFormat:@"%.2f元",_model.goofsMoney],@"备注"];
    NSMutableArray  *arr1 = [NSMutableArray arrayWithCapacity:0];
    NSMutableArray  *arr2 = [NSMutableArray arrayWithCapacity:0];
    NSMutableArray  *arr3 = [NSMutableArray arrayWithCapacity:0];

    
    for (int i = 0; i<titlearr1.count; i++) {
        Settlement *settleModel = [[Settlement alloc]init];
        settleModel.title = titlearr1[i];
        settleModel.showValue = valueArr1[i];
        if (i==1||i==2||i==3) {
            settleModel.ValueType = ValueType_Select;
        }else if (i==5){
            settleModel.ValueType = ValueType_Money;
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
    NSArray *valueArr2 = @[[NSString stringWithFormat:@"%.2f元",_model.goofsMoney],@"0.00元",[NSString stringWithFormat:@"%.2f元",_model.goofsMoney],@"支付宝",@"元",@""];
    
    NSMutableArray  *tarr1 = [NSMutableArray arrayWithCapacity:0];
    NSMutableArray  *tarr2 = [NSMutableArray arrayWithCapacity:0];

    for (int i = 0; i<titlearr2.count; i++) {
        Settlement *settleModel = [[Settlement alloc]init];
        settleModel.title = titlearr2[i];
        settleModel.showValue = valueArr2[i];
        if (i==3) {
            settleModel.ValueType = ValueType_Select;
        }else if (i==4){
            settleModel.ValueType = ValueType_Input;
        }else{
            settleModel.ValueType = ValueType_Input;
        }
        if (i==0||i==1||i==2||i==4) {
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
    self.view.backgroundColor = UIColorFromRGB(BackColorValue);
    [self.view addSubview:self.ListTab];
    [self.view addSubview:self.settleTab];
    UIView *line = [BaseViewFactory viewWithFrame:CGRectMake(400, 0, 1, ScreenHeight-64) color:UIColorFromRGB(LineColorValue)];
    [self.view addSubview:line];
    
    _keyBoardView = [[SettleKeyBoardView alloc]initWithFrame:CGRectMake(ScreenWidth-524-100, 330, 524, 374)];
    [self.view addSubview:_keyBoardView];
    WeakSelf(self);
    _keyBoardView.returnBlock = ^(NSString * _Nonnull selectStr) {
        if ([_accStr rangeOfString:@"."].location == NSNotFound)
        {
            weakself.isHaveDian = NO;
        }
        if ([selectStr length] > 0)
        {
            unichar single = [selectStr characterAtIndex:0];//当前输入的字符
            if ((single >= '0' && single <= '9') || single == '.')//数据格式正确
            {
                //首字母不能为0和小数点
                if([_accStr length] == 0)
                {
                    if(single == '.')
                    {
                    }
                }
                //输入的字符是否是小数点
                if (single == '.')
                {
                    if(!weakself.isHaveDian)
                    {//text中还没有小数点
                        if (_accStr.length<=0) {
                        }else{
                            weakself.isHaveDian = YES;
                            _accStr = [NSString stringWithFormat:@"%@%@",_accStr,selectStr];
                        }
                    }else{
                        //text中有小数点
                    }
                    
                }else{
                    if (weakself.isHaveDian) {//存在小数点
                        //判断小数点的位数
                        _accStr = [NSString stringWithFormat:@"%@%@",_accStr,selectStr];
                    }else{
                        _accStr = [NSString stringWithFormat:@"%@%@",_accStr,selectStr];
                    }
                }
            }else{//输入的数据格式不正确
   
            }
        }
        else
        {
            //删除
            _accStr = [NSString stringWithFormat:@"%@%@",_accStr,selectStr];
            if (_accStr.length>0) {
              _accStr =  [_accStr stringByReplacingCharactersInRange:NSMakeRange(_accStr.length-1, 1) withString:@""];
            }
        }
        NSArray *arr1 = weakself.dataArr2[1];
        Settlement *tmodel = arr1[0];
        tmodel.showValue = [NSString stringWithFormat:@"%@元",_accStr];
        [weakself setShowLab];
        NSLog(@"%@",_accStr);
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
        }else if (model.ValueType == ValueType_Money){
            //其他费用
            static NSString *leftCellid = @"MoneyCellid";
            SettleMoneyCell *cell = [tableView dequeueReusableCellWithIdentifier:leftCellid];
            if (!cell) {
                cell = [[SettleMoneyCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:leftCellid];
            }
            cell.Settlement = model;
            cell.returnBlock = ^(Settlement * _Nonnull model) {
                [self setShowLab];
            };
            return cell;
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
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
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

#pragma mark ====== 设置显示
- (void)setShowLab{
    NSArray *arr1 = _dataArr1[1];
    //合计model
    Settlement *hjModel = arr1[0];
    //其他model
    Settlement *qtModel = arr1[1];
    //总计model
    Settlement *zjModel = arr1[2];
    
    NSArray *arr2 = _dataArr2[0];
    //应收model
    Settlement *ysModel = arr2[0];
    //已收model
    Settlement *shouldModel = arr2[1];
    //欠款model
    Settlement *qkModel = arr2[2];
    
    NSArray *arr3 = _dataArr2[1];
    //实收model
    Settlement *ssmodel = arr3[0];
    
    //总计赋值
    zjModel.showValue = [NSString stringWithFormat:@"%.2f元",[qtModel.showValue floatValue] +[hjModel.showValue floatValue]];
    //应收赋值
    ysModel.showValue = zjModel.showValue;
    //已收赋值
    shouldModel.showValue = ssmodel.showValue;
    //欠款赋值
    qkModel.showValue =  [NSString stringWithFormat:@"%.2f元",[ysModel.showValue floatValue] -[shouldModel.showValue floatValue]];
    
    
    
//    //输入金额完成
//    if ([model.title isEqualToString:@"其他费用"]) {
//        //总计
//        NSArray *arr = _dataArr1[1];
//        Settlement *tmodel = arr[2];
//        tmodel.showValue = [NSString stringWithFormat:@"%.2f元",[model.showValue floatValue] +_model.goofsMoney];
//        //本单应收
//        NSArray *arr2 = _dataArr2[0];
//        Settlement *smodel = arr2[0];
//        smodel.showValue = [NSString stringWithFormat:@"%.2f元",[model.showValue floatValue] +_model.goofsMoney];
//        //本单欠款
//    }
    dispatch_async(dispatch_get_main_queue(), ^{
        //在主线程刷新
        [self.ListTab reloadData];
        [self.settleTab reloadData];
    });
    
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
