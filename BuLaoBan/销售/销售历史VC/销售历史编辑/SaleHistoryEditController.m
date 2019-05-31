//
//  SaleHistoryEditController.m
//  BuLaoBan
//
//  Created by souxiuyun on 2019/5/27.
//  Copyright © 2019 XX. All rights reserved.
//

#import "SaleHistoryEditController.h"
#import "TypeChoseView.h"           //大货剪样
#import "DIYSearchKeyBoardView.h"   //右侧键盘
#import "SaleCustomerView.h"        //顶部选择

#import "CustomerSelecteView.h"     //选择客户弹窗
#import "SampleSearchResultView.h"  //货品搜索结果
#import "PackingListView.h"         //填写细码单
#import "SaleListTopView.h"         //tableview顶部显示
#import "SellOrderDeliverDetail.h"

#import "SaleListCell.h"
#import "SaleSamModel.h"
#import "SaleHisSettleController.h"
#import "SamplePL.h"

@interface SaleHistoryEditController ()<UITableViewDelegate,UITableViewDataSource>


@property (nonatomic, strong) BaseTableView *ListTab;               //列表
@property (nonatomic, strong) SaleCustomerView *CustomerView;       //客户、类型、仓库
@property (nonatomic, strong) DIYSearchKeyBoardView *KeyBoardView;  //键盘

@property (nonatomic, strong) UILabel *numLab;                      //数量
@property (nonatomic, strong) UILabel *moneyLab;                    //金额
@property (nonatomic, strong) UIView *StatisticsView;               //右侧统计

//弹窗
@property (nonatomic, strong) CustomerSelecteView *customerSelecteView;   //客户选择
@property (nonatomic, strong) SampleSearchResultView *sampleSearchResultView; //样品选择
@property (nonatomic, strong) PackingListView *packingListView;     //细码单填写
@property (nonatomic, strong) TypeChoseView *typeView;              //剪样大货


@end

@implementation SaleHistoryEditController{
    NSString *_SearchStr;        //搜索关键字
    NSMutableArray *_dataArr;    //显示数据
    NSMutableArray *_SearchArr;  //搜索出的数据
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"编辑销售单";
    [self setBarBackBtnWithImage:nil];
    [self initDatas];
    [self initUI];
    
}

- (void)initDatas{
    [_dataModel getsampleListWithSellOrderDeliverDetail];
     _SearchStr = @"";
    _dataArr = [NSMutableArray arrayWithCapacity:0];
  
}


- (void)initUI{
    //客户选择
    [self.view addSubview:self.CustomerView];
    [self.CustomerView.customerBtn setTitle:_dataModel.customerName forState:UIControlStateNormal];
    [self.CustomerView.kindBtn setTitle:[_dataModel.type intValue]==0?@"剪样":@"大货"  forState:UIControlStateNormal];

    //自定义键盘
    [self.view addSubview:self.KeyBoardView];
    //列表顶部view
    SaleListTopView *topView = [[SaleListTopView alloc]initWithFrame:CGRectMake(0, 50, 704, 40)];
    [self.view addSubview:topView];
    //列表
    [self.view addSubview:self.ListTab];
    //右侧统计
    [self.view addSubview:self.StatisticsView];
    [self reloadDatasList];
    
    ////block
    WeakSelf(self);
    
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
        [weakself.dataModel.sampleList addObject:samodel];
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
#pragma mark ====== tableview

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataModel.sampleList.count;
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
    cell.model =  _dataModel.sampleList[indexPath.row];
    cell.returnBlock = ^(SaleSamModel * _Nonnull model, NSInteger type) {
        //添加细码单，删除该条书记
        if (type==0) {
            //删除
            if ([_dataModel.sampleList containsObject:model]) {
                [_dataModel.sampleList removeObject:model];
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


/**
 刷新列表数据
 */
- (void)reloadDatasList{
    [self .ListTab reloadData];
    //总米数
    CGFloat meet = 0.00;
    for (SaleSamModel *model in _dataModel.sampleList) {
        if ([model.salesVol floatValue]>0) {
            meet += [model.salesVol floatValue];
        }else if (model.MeetTotal>0){
            meet += model.MeetTotal;
        }
    }
    //总匹数
    NSInteger pieces = 0;
    for (SaleSamModel *model in _dataModel.sampleList) {
        if ([model.pieces integerValue]>0) {
            pieces += [model.pieces integerValue];
        }else if (model.piecesTotal>0){
            pieces += model.piecesTotal;
        }
    }
    _numLab.text = [NSString stringWithFormat:@"%ld款, %ld匹, %.2f米",_dataModel.sampleList.count,pieces,meet];
  
    //总金额
    CGFloat money = 0.00;
    for (SaleSamModel *model in _dataModel.sampleList) {
        money += [model.money floatValue];
    }
    _moneyLab.text = [NSString stringWithFormat:@"￥ %.2f",money];
    _dataModel.meet = meet;
    _dataModel.pieces = pieces;
    _dataModel.totMoney = money;
}

- (void)setBtnClick{
    
    if (_dataModel.sampleList.count<=0) {
        [HUD show:@"请选择货品"];
        return;
    }
    for (int i = 0; i<_dataModel.sampleList.count; i++) {
        SaleSamModel *goodModel = _dataModel.sampleList[i];
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
    
    SaleHisSettleController *seVc = [[SaleHisSettleController alloc]init];
    seVc.dataModel = _dataModel;
    [self.navigationController pushViewController:seVc animated:YES];
    
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
        self.sampleSearchResultView.frame = CGRectMake(0, 50, ScreenWidth-100-220 , ScreenHeight-50);

    } andErrorBlock:^(NSString *msg) {
    }];
}

#pragma mark ====== get

-(BaseTableView *)ListTab{
    if (!_ListTab) {
        _ListTab = [[BaseTableView alloc] initWithFrame:CGRectMake(0, 90, 704, ScreenHeight-90) style:UITableViewStylePlain];
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
        _KeyBoardView = [[DIYSearchKeyBoardView alloc]initWithFrame:CGRectMake(ScreenWidth-100-220, 50, 220, 450)];
    }
    return _KeyBoardView;
}

-(SaleCustomerView *)CustomerView{
    if (!_CustomerView) {
        _CustomerView = [[SaleCustomerView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth-100, 50)];
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

-(TypeChoseView *)typeView{
    if (!_typeView) {
        _typeView = [[TypeChoseView alloc]init];
    }
    
    return _typeView;
}

-(UIView *)StatisticsView{
    if (!_StatisticsView) {
        _StatisticsView = [BaseViewFactory viewWithFrame:CGRectMake(ScreenWidth-100-220, 500, 220, ScreenHeight-500) color:UIColorFromRGB(WhiteColorValue)];
        UILabel *numlab = [BaseViewFactory labelWithFrame:CGRectMake(10, 0, 50, 50) textColor:UIColorFromRGB(BlackColorValue) font:APPFONT14 textAligment:NSTextAlignmentLeft andtext:@"数量"];
        [_StatisticsView addSubview:numlab];
        _numLab  = [BaseViewFactory labelWithFrame:CGRectMake(50, 0, 160, 50) textColor:UIColorFromRGB(BlueColorValue) font:APPFONT14 textAligment:NSTextAlignmentRight andtext:@"0款, 0匹, 0.00米"];
        [_StatisticsView addSubview:_numLab];
        UIView *line = [BaseViewFactory viewWithFrame:CGRectMake(10, 49, 200, 1) color:UIColorFromRGB(LineColorValue)];
        [_StatisticsView addSubview:line];
        
        UILabel *moneylab = [BaseViewFactory labelWithFrame:CGRectMake(10, 50, 50, 50) textColor:UIColorFromRGB(BlackColorValue) font:APPFONT14 textAligment:NSTextAlignmentLeft andtext:@"金额"];
        [_StatisticsView addSubview:moneylab];
        _moneyLab  = [BaseViewFactory labelWithFrame:CGRectMake(50, 50, 160, 50) textColor:UIColorFromRGB(RedColorValue) font:APPFONT14 textAligment:NSTextAlignmentRight andtext:@"0.00"];
        [_StatisticsView addSubview:_moneyLab];
        UIView *line1 = [BaseViewFactory viewWithFrame:CGRectMake(10, 99, 200, 1) color:UIColorFromRGB(LineColorValue)];
        [_StatisticsView addSubview:line1];
        
        UIButton *setBtn = [BaseViewFactory ylButtonWithFrame:CGRectMake(10, 125, 200, 50) font:APPFONT16 title:@"结算" titleColor:UIColorFromRGB(WhiteColorValue) backColor:UIColorFromRGB(BlueColorValue)];
        [_StatisticsView addSubview:setBtn];
        setBtn.layer.cornerRadius = 2;
        [setBtn addTarget:self action:@selector(setBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _StatisticsView;
    
}

@end
