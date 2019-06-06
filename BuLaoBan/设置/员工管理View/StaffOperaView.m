//
//  StaffOperaView.m
//  BuLaoBan
//
//  Created by souxiuyun on 2019/4/25.
//  Copyright © 2019 XX. All rights reserved.
//

#import "StaffOperaView.h"
#import "CompanyUsers.h"
#import "StaffOperaCell.h"
@interface StaffOperaView()<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UIButton      *backButton;
@property (nonatomic, strong) UIView        *sideView;
@property (nonatomic, strong) UITableView *ListTab;
@property(nonatomic,strong)NSMutableArray *roleArr;   //角色
@property(nonatomic,strong)NSMutableArray *groupArr;   //用户组

/**
 类型   1角色    2用户组
 */
@property(nonatomic,assign)NSInteger type;
@end


@implementation StaffOperaView{
    
    UITextField *_nameTxt;     //名称
    UITextField *_phoneTxt;    //电话
    YLButton *_roleBtn;        //角色
    YLButton *_userGroupBtn;   //用户组
    BOOL _isShow;
    NSDictionary *_roleDic;
    NSDictionary *_groupDic;
    UIButton *_deleteBtn;
    
}


-(instancetype)init{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
        _roleArr = [NSMutableArray arrayWithCapacity:0];
        _groupArr = [NSMutableArray arrayWithCapacity:0];
        [self setup];
    }
    
    return self;
}

- (void)setup{
    [self addSubview:self.backButton];
    [self addSubview:self.sideView];
    
    UILabel *toplab= [BaseViewFactory labelWithFrame:CGRectMake(0, 0, 600, 44) textColor:UIColorFromRGB(WhiteColorValue) font:APPFONT(14) textAligment:NSTextAlignmentCenter andtext:@"设置员工"];
    toplab.backgroundColor = UIColorFromRGB(BlueColorValue);
    [self.sideView addSubview:toplab];
    
    UIButton *closeBtn = [BaseViewFactory setImagebuttonWithWidth:16 imagePath:@"window_close"];
    [closeBtn addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    [self.sideView addSubview:closeBtn];
    closeBtn.frame = CGRectMake(564, 14, 16, 16);
    
    _nameTxt  = [BaseViewFactory textFieldWithFrame:CGRectMake(200, 44, 380, 44) font:APPFONT13 placeholder:@"用户名" textColor:UIColorFromRGB(BlackColorValue) placeholderColor:nil delegate:self];
    _nameTxt.textAlignment = NSTextAlignmentRight;
    [self.sideView addSubview:_nameTxt];
    _nameTxt.userInteractionEnabled = NO;
    
    _phoneTxt  = [BaseViewFactory textFieldWithFrame:CGRectMake(200, 88, 380, 44) font:APPFONT13 placeholder:@"电话" textColor:UIColorFromRGB(BlackColorValue) placeholderColor:nil delegate:self];
    _phoneTxt.textAlignment = NSTextAlignmentRight;
    [self.sideView addSubview:_phoneTxt];
    _phoneTxt.userInteractionEnabled = NO;

    _roleBtn = [BaseViewFactory ylButtonWithFrame:CGRectMake(100, 132, 480, 44) font:APPFONT13 title:@"" titleColor:UIColorFromRGB(BlackColorValue) backColor:UIColorFromRGB(WhiteColorValue)];
    [_roleBtn setImage:[UIImage imageNamed:@"down_chose"] forState:UIControlStateNormal];
    _roleBtn.titleLabel.textAlignment = NSTextAlignmentRight;
    [_roleBtn setTitleRect:CGRectMake(0, 0, 465, 44)];
    [_roleBtn setImageRect:CGRectMake(470, 20, 14, 14)];
    [self.sideView addSubview:_roleBtn];
    [_roleBtn setTitle:@"" forState:UIControlStateNormal];
    [_roleBtn addTarget:self action:@selector(roleBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    _userGroupBtn = [BaseViewFactory ylButtonWithFrame:CGRectMake(100, 176, 480, 44) font:APPFONT13 title:@"" titleColor:UIColorFromRGB(BlackColorValue) backColor:UIColorFromRGB(WhiteColorValue)];
    [_userGroupBtn setImage:[UIImage imageNamed:@"down_chose"] forState:UIControlStateNormal];
    _userGroupBtn.titleLabel.textAlignment = NSTextAlignmentRight;
    [_userGroupBtn setTitleRect:CGRectMake(0, 0, 465, 44)];
    [_userGroupBtn setImageRect:CGRectMake(470, 20, 14, 14)];
    [self.sideView addSubview:_userGroupBtn];
    [_userGroupBtn setTitle:@"" forState:UIControlStateNormal];
    [_userGroupBtn addTarget:self action:@selector(userGroupBtnClick) forControlEvents:UIControlEventTouchUpInside];
  
    NSArray *titleArr = @[@"用户名",@"手机号",@"员工角色",@"用户组"];
    for (int i = 0; i<titleArr.count; i++) {
        UILabel *nameLab = [BaseViewFactory labelWithFrame:CGRectMake(20, 44+44*i, 120, 44) textColor:UIColorFromRGB(BlackColorValue) font:APPFONT13 textAligment:NSTextAlignmentLeft andtext:titleArr[i]];
        [self.sideView addSubview:nameLab];
        UIView *line = [BaseViewFactory viewWithFrame:CGRectMake(20, 88+44*i-0.5, 580, 1) color:UIColorFromRGB(LineColorValue)];
        [self.sideView addSubview:line];
    }
    _deleteBtn = [BaseViewFactory ylButtonWithFrame:CGRectMake(270, 230, 60, 20) font:APPFONT14 title:@"删除员工" titleColor:UIColorFromRGB(BlueColorValue) backColor:UIColorFromRGB(WhiteColorValue)];
    [self.sideView addSubview:_deleteBtn];
    [_deleteBtn addTarget:self action:@selector(deleteBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *setBtn = [BaseViewFactory buttonWithFrame:CGRectMake(150, 280, 300, 40) font:APPFONT14 title:@"保存" titleColor:UIColorFromRGB(WhiteColorValue) backColor:UIColorFromRGB(BlueColorValue)];
    setBtn.layer.cornerRadius = 20;
    [setBtn addTarget:self action:@selector(setBtnCLick) forControlEvents:UIControlEventTouchUpInside];
    [self.sideView addSubview:setBtn];
    
    [self addSubview:self.ListTab];
    self.ListTab.hidden = YES;
    self.ListTab.sd_layout
    .centerXEqualToView(self)
    .topSpaceToView(self, 120)
    .heightIs(530)
    .widthIs(300);
}





#pragma - mark ====== netwotk

//员工角色
- (void)roleBtnClick{
    if ([_model.roleId intValue] == 1) {
        //所有者
        [HUD show:@"所有者不能修改自己身份"];
        return;
    }
    _type = 1;
    User *user = [[UserPL shareManager] getLoginUser];
    [[HttpClient sharedHttpClient] requestGET:[NSString stringWithFormat:@"/companys/%@/roles",user.defutecompanyId] Withdict:nil WithReturnBlock:^(id returnValue) {
        NSLog(@"%@",returnValue);
        _roleArr = returnValue[@"roles"];
        [self.ListTab reloadData];
         _sideView.hidden = YES;
        self.ListTab.hidden = NO;
    } andErrorBlock:^(NSString *msg) {
        
    }];
}

//用户组
- (void)userGroupBtnClick{
    _type = 2;
    ///companys/{companyId}/users/groups
    User *user = [[UserPL shareManager] getLoginUser];
    [[HttpClient sharedHttpClient] requestGET:[NSString stringWithFormat:@"companys/%@/users/groups",user.defutecompanyId] Withdict:nil WithReturnBlock:^(id returnValue) {
        NSLog(@"%@",returnValue);
        _groupArr = returnValue[@"groups"];
        [self.ListTab reloadData];
        _sideView.hidden = YES;
        self.ListTab.hidden = NO;
    } andErrorBlock:^(NSString *msg) {
        
    }];
}

//删除
- (void)deleteBtnClick{
    
    AppDelegate *app = (AppDelegate *)[[UIApplication  sharedApplication] delegate];
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"确定删除该员工？" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [self deleteStaff];
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"取消", nil) style:UIAlertActionStyleCancel handler:NULL];
    [alert addAction:action];
    [alert addAction:cancelAction];
    UIPopoverPresentationController *popPresenter = [alert popoverPresentationController];
    popPresenter.sourceView = app.splitViewController.view;
    popPresenter.sourceRect = app.splitViewController.view.bounds;
    [app.splitViewController presentViewController:alert animated:YES completion:nil];
}


//保存
- (void)setBtnCLick{
    [self changeRole];
}

//删除
- (void)deleteStaff{
    User *user = [[UserPL shareManager] getLoginUser];
    [HUD showLoading:nil];
    [[HttpClient sharedHttpClient] requestDeleteWithURLStr:[NSString stringWithFormat:@"/companys/%@/users/%@",user.defutecompanyId,_model.companyUserId] paramDic:nil WithReturnBlock:^(id returnValue) {
        [HUD cancel];
        [HUD show:@"删除成功"];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"StaffShouldRefresh" object:nil];
        [self dismiss];
    } andErrorBlock:^(NSString *msg) {
         [HUD cancel];
    }];
    
}

//改变角色
- (void)changeRole{
    User *user = [[UserPL shareManager] getLoginUser];
    NSDictionary *dic = @{@"targetUserId":_model.userId,  //目标用户ID*
                          @"targetRoleId":_roleDic[@"id"]?_roleDic[@"id"]:_model.roleId   //目标角色ID*
                          };
    [HUD showLoading:nil];
    [[HttpClient sharedHttpClient] requestPUTWithURLStr:[NSString stringWithFormat:@"/companys/%@/users/role",user.defutecompanyId] paramDic:dic WithReturnBlock:^(id returnValue) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"StaffShouldRefresh" object:nil];
        [self changeGroup];
    } andErrorBlock:^(NSString *msg) {
        [HUD cancel];
    }];
    
    
}

//改变用户组
- (void)changeGroup{
    User *user = [[UserPL shareManager] getLoginUser];
    
    if (!_groupDic) {
        if (_model.groups.count>0) {
             _groupDic = _model.groups[0];
        }else{
            [HUD cancel];
            [HUD show:@"修改成功"];
            [self dismiss];
            return;
        }
       
    }
    NSDictionary *dic = @{
                          @"groupIds":_groupDic[@"groupId"]   //用户组ID*(多个以英文逗号分隔)
                          };
    [[HttpClient sharedHttpClient] requestPUTWithURLStr:[NSString stringWithFormat:@"/companys/%@/users/%@/groups",user.defutecompanyId,_model.userId] paramDic:dic WithReturnBlock:^(id returnValue) {
        [HUD cancel];
        [HUD show:@"修改成功"];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"StaffShouldRefresh" object:nil];
        [self dismiss];
    } andErrorBlock:^(NSString *msg) {
        [HUD cancel];
    }];
    
}



#pragma - mark ====== model

-(void)setModel:(CompanyUsers *)model{
    _model = model;
    _nameTxt.text = model.name;
    _phoneTxt.text = model.mobile;
    [_roleBtn setTitle:model.roleName forState:UIControlStateNormal];
    if (model.groups.count>0) {
        NSDictionary *dic = model.groups[0];
        [_userGroupBtn setTitle:dic[@"name"] forState:UIControlStateNormal];
    }
    //roleId == 1所有者
    if ([model.roleId intValue] == 1) {
        _deleteBtn.hidden = YES;
    }else{
        _deleteBtn.hidden = NO;
    }
    
    
    
}



#pragma - mark public method
- (void)showView
{
    AppDelegate *app = (AppDelegate *)[[UIApplication  sharedApplication] delegate];
    [app.splitViewController.view addSubview:self];
    _isShow = YES;
    [UIView animateWithDuration:0.2 animations:^{
        _sideView.hidden = NO;
    }];
}

- (void)dismiss
{
    if (!_isShow) return;
    _isShow = NO;
    [UIView animateWithDuration:0.2 animations:^{
        _sideView.hidden = YES;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

//关闭选人
- (void)closeBtnClick{
    self.sideView.hidden = NO;
    self.ListTab.hidden = YES;
}

#pragma - mark UITableView

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 60;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [BaseViewFactory viewWithFrame:CGRectMake(0, 0, 300, 60) color:UIColorFromRGB(BlueColorValue)];
    UILabel *lab = [BaseViewFactory labelWithFrame:CGRectMake(0, 0, 300, 60) textColor:UIColorFromRGB(WhiteColorValue) font:APPFONT14 textAligment:NSTextAlignmentCenter andtext:@""];
    [view addSubview:lab];
    UIButton *closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [closeBtn setImage:[UIImage imageNamed:@"window_close"] forState:UIControlStateNormal];
    [closeBtn addTarget:self action:@selector(closeBtnClick) forControlEvents:UIControlEventTouchUpInside];
    closeBtn.frame = CGRectMake(253, 0, 47, 60);
    [view addSubview:closeBtn];
    
    if (_type ==1) {
        lab.text = @"角色";
    }else{
        lab.text = @"用户组";
    }
    
    
    return view;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (_type ==1) {
        return _roleArr.count;
    }else{
        return _groupArr.count;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellid = @"ManSelectCellId";
    StaffOperaCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (!cell) {
        cell= [[StaffOperaCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
    }
    if (_type == 1) {
        NSDictionary *dic = _roleArr[indexPath.row];
        cell.nameLab.text = dic[@"name"];
    }else{
        NSDictionary *dic = _groupArr[indexPath.row];
        cell.nameLab.text = dic[@"name"];

    }
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_type == 1) {
        NSDictionary *dic = _roleArr[indexPath.row];
        [_roleBtn setTitle:dic[@"name"] forState:UIControlStateNormal];
        _roleDic = dic;
    }else{
        NSDictionary *dic = _groupArr[indexPath.row];
        [_userGroupBtn setTitle:dic[@"name"] forState:UIControlStateNormal];
        _groupDic = dic;
    }
    [self closeBtnClick];
}

#pragma mark ========= get

- (UIButton *)backButton
{
    if (!_backButton) {
        _backButton = [[UIButton alloc] initWithFrame:self.bounds];
        _backButton.backgroundColor = [UIColor blackColor];
        _backButton.alpha = 0.3;
    }
    return _backButton;
}

-(UIView *)sideView{
    if (!_sideView) {
        _sideView = [BaseViewFactory viewWithFrame:CGRectMake(ScreenWidth/2-300, 160, 600, 350) color:UIColorFromRGB(WhiteColorValue)];
        
    }
    return _sideView;
}

-(UITableView *)ListTab{
    if (!_ListTab) {
        _ListTab = [[BaseTableView alloc] initWithFrame:CGRectMake(0, 0, 300, 530) style:UITableViewStylePlain];
        _ListTab.delegate = self;
        _ListTab.dataSource = self;
        _ListTab.backgroundColor = UIColorFromRGB(WhiteColorValue);
        _ListTab.separatorStyle = UITableViewCellSeparatorStyleNone;
        _ListTab.bounces = NO;
        
        if (@available(iOS 11.0, *)) {
            _ListTab.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {
            
        }
    }
    return _ListTab;
}




@end
