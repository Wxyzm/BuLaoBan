//
//  MineInfoViewController.m
//  BuLaoBan
//
//  Created by apple on 2019/2/13.
//  Copyright © 2019年 XX. All rights reserved.
//

#import "MineInfoViewController.h"
#import "ChangePwdView.h"
#import "BindingView.h"
#import "MineInfoView.h"
#import "UserInfoPL.h"
#import "UserInfoModel.h"
#import "WXApiManager.h"

@interface MineInfoViewController ()<UITableViewDelegate,UITableViewDataSource,WXAuthDelegate>

@property (nonatomic, strong) BaseTableView *ListTab;
@property (nonatomic, strong) ChangePwdView *changePwdView;
@property (nonatomic, strong) BindingView *bindingView;
@property (nonatomic, strong) MineInfoView *mineInfoView;

@end

@implementation MineInfoViewController{
    
    NSInteger _selectIndex;
    UIButton *_saveBtn;
    BOOL   _WxIsBind;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.needHideNavBar = YES;
    self.view.backgroundColor = UIColorFromRGB(BackColorValue);
    _selectIndex = 0;
    _WxIsBind = NO;
    [self initUI];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loaduserDatas];
}


#pragma mark ==== UI
- (void)initUI{
    
    //顶部View
    UIView *topView = [BaseViewFactory viewWithFrame:CGRectMake(0, 0, ScreenWidth-100, 64) color:UIColorFromRGB(WhiteColorValue)];
    [self.view addSubview:topView];
    UILabel *goodsLab = [BaseViewFactory labelWithFrame:CGRectMake(0, 20, 300, 44) textColor:UIColorFromRGB(BlackColorValue) font:APPFONT17 textAligment:NSTextAlignmentCenter andtext:@"账户信息"];
    [topView addSubview:goodsLab];
    
    UIView *line1 = [BaseViewFactory viewWithFrame:CGRectMake(0, 63, ScreenWidth-100, 1) color:UIColorFromRGB(LineColorValue)];
    [topView addSubview:line1];
    
    UILabel *goodsLab2 = [BaseViewFactory labelWithFrame:CGRectMake(300, 20, ScreenWidth-400, 44) textColor:UIColorFromRGB(BlackColorValue) font:APPFONT17 textAligment:NSTextAlignmentCenter andtext:@"个人资料"];
    [topView addSubview:goodsLab2];
    _saveBtn = [BaseViewFactory buttonWithFrame:CGRectMake(ScreenWidth-160, 20, 40, 43) font:APPFONT15 title:@"保存" titleColor:UIColorFromRGB(BlueColorValue) backColor:UIColorFromRGB(WhiteColorValue)];
    [_saveBtn addTarget:self action:@selector(saveBtnGoodsBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:_saveBtn];
    
    [self.view addSubview:self.ListTab];
    [self.view addSubview:self.mineInfoView];
    [self.view addSubview:self.changePwdView];
    [self.view addSubview:self.bindingView];
    
    UIView *line2 = [BaseViewFactory viewWithFrame:CGRectMake(299.5, 0, 1, ScreenHeight) color:UIColorFromRGB(LineColorValue)];
    [self.view addSubview:line2];
}

#pragma mark ==== 获取用户资料
- (void)loaduserDatas{
    [UserInfoPL Profile_profileGetUserAccountInfoWithReturnBlock:^(id returnValue) {
        NSLog(@"%@",returnValue);
        UserInfoModel *model = [UserInfoModel mj_objectWithKeyValues:returnValue[@"user"]];
        self.mineInfoView.infoModel = model;
        self.mineInfoView.infoDic = returnValue[@"user"];
        NSDictionary *dic = @{@"avatar":returnValue[@"user"][@"avatar"]};
        [[NSNotificationCenter defaultCenter] postNotificationName:@"faceHaveChange" object:dic];
    } andErrorBlock:^(NSString *msg) {
        
    }];
}

#pragma mark ==== 保存

/**
 保存
 */
- (void)saveBtnGoodsBtnClick{
    switch (_selectIndex) {
        case 0:{
            //个人资料保存
            NSDictionary *dic = [self.mineInfoView returnUpDic];
            [self saveInfoWithDic:dic];
            break;
        }
        case 1:{
            //账号绑定
           
            break;
        }
        case 2:{
            //修改密码
            NSDictionary *dic = [self.changePwdView returnUpDic];
            [self changepwdWithDic:dic];
            break;
        }
        default:
            break;
    } 
}
#pragma mark ==== 个人资料保存
- (void)saveInfoWithDic:(NSDictionary *)dic{
    [[HttpClient sharedHttpClient] requestPUTWithURLStr:@"user/account" paramDic:dic WithReturnBlock:^(id returnValue) {
        [HUD show:@"信息已保存"];
        [self loaduserDatas];

    } andErrorBlock:^(NSString *msg) {
        
    }];
}
#pragma mark ==== 修改密码
- (void)changepwdWithDic:(NSDictionary *)dic{
    if (!dic) {
        return;
    }
    [[HttpClient sharedHttpClient] requestPUTWithURLStr:@"/user/account/password" paramDic:dic WithReturnBlock:^(id returnValue) {
        [HUD show:@"密码修改成功"];
    } andErrorBlock:^(NSString *msg) {
        
    }];
}
#pragma mark ====== 获取微信账号绑定信息
- (void)loadWXAccountBind{
    [[HttpClient sharedHttpClient] requestGET:@"/user/account/platform" Withdict:nil WithReturnBlock:^(id returnValue) {
        NSLog(@"%@",returnValue);
        NSArray *accArr = returnValue[@"platform"];
        if (accArr.count>0) {
            for (NSDictionary *dic in accArr) {
                if ([dic[@"platType"] intValue]==1) {
                    //微信
                    if ([dic[@"isBind"] intValue]==1) {
                        [self.bindingView WxIsBind:YES];
                        _WxIsBind = YES;

                    }else{
                        [self.bindingView WxIsBind:NO];
                        _WxIsBind = NO;

                    }
                }
            }
        }
    } andErrorBlock:^(NSString *msg) {
        
    }];
}

#pragma mark ====== 绑定解绑
- (void)bindBtnClick{
    if (_WxIsBind) {
        //解绑
        [self closeWx];
    }else{
        //绑定
        [[WXApiManager sharedManager] sendAuthRequestWithController:self
                                                           delegate:self];
    }
}

#pragma mark - WXAuthDelegate
- (void)wxAuthSucceed:(NSString *)code {
    NSDictionary *dic = @{@"platCode":code,
                          @"platType":@"1",
                          };
    [[HttpClient sharedHttpClient] requestPOST:@"/user/account/platform/bind" Withdict:dic WithReturnBlock:^(id returnValue) {
        [HUD show:@"绑定成功"];
        _WxIsBind = YES;
        [self.bindingView WxIsBind:YES];
    } andErrorBlock:^(NSString *msg) {
        
    }];
}

- (void)wxAuthDenied {
    [HUD show:@"授权失败"];
}

- (void)closeWx{
    NSDictionary *dic = @{
                          @"platType":@"1",
                          };
    [[HttpClient sharedHttpClient] requestPOST:@"/user/account/platform/unbind" Withdict:dic WithReturnBlock:^(id returnValue) {
        [HUD show:@"微信已解绑"];
        _WxIsBind = NO;
        [self.bindingView WxIsBind:NO];
    } andErrorBlock:^(NSString *msg) {
        
    }];
}



- (void)setShowView{
    self.mineInfoView.hidden = YES;
    self.changePwdView.hidden = YES;
    self.bindingView.hidden = YES;
    _saveBtn.hidden = NO;
    if (_selectIndex ==0) {
        self.mineInfoView.hidden = NO;
    }else if (_selectIndex ==1){
        self.bindingView.hidden = NO;
        _saveBtn.hidden = YES;
    }else if (_selectIndex ==2){
        self.changePwdView.hidden = NO;
    }
    
    
}

#pragma mark ====== tableviewdelegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
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
        return 3;
    }
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
   
    if (indexPath.section ==0) {
        static NSString *cellid = @"topCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.textLabel.font = APPFONT16;
            UIImageView *right = [[UIImageView alloc]initWithFrame:CGRectMake(276, 19, 8, 13)];
            right.image = [UIImage imageNamed:@"right"];
            [cell.contentView addSubview:right];
            UIView *line = [BaseViewFactory viewWithFrame:CGRectMake(0, 49, 300, 1) color:UIColorFromRGB(LineColorValue)];
            [cell.contentView addSubview:line];
            
            
        }
        NSArray *arr = @[@"个人资料",@"账号绑定",@"修改密码"];
        cell.textLabel.text = arr[indexPath.row];
        if (indexPath.row == _selectIndex) {
            cell.contentView.backgroundColor = UIColorFromRGB(0xEFF6F9);
        }else{
            cell.contentView.backgroundColor = UIColorFromRGB(WhiteColorValue);

        }
        
        return cell;
    }
    static NSString *cellid = @"logouttopCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.font = APPFONT16;
        UIView *line = [BaseViewFactory viewWithFrame:CGRectMake(0, 49, 300, 1) color:UIColorFromRGB(LineColorValue)];
        [cell.contentView addSubview:line];
        
        
    }
    cell.textLabel.textColor = UIColorFromRGB(RedColorValue);
    cell.textLabel.text = @"退出登录";
    
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 1) {
        _selectIndex = 3;
        [[UserPL shareManager] logout];
    }else{
        if (indexPath.row ==0) {
            [self loaduserDatas];
        }else if (indexPath.row ==1){
            //微信
            [self loadWXAccountBind];
        }
        
        
    }
    _selectIndex = indexPath.row;
    [self setShowView];
    [self.ListTab reloadData];

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

-(ChangePwdView *)changePwdView{
    
    if (!_changePwdView) {
        _changePwdView = [[ChangePwdView alloc]initWithFrame:CGRectMake(300, 64, ScreenWidth-400, 150)];
        _changePwdView.hidden = YES;
    }
    return _changePwdView;
}

-(MineInfoView *)mineInfoView{
    
    if (!_mineInfoView) {
        _mineInfoView = [[MineInfoView alloc]initWithFrame:CGRectMake(300, 64, ScreenWidth-400, 230)];
    }
    return _mineInfoView;
}

-(BindingView *)bindingView{
    
    if (!_bindingView) {
        _bindingView = [[BindingView alloc]initWithFrame:CGRectMake(300, 64,  ScreenWidth-400, 50)];
        _bindingView.hidden = YES;
        UIButton *bindBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_bindingView addSubview:bindBtn];
        bindBtn.frame = CGRectMake(0, 0, ScreenWidth-400, 50);
        [bindBtn addTarget:self action:@selector(bindBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _bindingView;
}

@end
