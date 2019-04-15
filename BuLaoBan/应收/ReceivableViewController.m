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
#import "StastisticTopCell.h"
#import "StastisticCell.h"

#import "ReceivePL.h"

//账单model
#import "ReceivableCustomers.h"
#import "ReceivableItems.h"
//货品model
#import "receivableGoods.h"
#import "ReceivableItems.h"
#import "StasticeItem.h"
#import "DatePickerView.h"
#import "PGDatePickManager.h"
#import "PGDatePickerHeader.h"
//客户选择
#import "ComCustomer.h"
#import "CustomerSelecteView.h"



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
/**
 客户
 */
@property (nonatomic, strong) CustomerSelecteView *customerSelecteView;
@property (nonatomic, strong) DatePickerView *datepicker;

@end

@implementation ReceivableViewController{
    NSInteger _selectedType;  //0:应收对账单/货品 1:应收对账单/单 2:应收统计表
    NSString *_starTime;      //l开始时间
    NSString *_endTime;       //结束时间
    NSString *_customer;  //选择的客户
    NSMutableArray *_dataArr1;
    NSMutableArray *_dataArr2;
    NSMutableArray *_dataArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _selectedType = 0;
    [self setToptitle];
    [self initDatas];
    [self initUI];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showReceiveMenue:) name:@"ReceivebarSelected" object:nil];
  
}

- (void)initDatas{
    _dataArr = [NSMutableArray arrayWithCapacity:0];
    _dataArr2 = [NSMutableArray arrayWithCapacity:0];
    _dataArr1 = [NSMutableArray arrayWithCapacity:0];
    _starTime = @"";
    _endTime = @"";
    _customer= @"";
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
    self.searchView.returnBlock = ^(NSInteger tag,CGRect frame) {
        [weakself topBtnClickWithtag:tag andFrame:frame];
    };
     //菜单点击
    self.MenueView.returnBlock = ^(NSInteger tag) {
        _selectedType = tag;
        [weakself setToptitle];
        [weakself loadDate];
    };
    self.customerSelecteView.returnBlock = ^(ComCustomer * _Nonnull comCusModel) {
        _customer = comCusModel.name;
        [weakself.searchView setTitle:comCusModel.name withTag:2];

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
            self.ListTab.frame =CGRectMake(0, 0, 924, ScreenHeight-64-110);
            self.scrollView.contentSize = CGSizeMake(924, 10);
            [self getStatisticeListFromCustomer];
            break;
        }
        default:
            break;
    }
}
#pragma mark ====== 顶部按钮点击
-(void)topBtnClickWithtag:(NSInteger)tag andFrame:(CGRect)frame{
    if (!_datepicker) {
        _datepicker = [[DatePickerView alloc]init];
    }
    
    switch (tag) {
        case 0:{
            
            _datepicker.dateType = 1;
//            if (_starTime.length>0) {
//                [_datepicker.datePicker setDate:[self returnDateWithDateStr:_starTime] animated:YES];
//            }
            [_datepicker showViewWithFrame:frame];
            
            break;
        }
        case 1:{
            _datepicker.dateType = 2;
//            if (_endTime.length>0) {
//                [datepicker.datePicker setDate:[self returnDateWithDateStr:_endTime] animated:YES];
//            }
             [_datepicker showViewWithFrame:frame];
            break;
        }
        case 2:{
            [self loadCustomerListWithTag:0];
            break;
        }
        case 3:{
            //按业务员，下版本添加
            // [self loadCustomerListWithTag:1];
            break;
        }
        case 4:{
            //查询
            [self  loadDate];
            break;
        }
        case 5:{
            //重置
            _starTime = @"";
            _endTime = @"";
            _customer= @"";
            [self  loadDate];
            break;
        }
        default:
            break;
    }
    WeakSelf(self);

    //日期选择
    _datepicker.returnBlock = ^(NSInteger dateType, NSString *dateStr) {
        [weakself selectedDate:dateStr andtag:dateType];
    };
    
}
#pragma mark ====== 属性选择（日期。客户。业务员）
/**
 日期选择

 @param dateStr 日期
 @param tag 类型  1：开始时间   2：结束时间
 */
- (void)selectedDate:(NSString *)dateStr andtag:(NSInteger)tag{
    switch (tag) {
        case 1:{
            if (dateStr.length<=0) {
                //清除l开始日期
                [self.searchView clearBtnTitleWithTag:0];
            }else{
                _starTime = dateStr;
                [self.searchView setTitle:dateStr withTag:0];
            }
            break;
        }
        case 2:{
            if (dateStr.length<=0) {
                //清除结束日期
                [self.searchView clearBtnTitleWithTag:1];
            }else{
                _endTime = dateStr;
                [self.searchView setTitle:dateStr withTag:1];
            }
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
    NSDictionary *dic = @{@"companyId":user.defutecompanyId,
                          @"orderDateStart":_starTime,
                          @"orderDateEnd":_endTime,
                          @"key":_customer};
    [HUD showLoading:nil];
    [[HttpClient sharedHttpClient] requestGET:@"/finance/receivable/statement/sample/customer" Withdict:dic WithReturnBlock:^(id returnValue) {
        _dataArr = [receivableGoods mj_objectArrayWithKeyValuesArray:returnValue[@"receivableCustomers"]];
        self.checkView.billDic = returnValue;

        [self.ListTab reloadData];
        if (_dataArr.count<=0) {
            [HUD show:@"未查到相关数据"];
        }
         [HUD cancel];
    } andErrorBlock:^(NSString *msg) {
         [HUD cancel];
    }];   
}


#pragma mark ====== 应收对账单/单
- (void)loadBillListFromBill{
    User *user = [[UserPL shareManager] getLoginUser];
    NSDictionary *dic = @{@"companyId":user.defutecompanyId,
                          @"orderDateStart":_starTime,
                          @"orderDateEnd":_endTime,
                          @"key":_customer};
    [HUD showLoading:nil];
    [[HttpClient sharedHttpClient] requestGET:@"finance/receivable/statement/order/customer" Withdict:dic WithReturnBlock:^(id returnValue) {
         [HUD cancel];
        _dataArr1 = [ReceivableCustomers mj_objectArrayWithKeyValuesArray:returnValue[@"receivableCustomers"]];
        self.checkView.billDic = returnValue;
        [self.ListTab reloadData];
        if (_dataArr1.count<=0) {
            [HUD show:@"未查到相关数据"];
        }
    } andErrorBlock:^(NSString *msg) {
         [HUD cancel];
    }];

}
#pragma mark ====== 获取应收账款统计-按客户
- (void)getStatisticeListFromCustomer{
    User *user = [[UserPL shareManager] getLoginUser];
    NSDictionary *dic = @{@"companyId":user.defutecompanyId,
                          @"orderDateStart":_starTime,
                          @"orderDateEnd":_endTime,
                          @"key":_customer};
    [HUD showLoading:nil];
    [[HttpClient sharedHttpClient] requestGET:@"finance/receivable/statistics/customer" Withdict:dic WithReturnBlock:^(id returnValue) {
        [HUD cancel];
        _dataArr2 = [StasticeItem mj_objectArrayWithKeyValuesArray:returnValue[@"items"]];
        self.checkView.itemDic = returnValue;
        [self.ListTab reloadData];
        if (_dataArr2.count<=0) {
            [HUD show:@"未查到相关数据"];
        }
    } andErrorBlock:^(NSString *msg) {
         [HUD cancel];
    }];
}

#pragma mark ====== 获取客户列表
- (void)loadCustomerListWithTag:(NSInteger)tag{
    User *user = [[UserPL shareManager] getLoginUser];
    NSDictionary *dic = @{@"companyId":user.defutecompanyId,
                          @"pageNo":@"1",
                          @"pageSize":@"5000"
                          };
    [HUD showLoading:nil];
    [[HttpClient sharedHttpClient] requestGET:@"contact/company" Withdict:dic WithReturnBlock:^(id returnValue) {
        NSLog(@"%@",returnValue);
        [HUD cancel];
        NSMutableArray *dataArr = [ComCustomer mj_objectArrayWithKeyValuesArray:returnValue[@"contactCompanys"]];
        //tag : 1选择员工
        if (tag ==1) {
            self.customerSelecteView.SelectYype =1;

        }
        self.customerSelecteView.dataArr = dataArr;
        [self.customerSelecteView showView];
    } andErrorBlock:^(NSString *msg) {
        [HUD cancel];
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
    return _dataArr2.count+1;
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
    }else if (_selectedType == 2){
        if (indexPath.row ==0) {
            static NSString *topcellid = @"StastisticTopCellid";
            StastisticTopCell *cell = (StastisticTopCell *)[tableView dequeueReusableCellWithIdentifier:topcellid];
            if (cell == nil) {
                cell= (StastisticTopCell *)[[[NSBundle  mainBundle]  loadNibNamed:@"StastisticTopCell" owner:self options:nil]  lastObject];
            }
            return cell;
        }
        StastisticCell *cell = (StastisticCell *)[tableView dequeueReusableCellWithIdentifier:@"StastisticCellid"];
        if (cell == nil) {
            cell= (StastisticCell *)[[[NSBundle  mainBundle]  loadNibNamed:@"StastisticCell" owner:self options:nil]  lastObject];
        }
        cell.Item = _dataArr2[indexPath.row -1];
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

#pragma mark ======str转 date
- (NSDate *)returnDateWithDateStr:(NSString *)dateStr{
    
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc]init];//创建一个日期格式化器
    dateFormatter.dateFormat=@"yyyy-MM-dd";//指定转date得日期格式化形式
    NSDate *date = [dateFormatter dateFromString:dateStr];
    return date;
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

-(CustomerSelecteView *)customerSelecteView{
    
    if (!_customerSelecteView) {
        _customerSelecteView = [[CustomerSelecteView alloc]init];
    }
    return _customerSelecteView;
}


@end
