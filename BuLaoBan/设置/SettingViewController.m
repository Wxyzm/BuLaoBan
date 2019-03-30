//
//  SettingViewController.m
//  BuLaoBan
//
//  Created by apple on 2019/2/13.
//  Copyright © 2019年 XX. All rights reserved.
//

#import "SettingViewController.h"
#import "SettingCell.h"
#import "StaffView.h"        //员工管理View
#import "LinkPrinterView.h"  //链接打印机View
#import "PrinterModelView.h" //打印模板设置
#import "CompanyUsers.h"     //员工

@interface SettingViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) BaseTableView *ListTab;

/**
 员工管理
 */
@property (nonatomic, strong) StaffView *staffView;

/**
 链接打印机Vi
 */
@property (nonatomic, strong) LinkPrinterView *linkView;

/**
 打印模板
 */
@property (nonatomic, strong) PrinterModelView *modelView;

@property (nonatomic,strong) NSMutableArray *userArr;


@end

@implementation SettingViewController{
    
    NSInteger _selectIndex;
    UIButton *_saveBtn;
    UILabel *_titleLab;
    NSMutableArray *_viewArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.needHideNavBar = YES;
    self.view.backgroundColor = UIColorFromRGB(BackColorValue);
    _selectIndex = 0;
    _viewArr = [NSMutableArray arrayWithCapacity:0];
    _userArr = [NSMutableArray arrayWithCapacity:0];
    [self initUI];
    [self loadcompanysUsersList];
}

- (void)initUI{
    
    //顶部View
    UIView *topView = [BaseViewFactory viewWithFrame:CGRectMake(0, 0, ScreenWidth-100, 64) color:UIColorFromRGB(WhiteColorValue)];
    [self.view addSubview:topView];
    UILabel *goodsLab = [BaseViewFactory labelWithFrame:CGRectMake(0, 20, 300, 44) textColor:UIColorFromRGB(BlackColorValue) font:APPFONT17 textAligment:NSTextAlignmentCenter andtext:@"系统设置"];
    [topView addSubview:goodsLab];
    
    UIView *line1 = [BaseViewFactory viewWithFrame:CGRectMake(0, 63, ScreenWidth-100, 1) color:UIColorFromRGB(LineColorValue)];
    [topView addSubview:line1];
    
    _titleLab = [BaseViewFactory labelWithFrame:CGRectMake(300, 20, ScreenWidth-400, 44) textColor:UIColorFromRGB(BlackColorValue) font:APPFONT17 textAligment:NSTextAlignmentCenter andtext:@"员工管理"];
    [topView addSubview:_titleLab];
    
    _saveBtn = [BaseViewFactory buttonWithFrame:CGRectMake(ScreenWidth-160, 20, 40, 43) font:APPFONT15 title:@"保存" titleColor:UIColorFromRGB(BlueColorValue) backColor:UIColorFromRGB(WhiteColorValue)];
    [_saveBtn addTarget:self action:@selector(rightBtnGoodsBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:_saveBtn];
    //左侧列表
    [self.view addSubview:self.ListTab];
   
    //员工管理
    [self.view addSubview:self.staffView];
    [_viewArr addObject:self.staffView];

    //打印链接View
    [self.view addSubview:self.linkView];
    [_viewArr addObject:self.linkView];
    //模板View
    [self.view addSubview:self.modelView];
    [_viewArr addObject:self.modelView];
    
    UIView *line2 = [BaseViewFactory viewWithFrame:CGRectMake(299.5, 0, 1, ScreenHeight) color:UIColorFromRGB(LineColorValue)];
    [self.view addSubview:line2];
    
    [self setRightbtnTitle];

}


/**
 右侧按钮点击
 */
- (void)rightBtnGoodsBtnClick{
    
    
}
#pragma mark ====  获取员工列表

- (void)loadcompanysUsersList{
    
    User *user = [[UserPL shareManager] getLoginUser];
    NSDictionary *dic = @{@"pageNo":@"1",
                          @"pageSize":@"5000",
                          @"":@""
                          };
    [[HttpClient sharedHttpClient] requestGET:[NSString stringWithFormat:@"/companys/%@/users",user.defutecompanyId] Withdict:dic WithReturnBlock:^(id returnValue) {
        NSLog(@"%@",returnValue);
        _userArr = [CompanyUsers mj_objectArrayWithKeyValuesArray:returnValue[@"companyUsers"]];
        self.staffView.dataArr = _userArr;
    } andErrorBlock:^(NSString *msg) {
        
    }];
    
    
}


#pragma mark ====== tableviewdelegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section==0) {
        return 0.0001;
    }
    return 10;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    if (section==0) {
        return [UIView new];
    }
    UIView *view = [BaseViewFactory viewWithFrame:CGRectMake(0, 0, 300, 10) color:UIColorFromRGB(BackColorValue)];
    return view;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==0) {
        return 4;
    }
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellid = @"cellid";
    SettingCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (!cell) {
        cell =[[SettingCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
    }
    if (indexPath.section == 0) {
        NSArray *arr = @[@"员工管理",@"连接打印机",@"打印模版设置",@"应收启用月份"];
        cell.nameLab.text = arr[indexPath.row];
        cell.lineView.hidden = NO;
        if (indexPath.row == _selectIndex) {
            cell.contentView.backgroundColor = UIColorFromRGB(0xEFF6F9);
        }else{
            cell.contentView.backgroundColor = UIColorFromRGB(WhiteColorValue);
            
        }

    }else if (indexPath.section == 1){
        cell.nameLab.text = @"关于我们";
        cell.lineView.hidden = YES;
        if (_selectIndex == 4) {
            cell.contentView.backgroundColor = UIColorFromRGB(0xEFF6F9);
        }else{
            cell.contentView.backgroundColor = UIColorFromRGB(WhiteColorValue);
            
        }
    }else{
        cell.nameLab.text = @"清空缓存";
        cell.lineView.hidden = YES;
        if (_selectIndex == 5) {
            cell.contentView.backgroundColor = UIColorFromRGB(0xEFF6F9);
        }else{
            cell.contentView.backgroundColor = UIColorFromRGB(WhiteColorValue);
            
        }
    }
    
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0)
    {
        NSArray *arr = @[@"员工管理",@"连接打印机",@"打印模版设置",@"应收启用月份"];
         _selectIndex = indexPath.row;
        _titleLab.text = arr[_selectIndex];
        [self setViewShowandHidden];
        if (_selectIndex ==0) {
            //员工管理
            [self loadcompanysUsersList];
        }
    }
    [self.ListTab reloadData];

}

#pragma mark === 设置显示隐藏
- (void)setViewShowandHidden{
    for (UIView *view in _viewArr) {
        view.hidden = YES;
    }
    if (_selectIndex>_viewArr.count-1) {
        return;
    }
    UIView *showview = _viewArr[_selectIndex];
    showview.hidden = NO;
    [self setRightbtnTitle];
}

- (void)setRightbtnTitle{
    if (_selectIndex ==0) {
        [_saveBtn setTitle:@"邀请员工" forState:UIControlStateNormal];
        _saveBtn.frame =  CGRectMake(ScreenWidth-200, 20, 80, 43);

    }else if (_selectIndex ==1){
        _saveBtn.frame =  CGRectMake(ScreenWidth-160, 20, 40, 43);
        [_saveBtn setTitle:@"刷新" forState:UIControlStateNormal];
    }else if (_selectIndex ==2){
        _saveBtn.frame =  CGRectMake(ScreenWidth-160, 20, 40, 43);
        [_saveBtn setTitle:@"刷新" forState:UIControlStateNormal];
    }else{
        _saveBtn.frame =  CGRectMake(ScreenWidth-160, 20, 40, 43);
        [_saveBtn setTitle:@"" forState:UIControlStateNormal];
    }
    
    
    
}



#pragma mark ====== get

-(BaseTableView *)ListTab{
    if (!_ListTab) {
        _ListTab = [[BaseTableView alloc] initWithFrame:CGRectMake(0, 64, 300, ScreenHeight-64-50) style:UITableViewStylePlain];
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

-(StaffView *)staffView{
    if (!_staffView) {
        _staffView  = [[StaffView alloc]initWithFrame:CGRectMake(300, 64, ScreenWidth-400, ScreenHeight-64)];
    }
    
    return _staffView;
}

-(LinkPrinterView *)linkView{
    
    if (!_linkView) {
        _linkView = [[LinkPrinterView alloc]initWithFrame:CGRectMake(300, 64, ScreenWidth-400, ScreenHeight-64)];
        _linkView.hidden = YES;
    }
    
    return _linkView;
}

-(PrinterModelView *)modelView{
    if (!_modelView) {
        _modelView = [[PrinterModelView alloc]initWithFrame:CGRectMake(300, 64, ScreenWidth-400, ScreenHeight-64)];
        _modelView.hidden = YES;
    }
    return _modelView;
}


@end
