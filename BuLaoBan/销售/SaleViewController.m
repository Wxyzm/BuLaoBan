//
//  SaleViewController.m
//  BuLaoBan
//
//  Created by apple on 2019/1/28.
//  Copyright © 2019年 XX. All rights reserved.
//

#import "SaleViewController.h"
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


@interface SaleViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) BaseTableView *ListTab;               //列表

/**
 顶部View
 */
@property (nonatomic, strong) SaleHeaderView *HeaderView;

/**
 键盘
 */
@property (nonatomic, strong) DIYSearchKeyBoardView *KeyBoardView;

/**
 客户
 */
@property (nonatomic, strong) SaleCustomerView *CustomerView;

/**
 数量
 */
@property (nonatomic, strong) UILabel *numLab;

/**
 金额
 */
@property (nonatomic, strong) UILabel *moneyLab;

@property (nonatomic, strong) CustomerSelecteView *customerSelecteView;


@end

@implementation SaleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.needHideNavBar = YES;
    self.view.backgroundColor = UIColorFromRGB(BackColorValue);
    [self initUI];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
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
    _numLab  = [BaseViewFactory labelWithFrame:CGRectMake(50, 0, 160, 50) textColor:UIColorFromRGB(BlueColorValue) font:APPFONT14 textAligment:NSTextAlignmentRight andtext:@"2款, 4匹, 100.00米"];
    [StatisticsView addSubview:_numLab];
    UIView *line = [BaseViewFactory viewWithFrame:CGRectMake(10, 49, 200, 1) color:UIColorFromRGB(LineColorValue)];
    [StatisticsView addSubview:line];

    UILabel *moneylab = [BaseViewFactory labelWithFrame:CGRectMake(10, 50, 50, 50) textColor:UIColorFromRGB(BlackColorValue) font:APPFONT14 textAligment:NSTextAlignmentLeft andtext:@"金额"];
    [StatisticsView addSubview:moneylab];
    _moneyLab  = [BaseViewFactory labelWithFrame:CGRectMake(50, 50, 160, 50) textColor:UIColorFromRGB(RedColorValue) font:APPFONT14 textAligment:NSTextAlignmentRight andtext:@"1000.00"];
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
    //客户选择
    self.CustomerView.returnBlock = ^(NSInteger tag) {
        [weakself customerBtnClickWithTag:tag];
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
    [self.navigationController pushViewController:[SettlementViewController new] animated:YES];
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



#pragma mark ====== tableview

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 6;
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


@end
