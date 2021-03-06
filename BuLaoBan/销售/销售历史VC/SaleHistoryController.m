//
//  SaleHistoryController.m
//  BuLaoBan
//
//  Created by apple on 2019/2/27.
//  Copyright © 2019年 XX. All rights reserved.
//

#import "SaleHistoryController.h"
#import "SaleHistHeader.h"
#import "ReceiveBaseView.h"      //收款
#import "RightMenueView.h"      //收款
#import "SaleHistoryEditController.h"

@interface SaleHistoryController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) BaseTableView *ListTab;               //左侧列表

@property (nonatomic, strong) SaleDetailView *detailView;            //详情

@property (nonatomic, strong) SaleHistorySearchView *searchView;     //搜索

/**
 编辑菜单
 */
@property (nonatomic, strong) RightMenueView*menueView;

@property (nonatomic, strong) SellOrderDeliverDetail *detailModel;     //model
@end

@implementation SaleHistoryController{
    
    NSMutableArray *_dataArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.needHideNavBar = YES;
    [self initDatas];
    [self initUI];
    [self getSellList];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadList) name:@"HistoryChanged" object:nil];

}


- (void)initDatas{
    self.loadWay = START_LOAD_FIRST;
    _dataArr =[NSMutableArray arrayWithCapacity:0];
    self.page = 1;
}

#pragma mark ======UI
- (void)initUI{
    //顶部
    [self initTopView];
    //左侧列表
    [self.view addSubview:self.ListTab];
     //右侧详情
    [self.view addSubview:self.detailView];
    UIView *line = [BaseViewFactory viewWithFrame:CGRectMake(300, 0, 1, ScreenHeight) color:UIColorFromRGB(LineColorValue)];
    [self.view addSubview:line];
    
    //编辑
    [self.view addSubview:self.menueView];
}

#pragma mark ======顶部UI

- (void)initTopView{
    
    UIView *view = [BaseViewFactory viewWithFrame:CGRectMake(0, 0, ScreenWidth-100, 64) color:UIColorFromRGB(WhiteColorValue)];
    [self.view addSubview:view];
    UIImage *backImg= [UIImage imageNamed:@"back-d"];
    CGFloat height = 17;
    CGFloat width = height * backImg.size.width / backImg.size.height;
    YLButton* button = [[YLButton alloc] initWithFrame:CGRectMake(18, 20, 30, 44)];
    [button setImage:backImg forState:UIControlStateNormal];
    [button addTarget:self action:@selector(respondToLeftButtonClickEvent) forControlEvents:UIControlEventTouchUpInside];
    [button setImageRect:CGRectMake(0, 13.5, width, height)];
    [view addSubview:button];
    UILabel *titleLab = [BaseViewFactory labelWithFrame:CGRectMake(300, 20, ScreenWidth-400, 44) textColor:UIColorFromRGB(BlackColorValue) font:APPFONT(20) textAligment:NSTextAlignmentCenter andtext:@"单据详情"];
    [view addSubview:titleLab];
  //  NSArray *titleArr = @[@"···",@"分享",@"打印",@"收款"];
    NSArray *titleArr = @[@"···"];

    for (int i = 0; i<titleArr.count; i++) {
        UIButton *btn = [BaseViewFactory buttonWithFrame:CGRectMake(ScreenWidth-158-44*i, 20, 48, 44) font:APPFONT14 title:titleArr[i] titleColor:UIColorFromRGB(BlueColorValue) backColor:UIColorFromRGB(WhiteColorValue)];
        [view addSubview:btn];
        btn.tag = 1000 +i;
        [btn addTarget:self action:@selector(topBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    UIView *line = [BaseViewFactory viewWithFrame:CGRectMake(0, 63, ScreenWidth-100, 1) color:UIColorFromRGB(LineColorValue)];
    [self.view addSubview:line];
}


#pragma mark ======顶部按钮点击

/**
 顶部按钮点击

 */
- (void)topBtnClick:(UIButton *)topBtn{
    
    switch (topBtn.tag - 1000) {
        case 0:{
            //弹出编辑删除
            [self orderChange];
            break;
        }
        case 1:{
            //分享
            break;
        }
        case 2:{
            //打印
            break;
        }
        case 3:{
            //收款
            break;
        }
        default:
            break;
    }
    
}


//编辑
- (void)orderChange{
    WeakSelf(self);
    if (self.detailModel.deliverId.length<=0) {
        [HUD show:@"获取销货单详情失败"];
        return;
    }
    [self.view bringSubviewToFront:self.menueView];
    self.menueView.hidden = NO;
    self.menueView.returnBlock = ^(NSInteger index) {
        switch (index) {
            case 0:{
                SaleHistoryEditController *edvc = [[SaleHistoryEditController alloc]init];
                edvc.dataModel = weakself.detailModel;
                [weakself.navigationController pushViewController:edvc animated:YES];
//                if (weakself.returnBlock) {
//                    weakself.returnBlock(weakself.detailModel);
//                }
//                [weakself.navigationController popViewControllerAnimated:YES];
                break;
            }
            case 1:{
                
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"确定删除该记录么？" preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                    [weakself deleteCurrentOrder];
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

- (void)deleteCurrentOrder{
    SellOrderDeliver *onmodel;
    for (SellOrderDeliver *model in _dataArr) {
        if (model.selected == YES) {
            onmodel = model;
        }
    }
    if (!onmodel) {
        return;
    }
    [[HttpClient sharedHttpClient] requestDeleteWithURLStr:[NSString stringWithFormat:@"/sell/%@/deliver",onmodel.deliverId] paramDic:nil WithReturnBlock:^(id returnValue) {
        [HUD show:@"删除成功"];
        [self reloadList];
        
    } andErrorBlock:^(NSString *msg) {
        
    }];
    
    
    
}


#pragma mark ====== 获取销货单列表
- (void)getSellList{
    User *user = [[UserPL shareManager] getLoginUser];
    NSDictionary *dic= @{@"pageNo":[NSString stringWithFormat:@"%ld",(long)self.page],
                         @"pageSize":@"2000",
                         @"settleStatus":@"1",
                         @"companyId":user.defutecompanyId
                         };
    [[HttpClient sharedHttpClient] requestGET:@"/sell/deliver" Withdict:dic WithReturnBlock:^(id returnValue) {
        NSArray *arr = [SellOrderDeliver mj_objectArrayWithKeyValuesArray:returnValue[@"sellOrderDelivers"]];
        [self loadSuccessWithArr:arr];
        [self endRefresh];
    } andErrorBlock:^(NSString *msg) {
        [self endRefresh];
    }];
}
- (void)loadSuccessWithArr:(NSArray *)arr{
    [self setPageCount];
    if (self.loadWay == START_LOAD_FIRST || self.loadWay == RELOAD_DADTAS) {
        [_dataArr  removeAllObjects];
        if (arr.count>0) {
            SellOrderDeliver *mdoel = arr[0];
            mdoel.selected = YES;
            //获取详情
            [self loaddeliverDetailWithID:mdoel.deliverId];
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

- (void)endRefresh{
    [self.ListTab.mj_header endRefreshing];
    [self.ListTab.mj_footer endRefreshing];
}
#pragma mark ==== 上拉加载下拉刷新

- (void)reloadList{
    self.page =1;
    self.loadWay = RELOAD_DADTAS;
    [self getSellList];
}

- (void)loadMoreDatas{
    self.loadWay = LOAD_MORE_DATAS;
    self.page +=1;
    [self getSellList];
}
#pragma mark ====== 获取销货单详情
- (void)loaddeliverDetailWithID:(NSString *)deliverId{
    [[HttpClient sharedHttpClient] requestGET:[NSString stringWithFormat:@"/sell/%@/deliver",deliverId] Withdict:nil WithReturnBlock:^(id returnValue) {
        _detailModel = [SellOrderDeliverDetail mj_objectWithKeyValues:returnValue];
        _detailView.model = _detailModel;
        NSLog(@"%@",_detailModel);
    } andErrorBlock:^(NSString *msg) {
        
    }];
}


#pragma mark ====== tableview
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 104;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return self.searchView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellid = @"hiscell";
    SaleHisListCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (!cell) {
        cell = [[SaleHisListCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
    }
    cell.model = _dataArr[indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    for (SellOrderDeliver *model in _dataArr) {
        model.selected = NO;
    }
    SellOrderDeliver *semodel = _dataArr[indexPath.row];
    semodel.selected = YES;
    [self.ListTab reloadData];
    [self loaddeliverDetailWithID:semodel.deliverId];
}

#pragma mark ====== get

-(BaseTableView *)ListTab{
    if (!_ListTab) {
        _ListTab = [[BaseTableView alloc] initWithFrame:CGRectMake(0, 64, 300, ScreenHeight-64) style:UITableViewStylePlain];
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

-(SaleDetailView *)detailView{
    if (!_detailView) {
        _detailView = [[SaleDetailView alloc]initWithFrame:CGRectMake(300, 64, ScreenWidth-400, ScreenHeight-64)];
    }
    return _detailView;
}

-(SaleHistorySearchView *)searchView{
    if (!_searchView) {
        _searchView = [[SaleHistorySearchView alloc]initWithFrame:CGRectMake(0, 0, 300, 104)];
    }
    return _searchView;
}
-(RightMenueView *)menueView{
    
    if (!_menueView) {
        NSArray *titleArr = @[@"编辑",@"删除"];
        _menueView = [[RightMenueView alloc]initWithTitleArr:titleArr];
    }
    return _menueView;
}
@end
