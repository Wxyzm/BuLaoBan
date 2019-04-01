//
//  GoodsViewController.m
//  BuLaoBan
//
//  Created by apple on 2019/1/28.
//  Copyright © 2019年 XX. All rights reserved.
//

#import "GoodsViewController.h"
#import "RightMenueView.h" //右侧菜单

#import "TopSearchView.h" //高级搜索

#import "AddGoodsHomeView.h" //新增首页
#import "GoodsSearchView.h"  //搜索
#import "GoodsDetailView.h"  //详情
#import "GoodsListCell.h"    //列表cell
#import "SamplePL.h"
#import "SampleDetail.h"
@interface GoodsViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) GoodsDetailView *detailView;
@property (nonatomic, strong) BaseTableView *ListTab;
/**
 新增V属性填写View
 */
@property (nonatomic, strong) AddGoodsHomeView *addView;

/**
 编辑菜单
 */
@property (nonatomic, strong) RightMenueView*menueView;

@property (nonatomic, strong)TopSearchView *searchView;
@end

@implementation GoodsViewController{
    
    NSMutableArray *_dataArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.needHideNavBar = YES;
    _dataArr = [NSMutableArray arrayWithCapacity:0];
    self.page = 1;
    [self initUI];
    self.loadWay = START_LOAD_FIRST;
    [self loadgoodsList];
    //刷新
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshdetail:)
                                                 name:@"refreshDetail" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshList:)
                                                 name:@"refreshList" object:nil];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}



- (void)initUI{
    
    //顶部View
    UIView *topView = [BaseViewFactory viewWithFrame:CGRectMake(0, 0, ScreenWidth-100, 64) color:UIColorFromRGB(WhiteColorValue)];
    [self.view addSubview:topView];
    UILabel *goodsLab = [BaseViewFactory labelWithFrame:CGRectMake(16, 30, 70, 24) textColor:UIColorFromRGB(BlackColorValue) font:APPFONT17 textAligment:NSTextAlignmentCenter andtext:@"货品列表"];
    [topView addSubview:goodsLab];
    UIButton *addBtn = [BaseViewFactory buttonWithFrame:CGRectMake(226, 30, 64, 24) font:APPFONT15 title:@"新增货品" titleColor:UIColorFromRGB(BlueColorValue) backColor:UIColorFromRGB(WhiteColorValue)];
    [addBtn addTarget:self action:@selector(addNewGoodsBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:addBtn];
    UIView *line1 = [BaseViewFactory viewWithFrame:CGRectMake(0, 63, ScreenWidth-100, 1) color:UIColorFromRGB(LineColorValue)];
    [topView addSubview:line1];
  
    UILabel *goodsLab2 = [BaseViewFactory labelWithFrame:CGRectMake(300, 20, ScreenWidth-400, 44) textColor:UIColorFromRGB(BlackColorValue) font:APPFONT17 textAligment:NSTextAlignmentCenter andtext:@"货品列表"];
    [topView addSubview:goodsLab2];
    UIButton *changeBtn = [BaseViewFactory buttonWithFrame:CGRectMake(ScreenWidth-140, 20, 20, 43) font:APPFONT15 title:@"···" titleColor:UIColorFromRGB(BlueColorValue) backColor:UIColorFromRGB(WhiteColorValue)];
    [changeBtn addTarget:self action:@selector(changeBtnGoodsBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:changeBtn];
    
    //w搜索View
    GoodsSearchView *searchView = [[GoodsSearchView alloc]initWithFrame:CGRectMake(0, 64, 300, 56)];
    [self.view addSubview:searchView];
    
    [self.view addSubview:self.ListTab];
    //详情View
    _detailView = [[GoodsDetailView alloc]initWithFrame:CGRectMake(300, 64, ScreenWidth-400, ScreenHeight-64)];;
    [self.view addSubview:_detailView];
    
    UIView *line2 = [BaseViewFactory viewWithFrame:CGRectMake(300, 0, 1, ScreenHeight) color:UIColorFromRGB(LineColorValue)];
    [self.view addSubview:line2];
    
    //编辑
    [self.view addSubview:self.menueView];
    WeakSelf(self);
    //高级搜索
    searchView.returnBlock = ^(NSString * _Nonnull searchtxt) {
        [self.searchView showView];
    };
    self.searchView.returnBlock = ^(NSDictionary * _Nonnull keyDic) {
        if (keyDic) {
            [weakself topSearchLoadGoodsListWithDic:keyDic];
        }
    };
    
}

#pragma mark ==== 高级搜索获取货品列表

- (void)topSearchLoadGoodsListWithDic:(NSDictionary *)keyDic{
    User *user = [[UserPL shareManager] getLoginUser];
    self.loadWay = START_LOAD_FIRST;
    NSDictionary *dic = @{@"companyId":user.defutecompanyId,
                          @"pageSize":@"5000",
                          @"pageNo":@"1",
                          @"orderByType":@"2",
                          @"searchMap":keyDic
                          };
    [[HttpClient sharedHttpClient] requestPOST:@"/samples/search" Withdict:dic WithReturnBlock:^(id returnValue) {
        NSArray *arr = [Sample mj_objectArrayWithKeyValuesArray:returnValue[@"samples"]];
        [self loadSuccessWithArr:arr];
    } andErrorBlock:^(NSString *msg) {
        
    }];
    
    
}

#pragma mark ==== 上拉加载下拉刷新

- (void)reloadList{ 
    self.page =1;
    self.loadWay = RELOAD_DADTAS;
    
    [self loadgoodsList];
}

- (void)loadMoreDatas{
    self.loadWay = LOAD_MORE_DATAS;
    self.page +=1;
   
    [self loadgoodsList];
}
#pragma mark ==== 获取货品列表

- (void)loadgoodsList{
    User *user = [[UserPL shareManager] getLoginUser];
    NSDictionary *updic = @{@"searchType":@"0",
                            @"companyId":user.defutecompanyId,
                            @"pageNo":[NSString stringWithFormat:@"%ld",self.page],
                            @"pageSize":@"20"
                            };
    [SamplePL Sample_sampleSamplesRegisterWithDic:updic WithReturnBlock:^(id returnValue) {
        NSLog(@"%@",returnValue);
        NSArray *arr = [Sample mj_objectArrayWithKeyValuesArray:returnValue[@"samples"]];
        [self loadSuccessWithArr:arr];
        [self endRefresh];
    } andErrorBlock:^(NSString *msg) {
        [self endRefresh];
    }];
}
#pragma mark ==== 获取货品详情
- (void)loadGoodsDetailWithSampleId:(NSString *)sampleId{
    [HUD showLoading:nil];
    [SamplePL Sample_sampleSamplesDetailWithsampleId:sampleId WithReturnBlock:^(id returnValue) {
        NSLog(@"样品详情=====%@",returnValue);
        SampleDetail *deModel = [SampleDetail mj_objectWithKeyValues:returnValue[@"sample"]];
        _detailView.sampledetail = deModel;
        [HUD cancel];
    } andErrorBlock:^(NSString *msg) {
        [HUD cancel];
    }];
    
    
}


- (void)endRefresh{
    [self.ListTab.mj_header endRefreshing];
    [self.ListTab.mj_footer endRefreshing];

}

- (void)loadSuccessWithArr:(NSArray *)arr{
    [self setPageCount];
    if (self.loadWay == START_LOAD_FIRST || self.loadWay == RELOAD_DADTAS) {
        [_dataArr  removeAllObjects];
        if (arr.count>0) {
            Sample *sample = arr[0];
            sample.isSelected = YES;
            [self loadGoodsDetailWithSampleId:sample.sampleId];
        }
    }
    [_dataArr addObjectsFromArray:arr];
    [self.ListTab reloadData];
    
}
- (void)setPageCount{
    if (self.loadWay != LOAD_MORE_DATAS)
    {
        self.page = 1;
    }
    self.page++;
}

#pragma mark ==== 新增货品
- (void)addNewGoodsBtnClick{
    
    
    if (!_addView) {
        _addView = [[AddGoodsHomeView alloc]init];
    }
    _addView.isCopy = NO;
    _addView.sampleDetail =[[SampleDetail alloc] init];
    [_addView showView];
    
}

#pragma mark ==== 编辑、删除、复制货品
- (void)changeBtnGoodsBtnClick{
    WeakSelf(self);
    [self.view bringSubviewToFront:self.menueView];
    self.menueView.hidden = NO;
    self.menueView.returnBlock = ^(NSInteger index) {
        switch (index) {
            case 0:{
                [weakself editGoods];
                break;
            }
            case 1:{
                [weakself copyAndNewGoods];
                break;
            }
            case 2:{
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"确定删除该货品？" preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                    [weakself deleteGoods];
                }];
                UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"取消", nil) style:UIAlertActionStyleCancel handler:NULL];
                [alert addAction:action];
                [alert addAction:cancelAction];
                UIPopoverPresentationController *popPresenter = [alert popoverPresentationController];
                popPresenter.sourceView = weakself.view;
                popPresenter.sourceRect = weakself.view.bounds;
                [weakself presentViewController:alert animated:YES completion:nil];
                break;
            }
            default:
                break;
        }
    };

}


/**
 编辑
 */
-(void)editGoods{
        if (!_addView) {
            _addView = [[AddGoodsHomeView alloc]init];
        }
        _addView.isCopy = NO;
        _addView.sampleDetail = _detailView.sampledetail;
        [_addView showView];
    
}

/**
 删除
 */
- (void)deleteGoods{
    [[HttpClient sharedHttpClient] requestDeleteWithURLStr:[NSString stringWithFormat:@"samples/%@",_detailView.sampledetail.sampleId] paramDic:nil WithReturnBlock:^(id returnValue) {
        [self reloadList];
    } andErrorBlock:^(NSString *msg) {
        
    }];
    
}



/**
 复制新增
 */
- (void)copyAndNewGoods{
    if (!_addView) {
        _addView = [[AddGoodsHomeView alloc]init];
    }
    _addView.isCopy = YES;
    _addView.sampleDetail = _detailView.sampledetail;
    [_addView showView];
}
#pragma mark ======== 通知:


/**
 刷新详情
 @param notificaition notificaition description
 */
- (void)refreshdetail:(NSNotification*)notificaition{

    NSString *sampleID = @"";
    NSDictionary *dic = notificaition.userInfo;
    for (Sample *sample in _dataArr) {
        if (sample.isSelected) {
            sample.name = [dic objectForKey:@"name"]?[dic objectForKey:@"name"]:@"";
            sampleID = sample.sampleId;
        }
    }
    [self reloadList];
    if (sampleID.length>0) {
        [self loadGoodsDetailWithSampleId:sampleID];

    }
    
}

/**
 刷新列表

 @param notificaition notificaition description
 */
- (void)refreshList:(NSNotification*)notificaition{
    [self reloadList];
}


#pragma mark ====== tableviewdelegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 48;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *view = [BaseViewFactory viewWithFrame:CGRectMake(0, 0, 300, 48) color:UIColorFromRGB(BackColorValue)];
    UILabel *lab = [BaseViewFactory labelWithFrame:CGRectMake(12, 0, 276, 48) textColor:UIColorFromRGB(BlackColorValue) font:APPFONT13 textAligment:NSTextAlignmentLeft andtext:@"共20个货品"];
    [view addSubview:lab];
    return view;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellid = @"GoodsListCell";
    GoodsListCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (!cell) {
        cell = [[GoodsListCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
    }
    cell.sample = _dataArr[indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    for (Sample *sample in _dataArr) {
        sample.isSelected = NO;
    }
    Sample *sample = _dataArr[indexPath.row];
    sample.isSelected = YES;
    [self.ListTab reloadData];
    [self loadGoodsDetailWithSampleId:sample.sampleId];
    
}

#pragma mark ====== get

-(BaseTableView *)ListTab{
    if (!_ListTab) {
        _ListTab = [[BaseTableView alloc] initWithFrame:CGRectMake(0, 120, 300, ScreenHeight-120) style:UITableViewStylePlain];
        _ListTab.delegate = self;
        _ListTab.dataSource = self;
        _ListTab.backgroundColor = UIColorFromRGB(BackColorValue);
        _ListTab.separatorStyle = UITableViewCellSeparatorStyleNone;
        _ListTab.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(reloadList)];
        _ListTab.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreDatas)];

        if (@available(iOS 11.0, *)) {
            _ListTab.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {
        }
    }
    return _ListTab;
}

-(RightMenueView *)menueView{
    
    if (!_menueView) {
        NSArray *titleArr = @[@"编辑",@"复制新增",@"删除"];
        _menueView = [[RightMenueView alloc]initWithTitleArr:titleArr];
    }
    return _menueView;
}

-(TopSearchView *)searchView{
    if (!_searchView) {
        _searchView = [[TopSearchView alloc]init];
    }
    return _searchView;
}

@end
