//
//  ReceivableViewController.m
//  BuLaoBan
//
//  Created by apple on 2019/1/28.
//  Copyright © 2019年 XX. All rights reserved.
//

#import "ReceivableViewController.h"
#import "ReceiveMenueView.h"    //左侧菜单
#import "ReceiveSearchView.h"   //顶部查询
#import "ReceiveTopCell.h"
#import "ReceiveCell.h"
#import "BillCell.h"
#import "BillTopCellCell.h"
#import "BillCheckView.h"


//账单model
#import "ReceivableCustomers.h"
#import "ReceivableItems.h"
//货品model
#import "receivableGoods.h"
#import "ReceivableItems.h"

@interface ReceivableViewController ()<UITableViewDelegate,UITableViewDataSource>
/**
 左侧菜单
 */
@property (nonatomic, strong) ReceiveMenueView      *MenueView;
/**
 搜索
 */
@property (nonatomic, strong) ReceiveSearchView     *searchView;
@property (nonatomic, strong) BaseTableView *ListTab;               //列表
@property (nonatomic, strong) UIScrollView  *scrollView;
@property (nonatomic, strong) BillCheckView *checkView;               //列表
@end

@implementation ReceivableViewController{
    NSInteger _selectedType;  //0:应收对账单/货品 1:应收对账单/单 2:应收统计表
    NSMutableArray *_dataArr1;
    NSMutableArray *_dataArr2;
    NSMutableArray *_dataArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _selectedType = 0;
    [self setToptitle];
    [self initUI];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showReceiveMenue:) name:@"ReceivebarSelected" object:nil];
    _dataArr = [NSMutableArray arrayWithCapacity:0];
    _dataArr2 = [NSMutableArray arrayWithCapacity:0];
    _dataArr1 = [NSMutableArray arrayWithCapacity:0];
}
#pragma mark ====== initUI
- (void)initUI{
    //搜索
    [self.view addSubview:self.searchView];
    [self.view addSubview:self.checkView];
    //scrollView
    [self.view addSubview:self.scrollView];
    [self.scrollView addSubview:self.ListTab];
    //菜单
    [self.MenueView showinView:self.view];
    WeakSelf(self);
     //搜索点击
    self.searchView.returnBlock = ^(NSInteger tag) {
        
    };
     //菜单点击
    self.MenueView.returnBlock = ^(NSInteger tag) {
        _selectedType = tag;
        [weakself setToptitle];
        [weakself loadDate];
    };
}

- (void)loadDate{
    //设置顶部视图显示
    [self setTableViewTopSHow];
    
    switch (_selectedType) {
        case 0:{
             self.ListTab.frame =CGRectMake(0, 0, 1220, ScreenHeight-64-110);
             self.scrollView.contentSize = CGSizeMake(1220, 10);
            [self loadBillListFromGoods];
            break;
        }
        case 1:{
            self.ListTab.frame =CGRectMake(0, 0, 924, ScreenHeight-64-110);
            self.scrollView.contentSize = CGSizeMake(924, 10);
            [self loadBillListFromBill];
            break;
        }
        case 2:{
            
            break;
        }
        default:
            break;
    }
}

#pragma mark ====== 应收对账单/货品
- (void)loadBillListFromGoods
{
    User *user = [[UserPL shareManager] getLoginUser];
    NSDictionary *dic = @{@"companyId":user.defutecompanyId,@"key":@""};
    [[HttpClient sharedHttpClient] requestGET:@"/finance/receivable/statement/sample/customer" Withdict:dic WithReturnBlock:^(id returnValue) {
        _dataArr = [receivableGoods mj_objectArrayWithKeyValuesArray:returnValue[@"receivableCustomers"]];
        [self.ListTab reloadData];
    } andErrorBlock:^(NSString *msg) {
        
    }];
    
    
}


#pragma mark ====== 应收对账单/单
- (void)loadBillListFromBill{
    User *user = [[UserPL shareManager] getLoginUser];
    NSDictionary *dic = @{@"companyId":user.defutecompanyId,@"key":@""};
    [[HttpClient sharedHttpClient] requestGET:@"finance/receivable/statement/order/customer" Withdict:dic WithReturnBlock:^(id returnValue) {
        _dataArr1 = [ReceivableCustomers mj_objectArrayWithKeyValuesArray:returnValue[@"receivableCustomers"]];
        [self.ListTab reloadData];
    } andErrorBlock:^(NSString *msg) {
        
    }];

}

//设置titlelab
- (void)setToptitle{
    NSArray *titleArr = @[@"应收对账单/货品",@"应收对账单/单",@"应收统计表"];
    self.title = titleArr[_selectedType];
}

//设置顶部视图显示
- (void)setTableViewTopSHow{
    switch (_selectedType) {
        case 0:{
            
            break;
        }
        case 1:{
            break;
        }
        case 2:{
            
            break;
        }
        default:
            break;
    }
    
}
//通知xianshiMenue
- (void)showReceiveMenue:(NSNotification *)notificaiton
{
    [self.MenueView showinView:self.view];
}

#pragma mark ====== tableview

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (_selectedType ==0) {
        return _dataArr.count;
    }else if (_selectedType ==1){
        return _dataArr1.count;
    }else if (_selectedType ==2){
        return 1;
    }
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (_selectedType ==1||_selectedType ==0){
        if (section ==0) {
            return 0.001;
        }
        return 12;
    }
    return 0.001;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (_selectedType ==1||_selectedType ==0){
        if (section !=0) {
            return [BaseViewFactory viewWithFrame:CGRectMake(0, 0, ScreenWidth-100, 12) color:UIColorFromRGB(BackColorValue)];
        }
    }
    return [UIView new];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (_selectedType == 1) {
        //应收对账单/单
        ReceivableCustomers *model = _dataArr1[section];
        return model.items.count + 1;
    }else if (_selectedType ==0){
        receivableGoods *model = _dataArr[section];
        return model.items.count + 1;
    }
    return 5 +2;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
     return 40;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (_selectedType == 1) {
        //应收对账单/单
        if (indexPath.row ==0) {
            static NSString *topcellid = @"BillTopCellCell";
            BillTopCellCell *cell = [tableView dequeueReusableCellWithIdentifier:topcellid];
            if (!cell) {
                cell = [[BillTopCellCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:topcellid];
            }
            return cell;
        }
        BillCell *cell = (BillCell *)[tableView dequeueReusableCellWithIdentifier:@"billCellId"];
        if (cell == nil) {
            cell= (BillCell *)[[[NSBundle  mainBundle]  loadNibNamed:@"BillCell" owner:self options:nil]  lastObject];
        }
        ReceivableCustomers *model = _dataArr1[indexPath.section];
        cell.Items = model.items[indexPath.row-1];
        return cell;
    }
    
    
    if (indexPath.row ==0) {
        static NSString *topcellid = @"topcellid";
        ReceiveTopCell *cell = [tableView dequeueReusableCellWithIdentifier:topcellid];
        if (!cell) {
            cell = [[ReceiveTopCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:topcellid];
        }
        return cell;
    }
    static NSString *cellid = @"cellid";
    ReceiveCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (!cell) {
        cell = [[ReceiveCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
    }
    receivableGoods *model = _dataArr[indexPath.section];
    cell.Items = model.items[indexPath.row-1];
    return cell;
}

#pragma mark ====== get
-(ReceiveMenueView *)MenueView{
    if (!_MenueView) {
        _MenueView = [[ReceiveMenueView alloc]init];
    }
    return _MenueView;
}

-(ReceiveSearchView *)searchView{
    if (!_searchView) {
        _searchView = [[ReceiveSearchView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth-100, 50)];
    }
    return _searchView;
    
}

-(UIScrollView *)scrollView{
    if (!_scrollView ) {
        _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 110, ScreenWidth, ScreenHeight-64 - 110)];
        _scrollView.bounces = NO;
        _scrollView.contentSize = CGSizeMake(1220, 10);
    }
    return _scrollView;
}

-(BaseTableView *)ListTab{
    if (!_ListTab) {
        _ListTab = [[BaseTableView alloc] initWithFrame:CGRectMake(0, 0, 1220, ScreenHeight-64-110) style:UITableViewStylePlain];
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

-(BillCheckView *)checkView{
    if (!_checkView) {
        _checkView = [[BillCheckView alloc]initWithFrame:CGRectMake(0, 50, ScreenWidth, 60)];
    }
    return _checkView;
}


@end
