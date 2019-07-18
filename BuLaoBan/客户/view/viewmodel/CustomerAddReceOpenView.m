//
//  CustomerAddReceOpenView.m
//  BuLaoBan
//
//  Created by souxiuyun on 2019/7/4.
//  Copyright © 2019 XX. All rights reserved.
//

#import "CustomerAddReceOpenView.h"
#import "CustomerAddInputCell.h"
#import "CustomerAddTypeModel.h"
#import "CustomerAddSelectedCell.h"

#import "CompanyUsers.h"
#import "Participants.h"
#import "CustomerAddManView.h"
@interface CustomerAddReceOpenView ()<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource,CustomerAddSelectedCellDelegate,CustomerAddManViewDelegate>

@property (nonatomic, strong) UIView *sideView;
@property (nonatomic,strong)UIButton *backBtn;
@property (nonatomic, strong) BaseTableView *ListTab;
@property (nonatomic, strong) UITableView *manTab;
@property (nonatomic, strong) CustomerAddManView *addView;

@end
@implementation CustomerAddReceOpenView{
    
    BOOL _isShow;
    BOOL isHaveDian;
}
-(instancetype)init{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
        self.backgroundColor = [UIColor clearColor];
        isHaveDian = NO;
        [self setUP];
    }
    return self;
}

- (void)setUP{
    [self addSubview:self.backBtn];
    
    _sideView = [BaseViewFactory viewWithFrame:CGRectMake(ScreenWidth/2-300, ScreenHeight/2-265, 600, 530) color:UIColorFromRGB(WhiteColorValue)];
    [self addSubview:_sideView];
    _titleLab = [BaseViewFactory labelWithFrame:CGRectMake(0, 0, 600, 44) textColor:UIColorFromRGB(WhiteColorValue) font:APPFONT(14) textAligment:NSTextAlignmentCenter andtext:@"新增客户"];
    _titleLab.backgroundColor = UIColorFromRGB(BlueColorValue);
    [self.sideView addSubview:_titleLab];
    UIButton *closeBtn = [BaseViewFactory setImagebuttonWithWidth:16 imagePath:@"window_close"];
    [closeBtn addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    [self.sideView addSubview:closeBtn];
    closeBtn.frame = CGRectMake(564, 14, 16, 16);
    [_sideView addSubview:self.ListTab];
    
    
}
#pragma mark ===== setDataArr
-(void)setDataArr:(NSMutableArray *)dataArr{
    _dataArr = dataArr;
    [self.ListTab reloadData];
    
}

#pragma mark ===== TableViewdelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArr.count + 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == _dataArr.count) {
        return 90;
    }
    return 44;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *endCellId = @"endCellId";
    if (indexPath.row>= _dataArr.count) {
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:endCellId];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:endCellId];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            UIButton *setBtn = [BaseViewFactory buttonWithFrame:CGRectMake(150, 20, 300, 40) font:APPFONT14 title:@"保存" titleColor:UIColorFromRGB(WhiteColorValue) backColor:UIColorFromRGB(NAVColorValue)];
            [cell.contentView addSubview:setBtn];
            [setBtn addTarget:self action:@selector(setBtnClick) forControlEvents:UIControlEventTouchUpInside];
        }
        return cell;
    }
    
    CustomerAddTypeModel *model = _dataArr[indexPath.row];
    static NSString *inputCellId = @"inputCellId";
    static NSString *selectedCellId = @"selectedCellId";

    if (model.cellType == 1) {
        CustomerAddInputCell *cell = [tableView dequeueReusableCellWithIdentifier:inputCellId];
        if (!cell) {
            cell = [[CustomerAddInputCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:inputCellId];
        }
        cell.model = model;
        return cell;
        
    }else if (model.cellType == 2){
        CustomerAddSelectedCell *cell = [tableView dequeueReusableCellWithIdentifier:selectedCellId];
        if (!cell) {
            cell = [[CustomerAddSelectedCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:selectedCellId];
        }
        cell.model = model;
        cell.delegate = self;
        return cell;
    }
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:endCellId];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:endCellId];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
      
    }
    return cell;
    
    
}
#pragma - 提交
- (void)setBtnClick{
    [self endEditing:YES];
    NSMutableDictionary *setDic = [[NSMutableDictionary alloc]init];
    NSDictionary *parDic ;

    for (CustomerAddTypeModel *model in _dataArr) {
        if ([model.title isEqualToString:@"客户名称"]&&model.showvalue.length<=0) {
            [HUD show:@"请输入客户名称"];
            return;
        }else if ([model.title isEqualToString:@"业务员"]&&model.valueId.length<=0){
            [HUD show:@"请选择业务员"];
            return;
        }
        if (model.cellType == 1) {
            //输入
            if (model.showvalue.length>0) {
                [setDic setValue:model.showvalue forKey:model.upStr];
            }
        }else if (model.cellType == 2){
            if ([model.title isEqualToString:@"业务员"]){
                [setDic setValue:model.valueId forKey:model.upStr];
            }else if ([model.title isEqualToString:@"参与者"]){
                parDic = @{@"type":@"1",@"userIds":model.valueId?model.valueId:@"",@"groupIds":@""};
            }
        }
    }
    User *user = [[UserPL shareManager] getLoginUser];
    if (_nature.length>0) {
        [setDic setValue:_nature forKey:@"nature"];
    }else{
        [setDic setValue:@"2" forKey:@"nature"];
    }
    if (_type == 0) {
        //新增
        [setDic setValue:user.defutecompanyId forKey:@"companyId"];
        [self addcontactComWiyhDic:setDic andParticiDic:parDic];
    }else{
        //编辑
        [self savecontactComWiyhDic:setDic andParticiDic:parDic];
    }
  
}
#pragma mark ====== 添加联系公司
- (void)addcontactComWiyhDic:(NSDictionary *)dic andParticiDic:(NSDictionary *)particiDic{
        [[HttpClient sharedHttpClient] requestPOST:@"/contact/company" Withdict:dic WithReturnBlock:^(id returnValue) {
            [HUD show:@"添加成功"];
            [self changeParticiWithID:returnValue[@"contactCompanyId"] andParticiDic:particiDic];
            
        } andErrorBlock:^(NSString *msg) {
    
        }];
}
#pragma mark ====== 修改参与者
- (void)changeParticiWithID:(NSString *)comID andParticiDic:(NSDictionary *)particiDic{
    NSString * particiId = [NSString stringWithFormat:@"%@",particiDic[@"userIds"]];
        if (particiId.length<=0) {
            return;
        }
        [[HttpClient sharedHttpClient] requestPUTWithURLStr:[NSString stringWithFormat:@"/contact/company/%@/participants",comID] paramDic:particiDic WithReturnBlock:^(id returnValue) {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"reloadCustomerList" object:nil];
            [self dismiss];
        } andErrorBlock:^(NSString *msg) {
    
        }];
}

#pragma mark ====== 修改联系公司
- (void)savecontactComWiyhDic:(NSDictionary *)dic andParticiDic:(NSDictionary *)particiDic{
        [[HttpClient sharedHttpClient] requestPUTWithURLStr:[NSString stringWithFormat:@"/contact/company/%@",_comID] paramDic:dic WithReturnBlock:^(id returnValue) {
            NSLog(@"%@",returnValue);
            [self changeParticiWithID:_comID andParticiDic:particiDic];
           
        } andErrorBlock:^(NSString *msg) {
    
        }];
}

#pragma - 选取业务员参与者
-(void)selectedBtnWithModel:(CustomerAddTypeModel *)model{
    if ([model.title isEqualToString:@"业务员"]) {
        [self getCompanyUsersWithComCustomerDetail];
    }else if ([model.title isEqualToString:@"参与者"]){
          [self getCompanyparticipantsWithComCustomerDetail];
    }
}

#pragma - 选取业务员参与者回调
//业务员
-(void)didselectedsaleManListWithModel:(CompanyUsers *)saleManModel{
    for (CustomerAddTypeModel *model in _dataArr) {
        if ([model.title isEqualToString:@"业务员"]) {
            model.valueId = saleManModel.userId;
            model.showvalue = saleManModel.name;
        }
    }
    [self dismissAddView];
    [self.ListTab reloadData];
}
//参与者
-(void)didselectedparManListWithModel:(Participants *)parManModel{
    for (CustomerAddTypeModel *model in _dataArr) {
        if ([model.title isEqualToString:@"参与者"]) {
            model.valueId = parManModel.userId;
            model.showvalue = parManModel.userName;
        }
    }
    [self dismissAddView];
    [self.ListTab reloadData];
}

-(void)didselectedCloseBtn{
     [self dismissAddView];
}

#pragma mark ====== 获取业务员
- (void)getCompanyUsersWithComCustomerDetail{
        NSDictionary *dic = @{@"pageNo":@"1",@"pageSize":@"5000",};
        User *user = [[UserPL shareManager] getLoginUser];
        [[HttpClient sharedHttpClient] requestGET:[NSString stringWithFormat:@"/companys/%@/users",user.defutecompanyId] Withdict:dic WithReturnBlock:^(id returnValue) {
            NSLog(@"%@",returnValue);
            NSMutableArray * comArr = [CompanyUsers mj_objectArrayWithKeyValuesArray:returnValue[@"companyUsers"]];
            self.addView.saleManArr = comArr;
            [self showAddView];
        } andErrorBlock:^(NSString *msg) {
    
        }];
}
#pragma mark ====== 获取参与者
- (void)getCompanyparticipantsWithComCustomerDetail{
        User *user = [[UserPL shareManager] getLoginUser];
        NSDictionary *dic = @{@"companyId":user.defutecompanyId,
                              @"nature":@"1"
                              };
        [[HttpClient sharedHttpClient] requestGET:@"contact/company/participants" Withdict:dic WithReturnBlock:^(id returnValue) {
            NSLog(@"%@",returnValue);
            NSMutableArray * particModelArr = [Participants mj_objectArrayWithKeyValuesArray:returnValue[@"participants"]];
            self.addView.parManArr = particModelArr;
            [self showAddView];
        } andErrorBlock:^(NSString *msg) {
    
        }];
}

- (void)showAddView{
    self.addView.hidden = NO;
    _sideView.hidden = YES;
}
- (void)dismissAddView{
    self.addView.hidden = YES;
    _sideView.hidden = NO;
    
}
#pragma - mark public method
- (void)showTheView
{
    AppDelegate *app = (AppDelegate *)[[UIApplication  sharedApplication] delegate];
    [app.splitViewController.view addSubview:self];
    _isShow = YES;
    [UIView animateWithDuration:0.2 animations:^{
        
    }];
}

- (void)dismiss
{
    if (!_isShow) return;
    
    _isShow = NO;
    
    
    [UIView animateWithDuration:0.2 animations:^{
        
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        _backBtn.alpha = 0.3;
    }];
}


#pragma mark ===== get
-(BaseTableView *)ListTab{
    if (!_ListTab) {
        _ListTab = [[BaseTableView alloc] initWithFrame:CGRectMake(0, 44, 600, 486) style:UITableViewStylePlain];
        _ListTab.delegate = self;
        _ListTab.dataSource = self;
        _ListTab.backgroundColor = UIColorFromRGB(WhiteColorValue);
        _ListTab.separatorStyle = UITableViewCellSeparatorStyleNone;
        if (@available(iOS 11.0, *)) {
            _ListTab.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {
        }
    }
    return _ListTab;
}

-(UIButton *)backBtn{
    if (!_backBtn) {
        _backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _backBtn.backgroundColor = UIColorFromRGB(BlackColorValue);
        _backBtn.frame =CGRectMake(0, 0, ScreenWidth, ScreenHeight);
        _backBtn.alpha = 0.3;
    }
    return _backBtn;
}

-(CustomerAddManView *)addView{
    if (!_addView) {
        _addView = [[CustomerAddManView alloc]init];
        _addView.hidden = YES;
        _addView.delegate = self;
        [self addSubview:_addView];
    }
    
    return _addView;
}
@end
