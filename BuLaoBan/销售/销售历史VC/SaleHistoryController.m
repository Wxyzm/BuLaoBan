//
//  SaleHistoryController.m
//  BuLaoBan
//
//  Created by apple on 2019/2/27.
//  Copyright © 2019年 XX. All rights reserved.
//

#import "SaleHistoryController.h"
#import "SaleDetailView.h"
#import "SaleHistorySearchView.h"
#import "SaleHisListCell.h"

@interface SaleHistoryController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) BaseTableView *ListTab;               //左侧列表

@property (nonatomic, strong) SaleDetailView *detailView;            //详情

@property (nonatomic, strong) SaleHistorySearchView *searchView;     //搜索

@end

@implementation SaleHistoryController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.needHideNavBar = YES;
    [self initUI];
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
    
    NSArray *titleArr = @[@"···",@"分享",@"打印",@"收款"];
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
    return 10;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellid = @"hiscell";
    SaleHisListCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (!cell) {
        cell = [[SaleHisListCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
    }
    return cell;
}



#pragma mark ====== get

-(BaseTableView *)ListTab{
    if (!_ListTab) {
        _ListTab = [[BaseTableView alloc] initWithFrame:CGRectMake(0, 64, 300, ScreenHeight-64) style:UITableViewStylePlain];
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

@end
