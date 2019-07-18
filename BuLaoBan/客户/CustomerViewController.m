//
//  CustomerViewController.m
//  BuLaoBan
//
//  Created by apple on 2019/1/28.
//  Copyright © 2019年 XX. All rights reserved.
//

#import "CustomerViewController.h"
#import "Customerheader.h"

#import "CustomerAddVM.h"
#import "CustomerAddTypeModel.h"
#import "CustomerAddReceOpenView.h"
#import "Setting.h"
@interface CustomerViewController ()<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) BaseTableView *ListTab;
@property (nonatomic, strong) NSMutableArray *dataArr;
@property (nonatomic, strong) ComCustomerDetail *detailModel;

/**
 新增View
 */
//@property (nonatomic, strong) CustomerAddView *addView;

/**
 s详情View
 */
@property (nonatomic, strong) CustomerDetailView *detailView;

/**
 收款View
 */
@property (nonatomic, strong) ReceiveBaseView *receiveView;

/**
 编辑菜单
 */
@property (nonatomic, strong) RightMenueView*menueView;

@property (nonatomic, strong) CustomerAddVM *viewModel;
@property (nonatomic, strong) CustomerAddReceOpenView *addReceView;


@end

@implementation CustomerViewController{
    
    UITextField *_searchTxt;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.needHideNavBar = YES;
    self.view.backgroundColor = [UIColor whiteColor];
    _dataArr = [NSMutableArray arrayWithCapacity:0];
    [self initUI];
    [self loadCustomerList];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadList) name:@"reloadCustomerList" object:nil];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadDetail) name:@"accMoneySuccess" object:nil];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (void)initUI{
    //顶部View
    UIView *topView = [BaseViewFactory viewWithFrame:CGRectMake(0, 0, ScreenWidth-100, 64) color:UIColorFromRGB(WhiteColorValue)];
    [self.view addSubview:topView];
    UILabel *goodsLab = [BaseViewFactory labelWithFrame:CGRectMake(16, 30, 70, 24) textColor:UIColorFromRGB(BlackColorValue) font:APPFONT17 textAligment:NSTextAlignmentCenter andtext:@"客户列表"];
    [topView addSubview:goodsLab];
    UIButton *addBtn = [BaseViewFactory buttonWithFrame:CGRectMake(226, 30, 64, 24) font:APPFONT15 title:@"新增客户" titleColor:UIColorFromRGB(BlueColorValue) backColor:UIColorFromRGB(WhiteColorValue)];
    [addBtn addTarget:self action:@selector(addNewCustomerBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:addBtn];
    UIView *line1 = [BaseViewFactory viewWithFrame:CGRectMake(0, 63, ScreenWidth-100, 1) color:UIColorFromRGB(LineColorValue)];
    [topView addSubview:line1];
    
    UILabel *goodsLab2 = [BaseViewFactory labelWithFrame:CGRectMake(300, 20, ScreenWidth-400, 44) textColor:UIColorFromRGB(BlackColorValue) font:APPFONT17 textAligment:NSTextAlignmentCenter andtext:@"客户详情"];
    [topView addSubview:goodsLab2];
    
    UIButton *acceptBtn = [BaseViewFactory buttonWithFrame:CGRectMake(ScreenWidth-210, 20, 50, 43) font:APPFONT14 title:@"收款" titleColor:UIColorFromRGB(BlueColorValue) backColor:UIColorFromRGB(WhiteColorValue)];
    [acceptBtn addTarget:self action:@selector(acceptBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:acceptBtn];
    
    UIButton *changeBtn = [BaseViewFactory buttonWithFrame:CGRectMake(ScreenWidth-140, 20, 20, 43) font:APPFONT15 title:@"···" titleColor:UIColorFromRGB(BlueColorValue) backColor:UIColorFromRGB(WhiteColorValue)];
    [changeBtn addTarget:self action:@selector(changeBtnGoodsBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:changeBtn];
    
    UIView *backView = [BaseViewFactory viewWithFrame:CGRectMake(0, 64,300 , 56) color:UIColorFromRGB(LineColorValue)];
    [self.view addSubview:backView];
    
    _searchTxt = [BaseViewFactory textFieldWithFrame:CGRectMake(10, 10, 280, 36) font:APPFONT14 placeholder:@"输入客户名称/电话" textColor:UIColorFromRGB(BlackColorValue) placeholderColor:UIColorFromRGB(0x858585) delegate:self];
    _searchTxt.returnKeyType = UIReturnKeyDone;
    _searchTxt.backgroundColor = UIColorFromRGB(WhiteColorValue);
    _searchTxt.leftViewMode = UITextFieldViewModeAlways;
    _searchTxt.layer.cornerRadius = 2;
    _searchTxt.leftView = [BaseViewFactory viewWithFrame:CGRectMake(0, 0, 12, 36) color:[UIColor clearColor]];
    [backView addSubview:_searchTxt];
    
    [self.view addSubview:self.ListTab];
    //详情View
    _detailView = [[CustomerDetailView alloc]initWithFrame:CGRectMake(300, 64, ScreenWidth-400, ScreenHeight-64)];;
    [self.view addSubview:_detailView];

    UIView *line2 = [BaseViewFactory viewWithFrame:CGRectMake(300, 0, 1, ScreenHeight) color:UIColorFromRGB(LineColorValue)];
    [self.view addSubview:line2];
    //编辑
    [self.view addSubview:self.menueView];
    
#pragma mark ====== addView回调
    WeakSelf(self);
//    self.addView.returnBlock = ^(NSInteger tag, ComCustomerDetail * _Nonnull model) {
//        //0:保存  1：业务员  2：参与者
//        switch (tag) {
//            case 0:{
//                //保存
//                NSDictionary *setDic = [weakself.addView getSetUPDic];
//                if (model.comId.length<=0) {
//                    //新增
//                    [weakself addcontactComWiyhDic:setDic];
//                }else{
//                    //编辑
//                    [weakself savecontactComWiyhDic:setDic ComCustomerDetail:model];
//                }
//                break;
//            }
//            case 1:{
//                //1：业务员
//                [weakself getCompanyUsersWithComCustomerDetail:model];
//                break;
//            }
//            case 2:{
//                //参与者
//                [weakself getCompanyparticipantsWithComCustomerDetail:model];
//                break;
//            }
//            default:
//                break;
//        }
//    };
}


- (void)loadDetail{
    for (ComCustomer *customer in _dataArr) {
        if (customer.isSelected == YES) {
            [self loadCustomerDetailWithCustomereId:customer.comId];

        }
    }
}

#pragma mark ====== 获取列表
- (void)loadCustomerList{
    User *user = [[UserPL shareManager] getLoginUser];
    NSDictionary *dic = @{@"companyId":user.defutecompanyId,
                          @"pageNo":@"1",
                          @"pageSize":@"5000"
                          };
    [[HttpClient sharedHttpClient] requestGET:@"contact/company" Withdict:dic WithReturnBlock:^(id returnValue) {
        NSLog(@"%@",returnValue);
        
        _dataArr = [ComCustomer mj_objectArrayWithKeyValuesArray:returnValue[@"contactCompanys"]];
        NSArray *allArr  = [ComCustomer mj_objectArrayWithKeyValuesArray:returnValue[@"contactCompanys"]];
        if (_searchTxt.text.length>0) {
            //搜索条件
            [_dataArr removeAllObjects];
            for (ComCustomer *model in allArr) {
                if ([model.name containsString:_searchTxt.text]||[model.telephone containsString:_searchTxt.text]) {
                    if (![_dataArr containsObject:model]&&[model.nature intValue]==2) {
                        [_dataArr addObject:model];
                    }
                }
            }
        }else{
            [_dataArr removeAllObjects];
            for (ComCustomer *model in allArr) {
                if (![_dataArr containsObject:model]&&[model.nature intValue]==2) {
                    [_dataArr addObject:model];
                }
            }
        }
        
        if (_dataArr.count>0) {
            ComCustomer *Customer = _dataArr[0];
            Customer.isSelected = YES;
            [self loadCustomerDetailWithCustomereId:Customer.comId];
        }
        [self.ListTab reloadData];
        [self.ListTab.mj_header endRefreshing];
    } andErrorBlock:^(NSString *msg) {
        [self.ListTab.mj_header endRefreshing];

    }];
}

- (void)reloadList{
    [self loadCustomerList];
}

#pragma mark ====== 获取详情
- (void)loadCustomerDetailWithCustomereId:(NSString *)customerId{
    [[HttpClient sharedHttpClient] requestGET:[NSString stringWithFormat:@"/contact/company/%@",customerId] Withdict:nil WithReturnBlock:^(id returnValue) {
        NSLog(@"%@",returnValue);
        ComCustomerDetail *detailModel = [ComCustomerDetail mj_objectWithKeyValues:returnValue];
        detailModel.comId = customerId;
        _detailView.detailModel = detailModel;
        _detailModel = detailModel;
    } andErrorBlock:^(NSString *msg) {
    }];
}

#pragma mark ====== 获取业务员
- (void)getCompanyUsersWithComCustomerDetail:(ComCustomerDetail*)model{
//    NSDictionary *dic = @{@"pageNo":@"1",@"pageSize":@"5000",};
//    User *user = [[UserPL shareManager] getLoginUser];
//    [[HttpClient sharedHttpClient] requestGET:[NSString stringWithFormat:@"/companys/%@/users",user.defutecompanyId] Withdict:dic WithReturnBlock:^(id returnValue) {
//        NSLog(@"%@",returnValue);
//        NSMutableArray * comArr = [CompanyUsers mj_objectArrayWithKeyValuesArray:returnValue[@"companyUsers"]];
//        self.addView.comArr = comArr;
//    } andErrorBlock:^(NSString *msg) {
//
//    }];
}
#pragma mark ====== 获取参与者
- (void)getCompanyparticipantsWithComCustomerDetail:(ComCustomerDetail*)model{
//    User *user = [[UserPL shareManager] getLoginUser];
//    NSDictionary *dic = @{@"companyId":user.defutecompanyId,
//                          @"nature":@"1"
//                          };
//    [[HttpClient sharedHttpClient] requestGET:@"contact/company/participants" Withdict:dic WithReturnBlock:^(id returnValue) {
//        NSLog(@"%@",returnValue);
//        NSMutableArray * particModelArr = [Participants mj_objectArrayWithKeyValuesArray:returnValue[@"participants"]];
//        self.addView.parArr = particModelArr;
//    } andErrorBlock:^(NSString *msg) {
//
//    }];
}

#pragma mark ====== 修改联系公司
- (void)savecontactComWiyhDic:(NSDictionary *)dic ComCustomerDetail:(ComCustomerDetail*)model{
//    [[HttpClient sharedHttpClient] requestPUTWithURLStr:[NSString stringWithFormat:@"/contact/company/%@",model.comId] paramDic:dic WithReturnBlock:^(id returnValue) {
//        NSLog(@"%@",returnValue);
//        [self changeParticiWithID:model.comId];
//        [HUD show:@"修改成功"];
//        [self.addView dismiss];
//        [self reloadList];
//    } andErrorBlock:^(NSString *msg) {
//
//    }];
}
#pragma mark ====== 添加联系公司
- (void)addcontactComWiyhDic:(NSDictionary *)dic{
//    [[HttpClient sharedHttpClient] requestPOST:@"/contact/company" Withdict:dic WithReturnBlock:^(id returnValue) {
//        [HUD show:@"添加成功"];
//        [self changeParticiWithID:returnValue[@"contactCompanyId"]];
//        [self.addView dismiss];
//        [self reloadList];
//    } andErrorBlock:^(NSString *msg) {
//
//    }];
}

#pragma mark ====== 修改参与者
- (void)changeParticiWithID:(NSString *)comID{
//    if (![self.addView GetParticiDic]) {
//        return;
//    }
//    NSDictionary *dic = [self.addView GetParticiDic];
//    [[HttpClient sharedHttpClient] requestPUTWithURLStr:[NSString stringWithFormat:@"/contact/company/%@/participants",comID] paramDic:dic WithReturnBlock:^(id returnValue) {
//
//    } andErrorBlock:^(NSString *msg) {
//
//    }];
   
}


#pragma mark ======  删除联系公司
- (void)DeleteCurrentcontactCom{
    ComCustomer *selectcustomer;
    for (ComCustomer *customer in _dataArr) {
        if (customer.isSelected) {
            selectcustomer = customer;
        }
    }
    if (!selectcustomer) {
        return;
    }
    [[HttpClient sharedHttpClient]requestDeleteWithURLStr:[NSString stringWithFormat:@"/contact/company/%@",selectcustomer.comId] paramDic:nil WithReturnBlock:^(id returnValue) {
         [HUD show:@"删除成功"];
        [self reloadList];
    } andErrorBlock:^(NSString *msg) {
        
    }];
}

#pragma mark ======  获取公司账户列表
- (void)loadComAccountList{
    ComCustomer *selectcustomer;
    for (ComCustomer *customer in _dataArr) {
        if (customer.isSelected) {
            selectcustomer = customer;
        }
    }
    if (!selectcustomer) {
        return;
    }
    User  *user = [[UserPL shareManager] getLoginUser];
    [[HttpClient sharedHttpClient] requestGET:[NSString stringWithFormat:@"/companys/%@/account",user.defutecompanyId] Withdict:nil WithReturnBlock:^(id returnValue) {
        NSLog(@"%@",returnValue);
        selectcustomer.receivableAmount = _detailView.detailModel.receivableAmount;
        NSMutableArray *listArr = [Accounts mj_objectArrayWithKeyValuesArray:returnValue[@"accounts"]];
        self.receiveView.commodel = selectcustomer;
        self.receiveView.listArr = listArr;
        [self.receiveView showInView];
    } andErrorBlock:^(NSString *msg) {
        
    }];
}
#pragma mark ==== 获取样品间基础设置
/**
 @param type 0:新增 1:编辑
 */
- (void)loadcompanySettingwithIdWithType:(NSInteger)type{
    User *user = [[UserPL shareManager] getLoginUser];
    [[HttpClient sharedHttpClient] requestGET:[NSString stringWithFormat:@"/companys/%@/settings",user.defutecompanyId] Withdict:nil WithReturnBlock:^(id returnValue) {
        NSLog(@"%@",returnValue);
        Setting *setmodel = [Setting mj_objectWithKeyValues:returnValue];
        
        
        if (type ==0) {
            if (setmodel.receivableStartDate.length>0) {
                //启用
                [self.viewModel reSetDataWithReceiveAble:YES];
            }else{
                [self.viewModel reSetDataWithReceiveAble:NO];
            }
            if (_detailModel.nature.length>0&&type == 0) {
                //新增
                self.addReceView.nature = _detailModel.nature;
            }else{
                self.addReceView.nature = @"2";
            }
        }else{
            if (setmodel.receivableStartDate.length>0) {
                //启用
                [self.viewModel setComCustomerDetailModel:_detailModel andisReceive:YES];
            }else{
                [self.viewModel setComCustomerDetailModel:_detailModel andisReceive:NO];
            }
            self.addReceView.comID = _detailModel.comId;
        }
        self.addReceView.type = type;
        self.addReceView.dataArr = self.viewModel.listArr;

        [self.addReceView showTheView];

        
    } andErrorBlock:^(NSString *msg) {
        
    }];
}

#pragma mark ====== 按钮点击 新增客户 收款 客户编辑
//新增客户
- (void)addNewCustomerBtnClick{
    [self loadcompanySettingwithIdWithType:0];
//    [self.addView clearAllInfo];
//    [self.addView showTheView];
}

//收款
- (void)acceptBtnClick{
    [self loadComAccountList];
}
//客户编辑
- (void)changeBtnGoodsBtnClick{
    WeakSelf(self);
    [self.view bringSubviewToFront:self.menueView];
    self.menueView.hidden = NO;
    self.menueView.returnBlock = ^(NSInteger index) {
        switch (index) {
            case 0:{
                [weakself loadcompanySettingwithIdWithType:1];
//                for (ComCustomer *customer in weakself.dataArr) {
//                    if (customer.isSelected == YES) {
//                        weakself.addView.model = weakself.detailModel;
//                    }
//                }
//                [weakself.addView showTheView];
                
                break;
            }
            case 1:{
               
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"确定删除该联系人？" preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                    [weakself DeleteCurrentcontactCom];
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

#pragma mark ====== tableviewdelegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 48;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *view = [BaseViewFactory viewWithFrame:CGRectMake(0, 0, 300, 48) color:UIColorFromRGB(BackColorValue)];
    UILabel *lab = [BaseViewFactory labelWithFrame:CGRectMake(12, 0, 276, 48) textColor:UIColorFromRGB(BlackColorValue) font:APPFONT13 textAligment:NSTextAlignmentLeft andtext:[NSString stringWithFormat:@"共%ld家客户",_dataArr.count]];
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
    static NSString *cellid = @"CustomerCell";
    CustomerCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (!cell) {
        cell = [[CustomerCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
    }
    cell.customer = _dataArr[indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    for (ComCustomer *customer in _dataArr) {
        customer.isSelected = NO;
    }
    ComCustomer *customer = _dataArr[indexPath.row];
    customer.isSelected = YES;
    [self.ListTab reloadData];
    [self loadCustomerDetailWithCustomereId:customer.comId];
    
}

#pragma mark ====== textFielddelegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    if (textField ==_searchTxt) {
        [_searchTxt resignFirstResponder];
        [self loadCustomerList];
    }
    
    return YES;
}


#pragma mark ====== get

-(BaseTableView *)ListTab{
    if (!_ListTab) {
        _ListTab = [[BaseTableView alloc] initWithFrame:CGRectMake(0, 120, 300, ScreenHeight-64) style:UITableViewStylePlain];
        _ListTab.delegate = self;
        _ListTab.dataSource = self;
        _ListTab.backgroundColor = UIColorFromRGB(BackColorValue);
        _ListTab.separatorStyle = UITableViewCellSeparatorStyleNone;
        _ListTab.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(reloadList)];

        if (@available(iOS 11.0, *)) {
            _ListTab.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {
        }
    }
    return _ListTab;
}

-(RightMenueView *)menueView{
    
    if (!_menueView) {
        NSArray *titleArr = @[@"编辑",@"删除"];
        _menueView = [[RightMenueView alloc]initWithTitleArr:titleArr];
    }
    return _menueView;
}

//-(CustomerAddView *)addView{
//    if (!_addView) {
//        _addView = [[CustomerAddView alloc]init];
//    }
//    return _addView;
//}

-(ReceiveBaseView *)receiveView{
    if (!_receiveView) {
        _receiveView = [[ReceiveBaseView alloc]init];
    }
    return _receiveView;
}

-(CustomerAddVM *)viewModel{
    if (!_viewModel) {
        _viewModel = [[CustomerAddVM alloc]init];
    }
    return _viewModel;
}

-(CustomerAddReceOpenView *)addReceView{
    
    if (!_addReceView) {
        _addReceView = [[CustomerAddReceOpenView alloc]init];
    }
    return _addReceView;
}

@end
