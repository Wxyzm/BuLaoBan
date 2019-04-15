//
//  AddCustomerView.m
//  BuLaoBan
//
//  Created by souxiuyun on 2019/4/7.
//  Copyright © 2019 XX. All rights reserved.
//

#import "AddCustomerView.h"
#import "CustomerAddView.h"

#import "AddCusCell.h"
#import "AddCusModel.h"
#import "Participants.h"
#import "CompanyUsers.h"
#import "ManSelectCell.h"

@interface AddCustomerView ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UIButton      *backButton;

@property (nonatomic, strong) UIView      *sideView;

@property (nonatomic, strong) BaseTableView *ListTab;               //列表

@property (nonatomic, strong) BaseTableView *manListTab;               //列表




@end


@implementation AddCustomerView{
    NSMutableArray *_dataArr;
    NSMutableArray *_parArr;
    NSMutableArray *_comArr;

    BOOL _isShow;
    NSInteger _type;
}

-(instancetype)init{
    
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
        _dataArr = [NSMutableArray arrayWithCapacity:0];
        _parArr = [NSMutableArray arrayWithCapacity:0];
        _comArr = [NSMutableArray arrayWithCapacity:0];
        [self setUP];
    }
    
    return self;
}

- (void)setUP{
    [self addSubview:self.backButton];
    _sideView = [BaseViewFactory viewWithFrame:CGRectMake(ScreenWidth-300, 86, 300, 466) color:UIColorFromRGB(WhiteColorValue)];
    [self addSubview:_sideView];
    [_sideView addSubview:self.ListTab];
    
    UILabel *nameLab = [BaseViewFactory labelWithFrame:CGRectMake(0, 0, 300, 44) textColor:UIColorFromRGB(WhiteColorValue) font:APPFONT14 textAligment:NSTextAlignmentCenter andtext:@"新增客户"];
    nameLab.backgroundColor = UIColorFromRGB(BlueColorValue);
    [_sideView addSubview:nameLab];
    UIButton *closeBtn = [BaseViewFactory setImagebuttonWithWidth:13 imagePath:@"window_close"];
    [closeBtn addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    closeBtn.frame = CGRectMake(257, 0, 43, 43);
    [_sideView addSubview:closeBtn];
    
    UIButton *saveBtn = [BaseViewFactory buttonWithFrame:CGRectMake(0, 426, 300, 40) font:APPFONT14 title:@"保存" titleColor:UIColorFromRGB(WhiteColorValue) backColor:UIColorFromRGB(BlueColorValue)];
    [saveBtn addTarget:self action:@selector(saveBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [_sideView addSubview:saveBtn];
    
    
    NSArray *titleArr = @[@"名称*",@"联系人",@"手机号",@"邮箱",@"地址",@"业务员",@"参与者",@"备注"];

    for (int i = 0; i<titleArr.count; i++) {
        AddCusModel *model = [[AddCusModel alloc]init];
        model.name = titleArr[i];
        if ([model.name isEqualToString:@"业务员"]||[model.name isEqualToString:@"参与者"]) {
            model.tag =1;
        }
        [_dataArr addObject:model];
    }
    [self.ListTab reloadData];
    
    [self addSubview:self.manListTab];
    self.manListTab.hidden = YES;
    self.manListTab.sd_layout
    .centerXEqualToView(self)
    .topSpaceToView(self, 120)
    .heightIs(530)
    .widthIs(300);
    
}

#pragma - mark btnCLick

- (void)closeBtnClick{
    self.manListTab .hidden = YES;
    

}

- (void)selectBtnClick:(YLButton *)btn{
    if (btn.tag == 1005) {
        [self getCompanyUsersWithComCustomerDetail];
    }else if (btn.tag == 1006){
        [self getCompanyparticipantsWithComCustomerDetail];

    }
    
    
}
#pragma mark ====== 获取业务员
- (void)getCompanyUsersWithComCustomerDetail{
    [_comArr removeAllObjects];
    [self.manListTab reloadData];
    NSDictionary *dic = @{@"pageNo":@"1",@"pageSize":@"5000",};
    User *user = [[UserPL shareManager] getLoginUser];
    [[HttpClient sharedHttpClient] requestGET:[NSString stringWithFormat:@"/companys/%@/users",user.defutecompanyId] Withdict:dic WithReturnBlock:^(id returnValue) {
        NSLog(@"%@",returnValue);
        _comArr = [CompanyUsers mj_objectArrayWithKeyValuesArray:returnValue[@"companyUsers"]];
        _type = 1;
        self.manListTab.hidden = NO;

        [self.manListTab reloadData];
    } andErrorBlock:^(NSString *msg) {
        
    }];
}
#pragma mark ====== 获取参与者
- (void)getCompanyparticipantsWithComCustomerDetail{
    User *user = [[UserPL shareManager] getLoginUser];
    NSDictionary *dic = @{@"companyId":user.defutecompanyId,
                          @"nature":@"1"
                          };
    [_parArr removeAllObjects];
    [self.manListTab reloadData];

    [[HttpClient sharedHttpClient] requestGET:@"contact/company/participants" Withdict:dic WithReturnBlock:^(id returnValue) {
        NSLog(@"%@",returnValue);
        _parArr = [Participants mj_objectArrayWithKeyValuesArray:returnValue[@"participants"]];
        _type = 0;
        self.manListTab.hidden = NO;
        [self.manListTab reloadData];
    } andErrorBlock:^(NSString *msg) {
        
    }];
}
#pragma - mark UITableView

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (tableView ==self.ListTab) {
        return 0.0001;
    }
    return 60;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (tableView ==self.ListTab) {
        return [UIView new];
    }
    UIView *view = [BaseViewFactory viewWithFrame:CGRectMake(0, 0, 300, 60) color:UIColorFromRGB(BlueColorValue)];
    UILabel *lab = [BaseViewFactory labelWithFrame:CGRectMake(0, 0, 300, 60) textColor:UIColorFromRGB(WhiteColorValue) font:APPFONT14 textAligment:NSTextAlignmentCenter andtext:@""];
    [view addSubview:lab];
    UIButton *closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [closeBtn setImage:[UIImage imageNamed:@"window_close"] forState:UIControlStateNormal];
    [closeBtn addTarget:self action:@selector(closeBtnClick) forControlEvents:UIControlEventTouchUpInside];
    closeBtn.frame = CGRectMake(253, 0, 47, 60);
    [view addSubview:closeBtn];
    
    if (_type ==1) {
        lab.text = @"业务员";
    }else{
        lab.text = @"参与者";
    }
    
    
    return view;
}



-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    if (tableView ==self.ListTab) {
       return _dataArr.count;
    }
    if (_type ==1) {
        return _comArr.count;
    }else{
        return _parArr.count;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView ==self.ListTab) {
        return 44;
    }
    return 60;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (tableView ==self.ListTab) {
        static NSString *cellid = @"cellid";
        AddCusCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
        if (!cell) {
            cell = [[AddCusCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
        }
        cell.model = _dataArr[indexPath.row];
        cell.selectBtn.tag = 1000+indexPath.row;
        [cell.selectBtn addTarget:self action:@selector(selectBtnClick:) forControlEvents:UIControlEventTouchUpInside];

        return cell;
    }
    
    static NSString *cellid = @"ManSelectCellId";
    ManSelectCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (!cell) {
        cell= (ManSelectCell *)[[[NSBundle  mainBundle]  loadNibNamed:@"ManSelectCell" owner:self options:nil]  lastObject];
    }
    if (_type == 1) {
        cell.companyUsers  = _comArr[indexPath.row];
    }else{
        cell.participants = _parArr[indexPath.row];
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
     if (tableView ==self.ListTab) {
        
         return;
     }
    
    if (_type == 1) {
        //@"业务员";
        CompanyUsers *comUser = _comArr[indexPath.row];
        for (AddCusModel *model in _dataArr) {
            if ([model.name isEqualToString:@"业务员"]) {
                model.StrValue = comUser.name;
                model.IdValue = comUser.userId;
            }
        }
    }else{
        //@"参与者";
        Participants *Partici = _parArr[indexPath.row];
        for (AddCusModel *model in _dataArr) {
             if ([model.name isEqualToString:@"参与者"]){
                 model.StrValue = Partici.userName;
                 model.IdValue = Partici.userId;
            }
        }
    }
    self.manListTab .hidden = YES;
    [self.ListTab reloadData];
    
}

#pragma mark ========= 保存
- (void)saveBtnClick{
    //    NSArray *setArr = @[@"name",@"manager",@"telephone",@"email",@"address",@"",@"",@"remark"];

    AddCusModel *model = _dataArr[0];
    if (model.StrValue.length<=0) {
        [HUD show:@"请输入客户名称"];
        return;
    }
    NSMutableDictionary *setDic = [[NSMutableDictionary alloc]init];
    [setDic setValue:model.StrValue forKey:@"name"];
    User *user = [[UserPL shareManager] getLoginUser];
    [setDic setValue:user.defutecompanyId forKey:@"companyId"];
    [setDic setValue:@"2" forKey:@"nature"];

    for (int i =0; i<_dataArr.count; i++) {
        AddCusModel *model = _dataArr[i];
        switch (i) {
            case 0:{
                [setDic setValue:model.StrValue forKey:@"name"];
                break;
            }
            case 1:{
                if (model.StrValue.length>0) {
                    [setDic setValue:model.StrValue forKey:@"manager"];
                }
                break;
            }
            case 2:{
                if (model.StrValue.length>0) {
                    [setDic setValue:model.StrValue forKey:@"telephone"];
                }
                break;
            }
            case 3:{
                if (model.StrValue.length>0) {
                    [setDic setValue:model.StrValue forKey:@"email"];
                }
                break;
            }
            case 4:{
                if (model.StrValue.length>0) {
                    [setDic setValue:model.StrValue forKey:@"address"];
                }
                break;
            }
            case 5:{
                if (model.IdValue.length>0) {
                    [setDic setValue:model.IdValue forKey:@"salesman"];
                }
                break;
            }
            case 6:{
                if (model.IdValue.length>0) {
                    [setDic setValue:model.IdValue forKey:@"participants"];
                }
                break;
            }
            case 7:{
                if (model.StrValue.length>0) {
                    [setDic setValue:model.StrValue forKey:@"remark"];
                }
                break;
            }
            
            default:
                break;
        }
    }
    
    [self addcontactComWiyhDic:setDic];
}
#pragma mark ====== 添加联系公司
- (void)addcontactComWiyhDic:(NSDictionary *)dic{
    [[HttpClient sharedHttpClient] requestPOST:@"/contact/company" Withdict:dic WithReturnBlock:^(id returnValue) {
        [HUD show:@"添加成功"];
        WeakSelf(self);
        if (weakself.returnBlock) {
            weakself.returnBlock(0);
        }
        
        [self dismiss];
    } andErrorBlock:^(NSString *msg) {
        
    }];
}
#pragma mark ========= public method

- (void)showinView:(UIView *)view{
    [view addSubview:self];
    _isShow = YES;
}
- (void)dismiss{
    if (!_isShow) return;
    _isShow = NO;
    [self removeFromSuperview];
}



#pragma mark ========= get

- (UIButton *)backButton
{
    if (!_backButton) {
        _backButton = [[UIButton alloc] initWithFrame:self.bounds];
        _backButton.backgroundColor = [UIColor clearColor];
        [_backButton addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    }
    return _backButton;
}
-(BaseTableView *)ListTab{
    if (!_ListTab) {
        _ListTab = [[BaseTableView alloc] initWithFrame:CGRectMake(0, 44, 300, 382) style:UITableViewStylePlain];
        _ListTab.delegate = self;
        _ListTab.dataSource = self;
        _ListTab.backgroundColor = UIColorFromRGB(WhiteColorValue);
        _ListTab.separatorStyle = UITableViewCellSeparatorStyleNone;
        _ListTab.sectionIndexBackgroundColor = [UIColor clearColor];
        
        if (@available(iOS 11.0, *)) {
            _ListTab.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {
        }
    }
    return _ListTab;
}



-(UITableView *)manListTab{
    if (!_manListTab) {
        _manListTab = [[BaseTableView alloc] initWithFrame:CGRectMake(0, 0, 300, 530) style:UITableViewStylePlain];
        _manListTab.delegate = self;
        _manListTab.dataSource = self;
        _manListTab.backgroundColor = UIColorFromRGB(WhiteColorValue);
        _manListTab.separatorStyle = UITableViewCellSeparatorStyleNone;
        _manListTab.bounces = NO;
        
        if (@available(iOS 11.0, *)) {
            _manListTab.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {
            
        }
    }
    return _manListTab;
}

@end
