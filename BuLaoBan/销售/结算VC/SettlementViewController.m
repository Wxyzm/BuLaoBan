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
#import "SaleSamModel.h"
#import "PackListModel.h"
#import "Accounts.h"
#import "AccountChoseView.h"

@interface SettlementViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) BaseTableView *ListTab;               //左侧列表

@property (nonatomic, strong) BaseTableView *settleTab;              //结算列表

@property (nonatomic, strong)SettleKeyBoardView *keyBoardView;

@property (nonatomic, strong)NSString *accStr;
@property (nonatomic, assign)BOOL isHaveDian;
@property (nonatomic, strong)NSMutableArray *dataArr1;    //左侧dataarr
@property (nonatomic, strong)NSMutableArray *dataArr2;    //右侧dataarr
@property (nonatomic, strong) AccountChoseView  *choseView;
@property (nonatomic, strong)  Accounts *selectAccount;

@end

@implementation SettlementViewController{

    UISwitch *_mprintSwitch;
    UITextView *_memoTxt;
   
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
    _model.date = dateStr;
    _accStr = @"";
    _dataArr1 = [NSMutableArray arrayWithCapacity:0];
    _dataArr2 = [NSMutableArray arrayWithCapacity:0];
    NSArray *titlearr1 = @[@"业务日期",@"客户",@"业务员",@"货品数量",@"合计金额",@"其他费用",@"总计",@"备注"];
    NSArray *valueArr1 = @[dateStr,_model.comName,_model.sellerName?_model.sellerName:@"",[NSString stringWithFormat:@"%ld款, %ld匹, %.2f米",_model.styleNum,_model.pieceNum,_model.meetNum],[NSString stringWithFormat:@"%.2f元",_model.goofsMoney],@"",[NSString stringWithFormat:@"%.2f元",_model.goofsMoney],@"备注"];
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
        }else if (i==7){
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

    NSArray *titlearr2 = @[@"本单应收",@"本单已收",@"本单欠款",@"结算账户",@"抹零金额",@"实收金额"];
    NSArray *valueArr2 = @[[NSString stringWithFormat:@"%.2f元",_model.goofsMoney],@"0.00元",[NSString stringWithFormat:@"%.2f元",_model.goofsMoney],@"请选择",@"元",@"元"];
    NSMutableArray  *tarr1 = [NSMutableArray arrayWithCapacity:0];
    NSMutableArray  *tarr2 = [NSMutableArray arrayWithCapacity:0];

    for (int i = 0; i<titlearr2.count; i++) {
        Settlement *settleModel = [[Settlement alloc]init];
        settleModel.title = titlearr2[i];
        settleModel.showValue = valueArr2[i];
        if (i==3) {
            settleModel.ValueType = ValueType_Select;
        }else if (i==4){
            settleModel.ValueType = ValueType_Money;
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
        if ([selectStr isEqualToString:@"set"]) {
            //结算
            [weakself setAllInfo];
            return ;
        }
        if ([_accStr rangeOfString:@"."].location == NSNotFound)
        {
            weakself.isHaveDian = NO;
        }else{
            weakself.isHaveDian = YES;
            
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
                        NSArray *arr = [weakself.accStr componentsSeparatedByString:@"."];
                        if (arr.count>1) {
                            NSString *str = arr[1];
                            if (str.length<2) {
                                _accStr = [NSString stringWithFormat:@"%@%@",_accStr,selectStr];
                            }
                        }
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
        Settlement *tmodel = arr1[1];
        tmodel.showValue = [NSString stringWithFormat:@"%@元",_accStr];
        _model.actualAcc  = [NSString stringWithFormat:@"%@元",_accStr];
        [weakself setShowLab];
        NSLog(@"%@",_accStr);
    };
}

#pragma mark ====== 提交
- (void)setAllInfo{
    if (_model.actualAcc.length<=0) {
        [HUD show:@"请输入实收金额"];
        return;
    }
    if (!_selectAccount) {
        [HUD show:@"请选择结算账户"];
        return;
    }
    NSLog(@"%@",_model);
    User *user = [[UserPL shareManager] getLoginUser];
    NSMutableDictionary *setDic= [[NSMutableDictionary alloc]init];
    //公司ID*
    [setDic setObject:user.defutecompanyId forKey:@"companyId"];
    //销售单ID
//    if (_model.sellOrderId.length>0) {
//        [setDic setObject:_model.sellOrderId forKey:@"sellOrderId"];
//        
//    }
    //发货日期*
    [setDic setObject:_model.date forKey:@"deliverDate"];
    //备注
    [setDic setObject:_memoTxt.text forKey:@"remark"];
    //销售员ID
    [setDic setObject:_model.sellerId forKey:@"sellerId"];
    //客户ID
    [setDic setObject:_model.comId forKey:@"customerId"];
    //价格单位【11:元 12:美元】
    [setDic setObject:@"11" forKey:@"priceUnit"];
    //预收款 就是已收金额
    [setDic setObject:[_model.actualAcc stringByReplacingOccurrencesOfString:@"元" withString:@""] forKey:@"depositPrice"];

    //剩余应收款 就是欠款金额
    [setDic setObject:[_model.oweAcc stringByReplacingOccurrencesOfString:@"元" withString:@""] forKey:@"receivablePrice"];
    //订单类型【0:剪样 1:大货】
    [setDic setObject:_model.type?_model.type:@"0" forKey:@"type"];
    //计税类型【0:不计税 1:应税内含 2:应税外加】
    [setDic setObject:@"0" forKey:@"taxType"];
    //付款类型
    [setDic setObject:@"1" forKey:@"payType"];
    //结算状态【0：挂单 1：结算】
    [setDic setObject:@"1" forKey:@"settleStatus"];
    //仓库ID*
    [setDic setObject:_model.wareID.length>0?_model.wareID:@"" forKey:@"warehouseId"];
    //公司账户ID
    [setDic setObject:_selectAccount.companyAccountId forKey:@"companyAccountId"];

    
    NSMutableArray *details = [NSMutableArray arrayWithCapacity:0];
    NSMutableArray *packingListDetail = [NSMutableArray arrayWithCapacity:0];

    for (int i = 0; i<_model.packListArr.count; i++)
    {
        SaleSamModel *samodel = _model.packListArr[i];
        NSMutableDictionary *packingListDetailDic = [[NSMutableDictionary alloc]init];
        //样品ID*
        [packingListDetailDic setObject:samodel.sampId forKey:@"sampleId"];
        //样品颜色
        [packingListDetailDic setObject:samodel.color forKey:@"colorName"];
        if (samodel.packingList.count>0){
            [packingListDetailDic setObject:[NSString stringWithFormat:@"%ld",samodel.packingList.count] forKey:@"boltNo"];
        }
        //o匹
        [packingListDetailDic setObject:samodel.pieces forKey:@"packageNum"];
        [packingListDetailDic setObject:@"卷" forKey:@"packageUnit"];

        [packingListDetailDic setObject:[NSString stringWithFormat:@"%.2f",[samodel.salesVol floatValue]] forKey:@"quantity"];
        [packingListDetailDic setObject:samodel.unit forKey:@"quantityUnit"];
        [packingListDetail addObject:packingListDetailDic];
        
        
        //details
        //[NSString stringWithFormat:@"%ld款, %ld匹, %.2f米",_model.styleNum,_model.pieceNum,_model.meetNum]
        NSMutableDictionary *samDic = [[NSMutableDictionary alloc]init];
        //样品ID*
        [samDic setObject:samodel.sampId forKey:@"sampleId"];
        //样品颜色
        [samDic setObject:samodel.color forKey:@"colorName"];
        //件数数量
        //o匹
        [samDic setObject:samodel.pieces forKey:@"packageNum"];
        [samDic setObject:@"卷" forKey:@"packageUnit"];
        //发货数量*
        [samDic setObject:samodel.salesVol?samodel.salesVol:[NSString stringWithFormat:@"%.2f",_model.meetNum] forKey:@"num"];
        //数量单位*
        [samDic setObject:samodel.unit.length>0?samodel.unit:@"米" forKey:@"numUnit"];
        //单价
        [samDic setObject:samodel.unitPrice forKey:@"unitPrice"];
        //税率
        //[samDic setObject: forKey:@"taxRate"];
        //附加费
        //[samDic setObject: forKey:@"extraCharge"];
        //价格
        [samDic setObject:samodel.money forKey:@"price"];
        //未税金额
       // [samDic setObject:samodel.money forKey:@"noTaxPrice"];
        //税额
        //[samDic setObject: forKey:@"taxPrice"];
        //汇率
        //[samDic setObject: forKey:@"exchangeRate"];
        //外币金额
        //[samDic setObject: forKey:@"foreignPrice"];
        if (samodel.packingList.count>0)
        {
            NSMutableDictionary *packDic = [[NSMutableDictionary alloc]init];
            [packDic setObject:user.defutecompanyName forKey:@"title"];
            [packDic setObject:@"" forKey:@"subTitle"];
            [packDic setObject:@"出库细码单" forKey:@"typeTitle"];
            [packDic setObject:@{@"label":@"编号",@"value":samodel.itemNo} forKey:@"infoTL"];
            [packDic setObject:@{@"label":@"客户",@"value":_model.comName} forKey:@"infoTR"];
            [packDic setObject:@{@"label":@"颜色",@"value":samodel.color} forKey:@"infoBL"];
            [packDic setObject:@{@"label":@"日期",@"value":_model.date} forKey:@"infoBR"];
            [packDic setObject:@{@"label":@"",@"value":@""} forKey:@"infoBBL"];
            [packDic setObject:@{@"label":@"",@"value":@""} forKey:@"infoBBR"];
            NSMutableArray *colThArr = [NSMutableArray arrayWithCapacity:0];
            int a = 0;
            int b = 0;
            CGFloat meeta = 0.00;
            CGFloat meetb = 0.00;
            
            NSMutableArray *dataArr = [NSMutableArray arrayWithCapacity:0];
            for ( PackListModel *pacModel in samodel.packingList) {
                if (pacModel.meet.length>0) {
                    [dataArr addObject:pacModel];
                }
            }
            for (int j= 0; j<dataArr.count; j++) {
                PackListModel *pacModel = dataArr[j];
                if (j%2==0) {
                    a+=1;
                    meeta += [pacModel.meet floatValue];
                }else{
                    b+=1;
                    meetb += [pacModel.meet floatValue];
                }
            }
            NSDictionary *dic1 =  @{
                                   @"label": @"卷号",
                                   @"key": @"line",
                                   @"value":@[a>0?[NSString stringWithFormat:@"%d",a]:@"",b>0?[NSString stringWithFormat:@"%d",b]:@""],
                                   @"isDefault": @"false",
                                   @"editable": @"true"
                                   };
            NSDictionary *dic2 =  @{
                                    @"label": @"缸号",
                                    @"key": @"gang",
                                    @"value": @[@"",@""],
                                    @"isDefault": @"false",
                                    @"editable": @"true"
                                    };
            NSDictionary *dic3 =  @{
                                    @"label": @"包号",
                                    @"key": @"bao",
                                    @"value": @[@"",@""],
                                    @"isDefault": @"false",
                                    @"editable": @"true"
                                    };
            NSDictionary *dic4 =  @{
                                    @"label": @"米",
                                    @"key": @"count",
                                    @"value":@[meeta>0?[NSString stringWithFormat:@"%.2f",meeta]:@"",meetb>0?[NSString stringWithFormat:@"%.2f",meetb]:@""],
                                    @"isDefault": @"false",
                                    @"editable": @"true"
                                    };
            [colThArr addObject:dic1];
            [colThArr addObject:dic2];
            [colThArr addObject:dic3];
            [colThArr addObject:dic4];
            [packDic setObject:colThArr forKey:@"colTh"];
            
            NSMutableArray *twoArr = [self splitArray:dataArr withSubSize:2];
            NSMutableArray *twoSetArr = [NSMutableArray arrayWithCapacity:0];
            for (NSArray *arr in twoArr) {
                NSArray *setmodelarr;
                if (arr.count<2&&arr.count>0) {
                    PackListModel *twomodel = arr[0];
                    //不足两个
                    setmodelarr = @[@"",twomodel.reel,twomodel.dyelot,@"",twomodel.meet,@"",@"",@"",@"",@""];
                }else if (arr.count==2){
                    PackListModel *twomodel = arr[0];
                    PackListModel *twomodel1 = arr[1];
                    setmodelarr = @[@"",twomodel.reel,twomodel.dyelot,@"",twomodel.meet,@"",twomodel1.reel,twomodel1.dyelot,@"",twomodel1.meet];
                }
                [twoSetArr addObject:setmodelarr];
            }
            [packDic setObject:twoSetArr forKey:@"rowTr"];
            NSLog(@"%@",packDic);
            [samDic setObject:[GlobalMethod dictionaryToJson:packDic] forKey:@"packingList"];
        }
        [details addObject:samDic];

    }
    [setDic setObject:details forKey:@"details"];
    [setDic setObject:packingListDetail forKey:@"packingListDetail"];
    [[HttpClient sharedHttpClient] requestPOST:@"/sell/deliver" Withdict:setDic WithReturnBlock:^(id returnValue) {
        [HUD show:@"结算完成"];
         [[NSNotificationCenter defaultCenter] postNotificationName:@"deliverSuccess" object:nil];
        [self.navigationController popViewControllerAnimated:YES];
    } andErrorBlock:^(NSString *msg) {
        
    }];
}

#pragma mark -- 将数组拆分成固定长度
/**
 *  将数组拆分成固定长度的子数组
 *  @param array 需要拆分的数组
 *  @param subSize 指定长度
 */
- (NSMutableArray*)splitArray: (NSMutableArray*)array withSubSize : (int)subSize{
    //  数组将被拆分成指定长度数组的个数
    unsigned long count = array.count% subSize ==0? (array.count/ subSize) : (array.count/ subSize +1);
    //  用来保存指定长度数组的可变数组对象
    NSMutableArray*arr = [[NSMutableArray alloc]init];
    //利用总个数进行循环，将指定长度的元素加入数组
    for(int i =0; i < count; i ++) {
        //数组下标
        int index =i* subSize;
        //保存拆分的固定长度的数组元素的可变数组
        NSMutableArray*arr1= [[NSMutableArray alloc]init];
        //移除子数组的所有元素
        [arr1 removeAllObjects];
        int j = index;
        //将数组下标乘以1、2、3，得到拆分时数组的最大下标值，但最大不能超过数组的总大小
        while(j < subSize*(i +1) && j < array.count) {
            [arr1 addObject:[array objectAtIndex:j]];
            j +=1;
        }
        //将子数组添加到保存子数组的数组中
        [arr addObject:[arr1 mutableCopy]];
    }
    return[arr mutableCopy];
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
            if (indexPath.row==0) {
                return 120;
            }
        }
        return 50;
    }
    if (indexPath.section == 1 && indexPath.row == 1) {
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
            static NSString *leftCellid = @"memoCellid";
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:leftCellid];
            if (!cell) {
                cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:leftCellid];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                UILabel *memoLab = [BaseViewFactory labelWithFrame:CGRectMake(16, 14, 40, 17) textColor:UIColorFromRGB(BlackColorValue) font:APPFONT16 textAligment:NSTextAlignmentLeft andtext:@"备注"];
                [cell.contentView addSubview:memoLab];
                _memoTxt = [[UITextView alloc]initWithFrame:CGRectMake(16, 40, 368, 80)];
                [cell.contentView addSubview:_memoTxt];
            }
            return cell;
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
    if (model.ValueType == ValueType_Money){
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

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.ListTab)
    {
        
    }
    else if (tableView == self.settleTab)
    {
     //右侧按钮
        if (indexPath.section == 0)
        {
            if (indexPath.row ==3)
            {
                //账户选择
                [self loadComAccountList];
            }
        }
    }
}
#pragma mark ======  获取公司账户列表
- (void)loadComAccountList{
    User  *user = [[UserPL shareManager] getLoginUser];
    [[HttpClient sharedHttpClient] requestGET:[NSString stringWithFormat:@"/companys/%@/account",user.defutecompanyId] Withdict:nil WithReturnBlock:^(id returnValue) {
        NSLog(@"%@",returnValue);
        NSMutableArray *listArr = [Accounts mj_objectArrayWithKeyValuesArray:returnValue[@"accounts"]];
        self.choseView.listArr = listArr;
        [self.choseView showInView];
        WeakSelf(self);
        self.choseView.returnBlock = ^(Accounts * _Nonnull model) {
            weakself.selectAccount = model;
            NSArray *allArr = weakself.dataArr2[0];
            Settlement *settleModel = allArr[3];
            settleModel.showValue = model.accountName;
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakself.settleTab reloadData];
            });
        };
    } andErrorBlock:^(NSString *msg) {
    }];
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
    Settlement *ssmodel = arr3[1];
     //抹零model
    Settlement *mzmodel = arr3[0];
    //总计赋值
    zjModel.showValue = [NSString stringWithFormat:@"%.2f元",[qtModel.showValue floatValue] +[hjModel.showValue floatValue]];
    //应收赋值
    ysModel.showValue = zjModel.showValue;
    _model.needAcc = zjModel.showValue;
    //已收赋值
    shouldModel.showValue = ssmodel.showValue;
    //欠款赋值
    qkModel.showValue =  [NSString stringWithFormat:@"%.2f元",[ysModel.showValue floatValue] -[shouldModel.showValue floatValue]-[mzmodel.showValue floatValue]];
    _model.oweAcc = qkModel.showValue;
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

-(AccountChoseView *)choseView{
    if (!_choseView) {
        _choseView = [[AccountChoseView alloc]init];
    }
    return _choseView;
}


@end
