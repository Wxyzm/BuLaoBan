//
//  StaffInvitationView.m
//  BuLaoBan
//
//  Created by souxiuyun on 2019/4/26.
//  Copyright © 2019 XX. All rights reserved.
//

#import "StaffInvitationView.h"
#import "CompanyUsers.h"
#import "StaffOperaCell.h"
@interface StaffInvitationView()<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource>
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

@implementation StaffInvitationView{
    UITextField *_phoneTxt;    //电话
    YLButton *_roleBtn;        //角色
    YLButton *_userGroupBtn;   //用户组
    BOOL _isShow;
    NSDictionary *_roleDic;
    NSDictionary *_groupDic;
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
    
    UILabel *toplab= [BaseViewFactory labelWithFrame:CGRectMake(0, 0, 600, 44) textColor:UIColorFromRGB(WhiteColorValue) font:APPFONT(14) textAligment:NSTextAlignmentCenter andtext:@"邀请员工"];
    toplab.backgroundColor = UIColorFromRGB(BlueColorValue);
    [self.sideView addSubview:toplab];
    
    UIButton *closeBtn = [BaseViewFactory setImagebuttonWithWidth:16 imagePath:@"window_close"];
    [closeBtn addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    [self.sideView addSubview:closeBtn];
    closeBtn.frame = CGRectMake(564, 14, 16, 16);
    
    
    
    _phoneTxt  = [BaseViewFactory textFieldWithFrame:CGRectMake(200, 132, 380, 44) font:APPFONT13 placeholder:@"输入邀请员工手机号" textColor:UIColorFromRGB(BlackColorValue) placeholderColor:nil delegate:self];
    _phoneTxt.textAlignment = NSTextAlignmentRight;
    [self.sideView addSubview:_phoneTxt];
    
    _roleBtn = [BaseViewFactory ylButtonWithFrame:CGRectMake(100, 44, 480, 44) font:APPFONT13 title:@"" titleColor:UIColorFromRGB(BlackColorValue) backColor:UIColorFromRGB(WhiteColorValue)];
    [_roleBtn setImage:[UIImage imageNamed:@"down_chose"] forState:UIControlStateNormal];
    _roleBtn.titleLabel.textAlignment = NSTextAlignmentRight;
    [_roleBtn setTitleRect:CGRectMake(0, 0, 465, 44)];
    [_roleBtn setImageRect:CGRectMake(470, 20, 14, 14)];
    [self.sideView addSubview:_roleBtn];
    [_roleBtn setTitle:@"" forState:UIControlStateNormal];
    [_roleBtn addTarget:self action:@selector(roleBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    _userGroupBtn = [BaseViewFactory ylButtonWithFrame:CGRectMake(100, 88, 480, 44) font:APPFONT13 title:@"" titleColor:UIColorFromRGB(BlackColorValue) backColor:UIColorFromRGB(WhiteColorValue)];
    [_userGroupBtn setImage:[UIImage imageNamed:@"down_chose"] forState:UIControlStateNormal];
    _userGroupBtn.titleLabel.textAlignment = NSTextAlignmentRight;
    [_userGroupBtn setTitleRect:CGRectMake(0, 0, 465, 44)];
    [_userGroupBtn setImageRect:CGRectMake(470, 20, 14, 14)];
    [self.sideView addSubview:_userGroupBtn];
    [_userGroupBtn setTitle:@"" forState:UIControlStateNormal];
    [_userGroupBtn addTarget:self action:@selector(userGroupBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    NSArray *titleArr = @[@"员工角色",@"用户组",@"手机号*"];
    for (int i = 0; i<titleArr.count; i++) {
        UILabel *nameLab = [BaseViewFactory labelWithFrame:CGRectMake(20, 44+44*i, 120, 44) textColor:UIColorFromRGB(BlackColorValue) font:APPFONT13 textAligment:NSTextAlignmentLeft andtext:titleArr[i]];
        [self.sideView addSubview:nameLab];
        if (i==2) {
            [nameLab setAttributedText:[GlobalMethod modifyDigitalColor:UIColorFromRGB(RedColorValue) normalColor:UIColorFromRGB(BlackColorValue) aneText:titleArr[i]]];
        }
        UIView *line = [BaseViewFactory viewWithFrame:CGRectMake(20, 88+44*i-0.5, 580, 1) color:UIColorFromRGB(LineColorValue)];
        [self.sideView addSubview:line];
    }
  
    
    UIButton *setBtn = [BaseViewFactory buttonWithFrame:CGRectMake(150, 206, 300, 40) font:APPFONT14 title:@"保存" titleColor:UIColorFromRGB(WhiteColorValue) backColor:UIColorFromRGB(BlueColorValue)];
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
#pragma mark ========= 按钮点击
//保存
- (void)setBtnCLick{
    if (_phoneTxt.text.length<=0) {
        [HUD show:@"输入邀请员工手机号"];
        return;
    }
    NSMutableDictionary *setDic = [[NSMutableDictionary alloc]init];
    [setDic setObject:_phoneTxt.text forKey:@"mobiles"];
    if (_roleDic) {
        [setDic setObject:_roleDic[@"id"] forKey:@"roleId"];
    }
    if (_groupDic) {
        [setDic setObject:_groupDic[@"groupId"] forKey:@"groupId"];
    }
    User *user = [[UserPL shareManager] getLoginUser];
    [HUD showLoading:nil];
    [[HttpClient sharedHttpClient] requestPOST:[NSString stringWithFormat:@"/companys/%@/invite/mobile",user.defutecompanyId] Withdict:setDic WithReturnBlock:^(id returnValue) {
        [HUD cancel];
        [HUD show:@"已发送邀请"];
        [self dismiss];
    } andErrorBlock:^(NSString *msg) {
        [HUD cancel];
    }];
    
}




#pragma - mark ====== netwotk

//员工角色
- (void)roleBtnClick{
    _type = 1;
    User *user = [[UserPL shareManager] getLoginUser];
    [[HttpClient sharedHttpClient] requestGET:[NSString stringWithFormat:@"/companys/%@/roles",user.defutecompanyId] Withdict:nil WithReturnBlock:^(id returnValue) {
        NSLog(@"%@",returnValue);
        _roleArr = returnValue[@"roles"];
        for (NSDictionary *obj in _roleArr.reverseObjectEnumerator) {
            if ([obj[@"id"] intValue] == 1) {
                [_roleArr removeObject:obj];
            }
        }
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
        _sideView = [BaseViewFactory viewWithFrame:CGRectMake(ScreenWidth/2-300, 160, 600, 280) color:UIColorFromRGB(WhiteColorValue)];
        
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
