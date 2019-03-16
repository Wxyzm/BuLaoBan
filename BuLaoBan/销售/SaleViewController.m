//
//  SaleViewController.m
//  BuLaoBan
//
//  Created by apple on 2019/1/28.
//  Copyright © 2019年 XX. All rights reserved.
//

#import "SaleViewController.h"
//UI
#import "DIYSearchKeyBoardView.h"
#import "SaleHeaderView.h"
#import "SaleCustomerView.h"
#import "SaleListTopView.h"
#import "SaleListCell.h"

#import "SettlementViewController.h"  //结算
#import "SaleHistoryController.h"     //销售历史
//客户选择
#import "ComCustomer.h"
#import "CustomerSelecteView.h"
//样品选择
#import "SamplePL.h"
#import "SampleSearchResultView.h"

//首页数据model
#import "SaleVcModel.h"
#import "SaleSamModel.h"
#import "PackingListView.h"//细码单填写View
#import "PackListModel.h"  //细码单
#import "SettleVcModel.h"  //结算页面model

@interface SaleViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) BaseTableView *ListTab;               //列表
@property (nonatomic, strong) SaleHeaderView *HeaderView;           //顶部View
@property (nonatomic, strong) DIYSearchKeyBoardView *KeyBoardView;  //键盘
@property (nonatomic, strong) SaleCustomerView *CustomerView;       //客户、类型、仓库
@property (nonatomic, strong) CustomerSelecteView *customerSelecteView;       //客户选择
@property (nonatomic, strong) SampleSearchResultView *sampleSearchResultView; //样品选择
@property (nonatomic, strong) PackingListView *packingListView;     //细码单填写

@property (nonatomic, strong) UILabel *numLab;                      //数量
@property (nonatomic, strong) UILabel *moneyLab;                    //金额

@property (nonatomic, strong) SaleVcModel *model;                   //首页数据保存Model
@property (nonatomic, strong) SettleVcModel *settleModel;           //结算model

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
    [self initDatas];
    [self initUI];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
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
        [weakself.CustomerView.customerBtn setTitle:comCusModel.name forState:UIControlStateNormal];
    };
    //商品搜索
    weakself.KeyBoardView.returnBlock = ^(NSString * _Nonnull searchTxt) {
        _SearchStr = searchTxt;
        [weakself loadGoodsList];
    };
    //选择商品
    weakself.sampleSearchResultView.returnBlock = ^(Sample * _Nonnull SampleModel) {
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
        [self.navigationController pushViewController:hisVc animated:YES];
        
    }else if (tag == 1)
    {
        //销售统计
        
    }else if (tag == 2)
    {
        //挂单
        
    }else if (tag == 3)
    {
        //取单
        
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
        
    }else if (tag == 2)
    {
        //扫码
        
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

@end
