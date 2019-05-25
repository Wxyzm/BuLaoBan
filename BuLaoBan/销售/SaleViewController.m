//
//  SaleViewController.m
//  BuLaoBan
//
//  Created by apple on 2019/1/28.
//  Copyright © 2019年 XX. All rights reserved.
//

#import "SaleViewController.h"
#import "SaleHeader.h"

@interface SaleViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) BaseTableView *ListTab;               //列表
@property (nonatomic, strong) SaleHeaderView *HeaderView;           //顶部View
@property (nonatomic, strong) DIYSearchKeyBoardView *KeyBoardView;  //键盘
@property (nonatomic, strong) SaleCustomerView *CustomerView;       //客户、类型、仓库
@property (nonatomic, strong) CustomerSelecteView *customerSelecteView;       //客户选择
@property (nonatomic, strong) SampleSearchResultView *sampleSearchResultView; //样品选择
@property (nonatomic, strong) PackingListView *packingListView;     //细码单填写
@property (nonatomic, strong) GetDelView *delView;                  //取单View
@property (nonatomic, strong) TypeChoseView *typeView;              //剪样大货

@property (nonatomic, strong) UILabel *numLab;                      //数量
@property (nonatomic, strong) UILabel *moneyLab;                    //金额

@property (nonatomic, strong) SaleVcModel *model;                   //首页数据保存Model
@property (nonatomic, strong) SettleVcModel *settleModel;           //结算model

@property (nonatomic, strong) WarehouseView *wareView;

@end

@implementation SaleViewController{
    NSString *_SearchStr;        //搜索关键字
    NSMutableArray *_dataArr;    //显示数据
    NSMutableArray *_SearchArr;  //搜索出的数据
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.needHideNavBar = YES;
    self.view.backgroundColor = UIColorFromRGB(BackColorValue);
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadtheList) name:@"deliverSuccess" object:nil];

    [self initDatas];
    [self initUI];
    [self loadOrderListandisShowView:NO];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self getComSetting];
    
}

- (void)initDatas{
    _SearchStr = @"";
    _dataArr = [NSMutableArray arrayWithCapacity:0];
    _model = [[SaleVcModel alloc]init];
    _settleModel = [[SettleVcModel alloc]init];
}

- (void)initUI{
    //顶部
    [self.view addSubview:self.HeaderView];
    //客户选择
    [self.view addSubview:self.CustomerView];
    //自定义键盘
    [self.view addSubview:self.KeyBoardView];
    //列表顶部view
    SaleListTopView *topView = [[SaleListTopView alloc]initWithFrame:CGRectMake(0, 114, 704, 40)];
    [self.view addSubview:topView];
    //列表
    [self.view addSubview:self.ListTab];
    //右侧统计
    UIView *StatisticsView = [BaseViewFactory viewWithFrame:CGRectMake(ScreenWidth-100-220, 564, 220, ScreenHeight-564) color:UIColorFromRGB(WhiteColorValue)];
    [self.view addSubview:StatisticsView];

    UILabel *numlab = [BaseViewFactory labelWithFrame:CGRectMake(10, 0, 50, 50) textColor:UIColorFromRGB(BlackColorValue) font:APPFONT14 textAligment:NSTextAlignmentLeft andtext:@"数量"];
    [StatisticsView addSubview:numlab];
    _numLab  = [BaseViewFactory labelWithFrame:CGRectMake(50, 0, 160, 50) textColor:UIColorFromRGB(BlueColorValue) font:APPFONT14 textAligment:NSTextAlignmentRight andtext:@"0款, 0匹, 0.00米"];
    [StatisticsView addSubview:_numLab];
    UIView *line = [BaseViewFactory viewWithFrame:CGRectMake(10, 49, 200, 1) color:UIColorFromRGB(LineColorValue)];
    [StatisticsView addSubview:line];

    UILabel *moneylab = [BaseViewFactory labelWithFrame:CGRectMake(10, 50, 50, 50) textColor:UIColorFromRGB(BlackColorValue) font:APPFONT14 textAligment:NSTextAlignmentLeft andtext:@"金额"];
    [StatisticsView addSubview:moneylab];
    _moneyLab  = [BaseViewFactory labelWithFrame:CGRectMake(50, 50, 160, 50) textColor:UIColorFromRGB(RedColorValue) font:APPFONT14 textAligment:NSTextAlignmentRight andtext:@"0.00"];
    [StatisticsView addSubview:_moneyLab];
    UIView *line1 = [BaseViewFactory viewWithFrame:CGRectMake(10, 99, 200, 1) color:UIColorFromRGB(LineColorValue)];
    [StatisticsView addSubview:line1];

    UIButton *setBtn = [BaseViewFactory ylButtonWithFrame:CGRectMake(10, 125, 200, 50) font:APPFONT16 title:@"结算" titleColor:UIColorFromRGB(WhiteColorValue) backColor:UIColorFromRGB(BlueColorValue)];
    [StatisticsView addSubview:setBtn];
    setBtn.layer.cornerRadius = 2;
    [setBtn addTarget:self action:@selector(setBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    WeakSelf(self);
    //顶部view
    self.HeaderView.returnBlock = ^(NSInteger tag) {
        [weakself topBtnClickWithTag:tag];
    };
    //获取客户列表
    self.CustomerView.returnBlock = ^(NSInteger tag) {
        [weakself customerBtnClickWithTag:tag];
    };
    //选择客户
    self.customerSelecteView.returnBlock = ^(ComCustomer * _Nonnull comCusModel) {
        weakself.model.comId = comCusModel.comId;
        weakself.model.comName = comCusModel.name;
        weakself.settleModel.comId = comCusModel.comId;
        weakself.settleModel.comName = comCusModel.name;
        weakself.settleModel.sellerName = comCusModel.salesmanName;
        weakself.settleModel.sellerId = comCusModel.salesman;
        [weakself.CustomerView.customerBtn setTitle:comCusModel.name forState:UIControlStateNormal];
    };
    //选择仓库
    self.wareView.wareBlock = ^(Warehouses * _Nonnull model) {
        [weakself.CustomerView.wareBtn setTitle:model.warehouseName forState:UIControlStateNormal];
        weakself.settleModel.wareID = model.warehouseId;
    };
    //商品搜索
    self.KeyBoardView.returnBlock = ^(NSString * _Nonnull searchTxt) {
        _SearchStr = searchTxt;
        if (_SearchStr.length<=0) {
            [weakself.sampleSearchResultView dismiss];
        }else{
            [weakself loadGoodsList];
        }
    };
    //选择商品
    self.sampleSearchResultView.returnBlock = ^(Sample * _Nonnull SampleModel) {
        SaleSamModel *samodel = [[SaleSamModel alloc]init];
        samodel.urlStr = SampleModel.samplePicKey;
        samodel.sampId = SampleModel.sampleId;
        samodel.itemNo = SampleModel.itemNo;
        samodel.name = SampleModel.name;
        samodel.unit = SampleModel.primaryUnit;
        [weakself.model.sampleList addObject:samodel];
        [weakself reloadDatasList];
    };
    //保存细码单
    self.packingListView.returnBlock = ^(SaleSamModel * _Nonnull saleSamModel) {
        
        if (saleSamModel.unitPrice.length>0) {
            //计算总价
            saleSamModel.money = [NSString stringWithFormat:@"%.2f",[saleSamModel.unitPrice floatValue] *saleSamModel.MeetTotal];
        }else{
        }
        [weakself reloadDatasList];
    };
    self.typeView.returnBlock = ^(NSInteger index) {
        if (index ==0) {
            weakself.model.type = @"0";
            [weakself.CustomerView.kindBtn setTitle:@"剪样" forState:UIControlStateNormal];

        }else{
            weakself.model.type = @"1";
            [weakself.CustomerView.kindBtn setTitle:@"大货" forState:UIControlStateNormal];
        }
    };
    
}



#pragma mark ====== 顶部按钮点击 0:销售历史   1：s销售统计    2：挂单   3：取单
/**
 顶部按钮点击

 @param tag 0:销售历史   1：s销售统计    2：挂单   3：取单
 */
- (void)topBtnClickWithTag:(NSInteger)tag
{
    if (tag == 0)
    {
        //销售历史
        SaleHistoryController *hisVc = [[SaleHistoryController alloc]init];
        hisVc.returnBlock = ^(SellOrderDeliverDetail *detailModel) {
            [self initDatasWithdetailModel:detailModel];
        };
        [self.navigationController pushViewController:hisVc animated:YES];
        
    }else if (tag == 1)
    {
         //销售统计
        SaleStatisticController *staVc = [[SaleStatisticController alloc]init];
        [self.navigationController pushViewController:staVc animated:YES];
        
    }else if (tag == 2)
    {
        //挂单
        [self putOrders];
    }else if (tag == 3)
    {
        //取单
        [self loadOrderListandisShowView:YES];
    }
}

- (void)customerBtnClickWithTag:(NSInteger)tag
{
    if (tag == 0)
    {
        //选择客户
        [self loadCustomerList];
        
    }else if (tag == 1)
    {
        //选择类型
        [self.typeView showInView];
        
    }else if (tag == 2)
    {
        //扫码
        
    }
    else if (tag == 3)
    {
        //仓库
        [self loadWarehousesList];
    }
}


/**
 结算
 */
- (void)setBtnClick{
    if (_model.comId.length<=0) {
        [HUD show:@"请选择客户"];
        return;
    }
    if (_model.sampleList.count<=0) {
        [HUD show:@"请选择货品"];
        return;
    }
    for (int i = 0; i<_model.sampleList.count; i++) {
        SaleSamModel *goodModel = _model.sampleList[i];
        if (goodModel.color.length<=0) {
            [HUD show:@"请输入货品颜色"];
            return;
        }
        if (goodModel.unitPrice.length<=0) {
            [HUD show:@"请输入货品单价"];
            return;
        }
        if (goodModel.money.length<=0) {
            [HUD show:@"请输入货品金额"];
            return;
        }
        if (goodModel.packingList.count<=0) {
            //手动填写匹数、m销货量
            if (goodModel.pieces.length<=0) {
                [HUD show:@"请输入货品匹数"];
                return;
            }
            if (goodModel.salesVol.length<=0) {
                [HUD show:@"请输入货品销货量"];
                return;
            }
        }else{
            //细码单填写
        }
    }
    //添加商品
    [_settleModel.packListArr removeAllObjects];
    [_settleModel.packListArr addObjectsFromArray:_model.sampleList];
    
    SettlementViewController *setvc = [[SettlementViewController alloc]init];
    setvc.model = _settleModel;
    [self.navigationController pushViewController:setvc animated:YES];
 }



/**
 刷新列表数据
 */
- (void)reloadDatasList{
    [self .ListTab reloadData];
    //总米数
    CGFloat meet = 0.00;
    for (SaleSamModel *model in _model.sampleList) {
        if ([model.salesVol floatValue]>0) {
            meet += [model.salesVol floatValue];
        }else if (model.MeetTotal>0){
            meet += model.MeetTotal;
        }
    }
    //总匹数
    NSInteger pieces = 0;
    for (SaleSamModel *model in _model.sampleList) {
        if ([model.pieces integerValue]>0) {
            pieces += [model.pieces integerValue];
        }else if (model.piecesTotal>0){
            pieces += model.piecesTotal;
        }
    }
    _numLab.text = [NSString stringWithFormat:@"%ld款, %ld匹, %.2f米",_model.sampleList.count,pieces,meet];
    //总金额
    CGFloat money = 0.00;
    for (SaleSamModel *model in _model.sampleList) {
        money += [model.money floatValue];
    }
    _moneyLab.text = [NSString stringWithFormat:@"￥ %.2f",money];
    _settleModel.styleNum = _model.sampleList.count;
    _settleModel.pieceNum = pieces;
    _settleModel.meetNum = meet;
    _settleModel.goofsMoney = money;
}

#pragma mark ====== j获取客户列表
- (void)loadCustomerList{
    User *user = [[UserPL shareManager] getLoginUser];
    NSDictionary *dic = @{@"companyId":user.defutecompanyId,
                          @"pageNo":@"1",
                          @"pageSize":@"2000"
                          };
    [[HttpClient sharedHttpClient] requestGET:@"contact/company" Withdict:dic WithReturnBlock:^(id returnValue) {
        NSLog(@"%@",returnValue);
        NSMutableArray *dataArr = [ComCustomer mj_objectArrayWithKeyValuesArray:returnValue[@"contactCompanys"]];
        self.customerSelecteView.dataArr = dataArr;
        [self.customerSelecteView showView];
    } andErrorBlock:^(NSString *msg) {
        
    }];
}
#pragma mark ====== 获取货品列表
- (void)loadGoodsList{
    User *user = [[UserPL shareManager] getLoginUser];
    NSDictionary *updic = @{@"searchType":@"0",
                            @"companyId":user.defutecompanyId,
                            @"key":_SearchStr,
                            @"pageNo":@"1",
                            @"pageSize":@"5000"
                            };
    [SamplePL Sample_sampleSamplesRegisterWithDic:updic WithReturnBlock:^(id returnValue) {
        NSLog(@"%@",returnValue);
        NSMutableArray *reArr = [Sample mj_objectArrayWithKeyValuesArray:returnValue[@"samples"]];
        self.sampleSearchResultView.dataArr = reArr;
        [self.sampleSearchResultView showinView:self.view];
    } andErrorBlock:^(NSString *msg) {
    }];
}
#pragma mark ====== 获取仓库列表
- (void)loadWarehousesList{
    User *user = [[UserPL shareManager] getLoginUser];
    NSDictionary *updic = @{@"searchType":@"1",
                            @"companyId":user.defutecompanyId,
                            @"pageNo":@"1",
                            @"pageSize":@"5000"
                            };
    [[HttpClient sharedHttpClient] requestGET:@"/warehouse" Withdict:updic WithReturnBlock:^(id returnValue) {
        NSLog(@"%@",returnValue);
        NSMutableArray *daraarr = [Warehouses mj_objectArrayWithKeyValuesArray:returnValue[@"warehouses"]];
        if (daraarr.count<=0) {
            [HUD show:@"未获取到仓库"];
            return ;
        }
        self.wareView.dataArr = daraarr;
        [self.wareView showInView];
        
    } andErrorBlock:^(NSString *msg) {
        
    }];
}
#pragma mark ====  获取样品间基础设置
- (void)getComSetting{
    User *user = [[UserPL shareManager] getLoginUser];
    [[HttpClient sharedHttpClient] requestGET:[NSString stringWithFormat:@"/companys/%@/settings",user.defutecompanyId] Withdict:nil WithReturnBlock:^(id returnValue) {
        NSString *str = returnValue[@"sellInventoryReduce"];
        if (!str) {
            return ;
        }
        if ([str intValue]==1) {
            //扣减
            [self.CustomerView wareBtnIsshow:YES];
        }else{
            //不扣减
            [self.CustomerView wareBtnIsshow:NO];

        }
    } andErrorBlock:^(NSString *msg) {
    }];
}

#pragma mark ====== 挂单
- (void)putOrders{
    
    if (_model.comId.length<=0) {
        [HUD show:@"请选择客户"];
        return;
    }
    if (_model.sampleList.count<=0) {
        [HUD show:@"请选择货品"];
        return;
    }
    for (int i = 0; i<_model.sampleList.count; i++) {
        SaleSamModel *goodModel = _model.sampleList[i];
        if (goodModel.color.length<=0) {
            [HUD show:@"请输入货品颜色"];
            return;
        }
        if (goodModel.unitPrice.length<=0) {
            [HUD show:@"请输入货品单价"];
            return;
        }
        if (goodModel.money.length<=0) {
            [HUD show:@"请输入货品金额"];
            return;
        }
        if (goodModel.packingList.count<=0) {
            //手动填写匹数、m销货量
            if (goodModel.pieces.length<=0) {
                [HUD show:@"请输入货品匹数"];
                return;
            }
            if (goodModel.salesVol.length<=0) {
                [HUD show:@"请输入货品销货量"];
                return;
            }
        }else{
            //细码单填写
        }
    }
    
    User *user = [[UserPL shareManager] getLoginUser];
    NSMutableDictionary *setDic= [[NSMutableDictionary alloc]init];
    //公司ID*
    [setDic setObject:user.defutecompanyId forKey:@"companyId"];
    //销售单ID
    if (_settleModel.sellOrderId.length>0) {
        [setDic setObject:_settleModel.sellOrderId forKey:@"sellOrderId"];

    }
    //发货日期*
    NSDateFormatter *format1=[[NSDateFormatter alloc] init];
    [format1 setDateFormat:@"yyyy-MM-dd"];
    NSString *dateStr;
    NSDate *date=[NSDate date];
    dateStr=[format1 stringFromDate:date];
    [setDic setObject:dateStr forKey:@"deliverDate"];
    //客户ID
    [setDic setObject:_model.comId forKey:@"customerId"];
    //订单类型【0:剪样 1:大货】
    [setDic setObject:_model.type?_model.type:@"1" forKey:@"type"];
    //结算状态【0：挂单 1：结算】
    [setDic setObject:@"0" forKey:@"settleStatus"];
    //仓库ID*
    [setDic setObject:@"" forKey:@"warehouseId"];
    //销售员ID
    [setDic setObject:_settleModel.sellerId forKey:@"sellerId"];
    
    NSMutableArray *details = [NSMutableArray arrayWithCapacity:0];
    NSMutableArray *packingListDetail = [NSMutableArray arrayWithCapacity:0];
    for (int i = 0; i<_model.sampleList.count; i++)
    {
        SaleSamModel *samodel = _model.sampleList[i];
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
        [samDic setObject:samodel.salesVol?samodel.salesVol:[NSString stringWithFormat:@"%.2f",_settleModel.meetNum] forKey:@"num"];
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
            [packDic setObject:@{@"label":@"日期",@"value":@""} forKey:@"infoBR"];
            [packDic setObject:@{@"label":@"",@"value":@""} forKey:@"infoBBL"];
            [packDic setObject:@{@"label":@"",@"value":@""} forKey:@"infoBBR"];
            NSMutableArray *colThArr = [NSMutableArray arrayWithCapacity:0];
            int a = 0;
            int b = 0;
            CGFloat meeta = 0.00;
            CGFloat meetb = 0.00;
            for (int j= 0; j<samodel.packingList.count; j++) {
                PackListModel *pacModel = samodel.packingList[j];
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
            
            NSMutableArray *twoArr = [self splitArray:samodel.packingList withSubSize:2];
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
        [HUD show:@"挂单成功"];
        [self reloadtheList];
    } andErrorBlock:^(NSString *msg) {
        [HUD show:@"挂单"];
    }];
}
#pragma mark ====== 获取取单
- (void)loadOrderListandisShowView:(BOOL)isSHow{
    User *user = [[UserPL shareManager] getLoginUser];
    NSDictionary *dic = @{@"companyId":user.defutecompanyId,
                          @"settleStatus":@"0"
                          };
    [[HttpClient sharedHttpClient] requestGET:@"/sell/deliver" Withdict:dic WithReturnBlock:^(id returnValue) {
        NSLog(@"%@",returnValue);
        NSMutableArray *arr = [SellOrderDeliver mj_objectArrayWithKeyValuesArray:returnValue[@"sellOrderDelivers"]];
        [self.HeaderView setgetBtnNumber:arr.count];
        if (isSHow) {
            //显示
            if (arr.count<=0) {
                [HUD show:@"暂无订单"];
                return ;
            }
            self.delView.dataArr = arr;
            [self.delView showInView];
        }
       //获取详情
        WeakSelf(self);
        self.delView.returnBlock = ^(NSString * _Nonnull orderID) {
            [weakself loadOrderDetailWithOrderId:orderID];
        };
        
    } andErrorBlock:^(NSString *msg) {
        NSLog(@"%@",msg);
    }];
}

#pragma mark ====== 获取销货单详情
- (void)loadOrderDetailWithOrderId:(NSString *)orderID{
    [[HttpClient sharedHttpClient] requestGET:[NSString stringWithFormat:@"/sell/%@/deliver",orderID] Withdict:nil WithReturnBlock:^(id returnValue) {
        NSLog(@"%@",returnValue);
       SellOrderDeliverDetail *detailModel = [SellOrderDeliverDetail mj_objectWithKeyValues:returnValue];
        if (!detailModel) {
            [HUD show:@"详情获取失败"];
            return;
        }
        [self initDatasWithdetailModel:detailModel];
        [self deleteOrderWithOrderId:orderID];
    } andErrorBlock:^(NSString *msg) {
        
    }];
}

#pragma mark ====== 删除销货单
- (void)deleteOrderWithOrderId:(NSString *)orderID{
    [[HttpClient sharedHttpClient] requestDeleteWithURLStr:[NSString stringWithFormat:@"/sell/%@/deliver",orderID] paramDic:nil WithReturnBlock:^(id returnValue) {
        [self loadOrderListandisShowView:NO];
    } andErrorBlock:^(NSString *msg) {
        
    }];
}

#pragma mark ====== initDatasWithdetailModel
- (void)initDatasWithdetailModel:(SellOrderDeliverDetail *)detailModel{
    [self reloadtheList];
    [_model getDataWithSellOrderDeliverDetail:detailModel];
    _settleModel.sellerId = detailModel.sellerId;
    _settleModel.sellerName = detailModel.sellerName;
    _settleModel.comName = detailModel.customerName;
    _settleModel.comId = detailModel.customerId;
    _settleModel.sellOrderId = detailModel.deliverId;
    //刷新列表数据
    [self reloadDatasList];
    
}
#pragma mark ====== 重置数据

- (void)reloadtheList{
    [_dataArr removeAllObjects];
    _model = [[SaleVcModel alloc]init];
    _settleModel = [[SettleVcModel alloc]init];
    [self.CustomerView.customerBtn setTitle:@"选择客户" forState:UIControlStateNormal];
    [self.ListTab reloadData];
}

#pragma mark ====== tableview

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _model.sampleList.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellid = @"GoodsListCell";
    SaleListCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (!cell) {
        cell = [[SaleListCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
    }
    cell.model =  _model.sampleList[indexPath.row];
    cell.returnBlock = ^(SaleSamModel * _Nonnull model, NSInteger type) {
      //添加细码单，删除该条书记
        if (type==0) {
            //删除
            if ([_model.sampleList containsObject:model]) {
                [_model.sampleList removeObject:model];
                [self reloadDatasList];
            }
        }else if (type==1){
            //添加细码单
            self.packingListView.saleSamModel = model;
            [self.packingListView showView];
        }
        else{
         //输入完成
            [self reloadDatasList];
        }
    };
    return cell;
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

#pragma mark ====== get
-(BaseTableView *)ListTab{
    if (!_ListTab) {
        _ListTab = [[BaseTableView alloc] initWithFrame:CGRectMake(0, 154, 704, ScreenHeight-154) style:UITableViewStylePlain];
        _ListTab.delegate = self;
        _ListTab.dataSource = self;
        _ListTab.backgroundColor = UIColorFromRGB(BackColorValue);
        _ListTab.separatorStyle = UITableViewCellSeparatorStyleNone;
        if (@available(iOS 11.0, *)) {
            _ListTab.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {
        }
    }
    return _ListTab;
}


/**
 右侧键盘
 */
-(DIYSearchKeyBoardView *)KeyBoardView{
    
    if (!_KeyBoardView) {
        _KeyBoardView = [[DIYSearchKeyBoardView alloc]initWithFrame:CGRectMake(ScreenWidth-100-220, 114, 220, 450)];
    }
    return _KeyBoardView;
}

-(SaleHeaderView *)HeaderView{
    if (!_HeaderView) {
        _HeaderView = [[SaleHeaderView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth-100, 64)];
    }
    return _HeaderView;
}


-(SaleCustomerView *)CustomerView{
    if (!_CustomerView) {
        _CustomerView = [[SaleCustomerView alloc]initWithFrame:CGRectMake(0, 64, ScreenWidth-100, 50)];
    }
    
    return _CustomerView;
}

-(CustomerSelecteView *)customerSelecteView{
    if (!_customerSelecteView) {
        _customerSelecteView = [[CustomerSelecteView alloc]init];
    }
    return _customerSelecteView;
}

-(SampleSearchResultView *)sampleSearchResultView{
    if (!_sampleSearchResultView) {
        _sampleSearchResultView = [[SampleSearchResultView alloc]init];
    }
    return _sampleSearchResultView;
}

-(PackingListView *)packingListView{
    if (!_packingListView) {
        _packingListView = [[PackingListView alloc]init];
    }
    return _packingListView;
}

-(GetDelView *)delView{
    
    if (!_delView) {
        _delView = [[GetDelView alloc]init];
    }
    return _delView;
}

-(TypeChoseView *)typeView{
    if (!_typeView) {
        _typeView = [[TypeChoseView alloc]init];
    }
    
    return _typeView;
}

-(WarehouseView *)wareView{
    if (!_wareView) {
        _wareView = [[WarehouseView alloc]init];
    }
    return _wareView;
}

@end
