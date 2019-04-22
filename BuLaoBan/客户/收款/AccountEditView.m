//
//  AccountEditView.m
//  BuLaoBan
//
//  Created by souxiuyun on 2019/3/22.
//  Copyright © 2019 XX. All rights reserved.
//

#import "AccountEditView.h"
#import "Accounts.h"

@interface AccountEditView()<UITextFieldDelegate>

@property (nonatomic,strong) UILabel *nmeLab;




@end

@implementation AccountEditView{
    
    UILabel *_toplab;
    YLButton *_typeBtn;
    UITextField *_nameTxt;
    UITextField *_numberTxt;
    UIView *_TypeView;
}

-(instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = UIColorFromRGB(WhiteColorValue);
        [self setUP];
    }
    return self;
}

- (void)setUP{
    
    _toplab = [BaseViewFactory labelWithFrame:CGRectMake(0, 0, 600, 44) textColor:UIColorFromRGB(WhiteColorValue) font:APPFONT(14) textAligment:NSTextAlignmentCenter andtext:@"新增账户"];
    _toplab.backgroundColor = UIColorFromRGB(BlueColorValue);
    [self addSubview:_toplab];

    _typeBtn = [BaseViewFactory ylButtonWithFrame:CGRectMake(380, 44, 200, 44) font:APPFONT13 title:@"选择" titleColor:UIColorFromRGB(BlueColorValue) backColor:UIColorFromRGB(WhiteColorValue)];
    [self addSubview:_typeBtn];
    [_typeBtn addTarget:self action:@selector(typeBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [_typeBtn setTitleRect:CGRectMake(0, 0, 200, 44)];
    _typeBtn.titleLabel.textAlignment = NSTextAlignmentRight;
    
    UIButton *closeBtn = [BaseViewFactory setImagebuttonWithWidth:16 imagePath:@"window_close"];
    [closeBtn addTarget:self action:@selector(closeBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:closeBtn];
    closeBtn.frame = CGRectMake(564, 14, 16, 16);
    
    _nameTxt = [BaseViewFactory textFieldWithFrame:CGRectMake(120, 88, 460, 44) font:APPFONT13 placeholder:@"输入账户名称" textColor:UIColorFromRGB(BlackColorValue) placeholderColor:nil delegate:self];
    _nameTxt.textAlignment = NSTextAlignmentRight;
    [self addSubview:_nameTxt];

    _numberTxt = [BaseViewFactory textFieldWithFrame:CGRectMake(120, 132, 460, 44) font:APPFONT13 placeholder:@"输入账号" textColor:UIColorFromRGB(BlackColorValue) placeholderColor:nil delegate:self];
    _numberTxt.textAlignment = NSTextAlignmentRight;
    [self addSubview:_numberTxt];
    
    NSArray *arr = @[@"账户类型",@"账户名称",@"账号"];
    for (int i = 0; i<3; i++) {
        UILabel *lab = [BaseViewFactory labelWithFrame:CGRectMake(20, 44+44*i, 100, 44) textColor:UIColorFromRGB(BlackColorValue) font:APPFONT(13) textAligment:NSTextAlignmentLeft andtext:arr[i]];
        [self addSubview:lab];
        
        UIView *line = [BaseViewFactory viewWithFrame:CGRectMake(20, 87.5+44*i, 580, 1) color:UIColorFromRGB(LineColorValue)];
        [self addSubview:line];
    }

    UIButton *saveBtn = [BaseViewFactory buttonWithFrame:CGRectMake(150, 206, 300, 40) font:APPFONT14 title:@"保存" titleColor:UIColorFromRGB(WhiteColorValue) backColor:UIColorFromRGB(BlueColorValue)];
     [self addSubview:saveBtn];
    [saveBtn addTarget:self action:@selector(saveBtnClick) forControlEvents:UIControlEventTouchUpInside];

    _TypeView = [BaseViewFactory viewWithFrame:CGRectMake(500, 44, 100, 132) color:UIColorFromRGB(WhiteColorValue)];
    NSArray *titleArr = @[@"现金",@"银行",@"网络支付平台"];
    for (int i = 0; i<3; i++) {
        UIButton *typeBtn = [BaseViewFactory buttonWithFrame:CGRectMake(0, 44*i, 100, 44) font:APPFONT13 title:titleArr[i] titleColor:UIColorFromRGB(BlackColorValue) backColor:UIColorFromRGB(WhiteColorValue)];
        [_TypeView addSubview:typeBtn];
        typeBtn.tag = 1000 +i;
        [typeBtn addTarget:self action:@selector(typeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    [self addSubview:_TypeView];
    _TypeView.hidden = YES;
}


#pragma mark -- 按钮点击

- (void)closeBtnClick{
    WeakSelf(self);
    if (weakself.returnBlock) {
        weakself.returnBlock(0, [Accounts new]);
    }
}

- (void)saveBtnClick{
    if ([_typeBtn.titleLabel.text isEqualToString:@"选择"]) {
        [HUD show:@"请选择账户类型"];
        return;
    }
    if (_nameTxt.text.length<=0) {
        [HUD show:@"请输入账户名称"];
        return;
    }
    if (_numberTxt.text.length<=0) {
        [HUD show:@"请输入账号"];
        return;
    }
    if (_account.accountName) {
        //修改
        [self getUsercompanyCurrencyIdWithTag:2];

    }else{
        //新增
        [self getUsercompanyCurrencyIdWithTag:1];
    }
   
}

- (void)typeBtnClick{
    _TypeView.hidden = NO;

    
}

- (void)typeBtnClick:(UIButton *)btn{
    NSInteger tag =btn.tag - 1000;
    NSArray *titleArr = @[@"现金",@"银行",@"网络支付平台"];
    [_typeBtn setTitle:titleArr[tag] forState:UIControlStateNormal];
    _TypeView.hidden = YES;

}


#pragma mark -- set
-(void)setAccount:(Accounts *)account{
    _account = account;
    if (!account) {
        return;
    }
    // 类型（1：现金2：银行3：网络支付平台）
    if ([account.type intValue]==1) {
        [_typeBtn setTitle:@"现金" forState:UIControlStateNormal];
    }else if ([account.type intValue]==2){
        [_typeBtn setTitle:@"银行" forState:UIControlStateNormal];

    }else if ([account.type intValue]==3){
        [_typeBtn setTitle:@"网络支付平台" forState:UIControlStateNormal];
        
    }
    _nameTxt.text = account.accountName;
    _numberTxt.text = account.accountNumber;
}

#pragma mark ======== 保存
/**
 新增
 */
- (void)addNewAccountWithId:(NSString *)companyCurrencyId{
    NSString *type;
    if ([_typeBtn.titleLabel.text isEqualToString:@"现金"]) {
        type = @"1";
    }else if ([_typeBtn.titleLabel.text isEqualToString:@"银行"]){
        type = @"2";
    }else{
        type = @"3";
    }
    WeakSelf(self);
    User *user = [[UserPL shareManager] getLoginUser];
    NSDictionary *dic = @{@"companyId":user.defutecompanyId,@"accountName":_nameTxt.text,@"accountNumber":_numberTxt.text,@"companyCurrencyId":companyCurrencyId,@"type":type};
    [[HttpClient sharedHttpClient] requestPOST:@"/companys/account" Withdict:dic WithReturnBlock:^(id returnValue) {
        [HUD show:@"添加成功"];
        if (weakself.returnBlock) {
            weakself.returnBlock(1, _account);
        }
        NSLog(@"%@",returnValue);
    } andErrorBlock:^(NSString *msg) {
        
    }];
}

- (void)getUsercompanyCurrencyIdWithTag:(NSInteger)tag{
    User *user = [[UserPL shareManager] getLoginUser];
    [[HttpClient sharedHttpClient] requestGET:[NSString stringWithFormat:@"/companys/%@/currency",user.defutecompanyId] Withdict:nil WithReturnBlock:^(id returnValue) {
        NSArray *currArr = returnValue[@"currencies"];
        if (currArr.count<0) {
            [HUD show:@"获取货币种类失败"];
            return ;
        }
        NSDictionary *dic;
        for (NSDictionary *cuDic in currArr) {
            if ([cuDic[@"currencyName"] isEqualToString:@"人民币"]) {
                dic = cuDic;
            }
        }
        if (tag == 1) {
            //新增
            [self addNewAccountWithId:dic[@"companyCurrencyId"]];
        }else{
            //n编辑
            [self changeAccountWithId:dic[@"companyCurrencyId"]];
        }
        
    } andErrorBlock:^(NSString *msg) {
        
    }];
    
    
}



/**
 修改
 */
- (void)changeAccountWithId:(NSString *)companyCurrencyId{
    NSString *type;
    if ([_typeBtn.titleLabel.text isEqualToString:@"现金"]) {
        type = @"1";
    }else if ([_typeBtn.titleLabel.text isEqualToString:@"银行"]){
        type = @"2";
    }else{
        type = @"3";
    }
    WeakSelf(self);

    NSDictionary *dic = @{@"accountName":_nameTxt.text,@"accountNumber":_numberTxt.text,@"companyCurrencyId":companyCurrencyId,@"type":type};
    [[HttpClient sharedHttpClient] requestPUTWithURLStr:[NSString stringWithFormat:@"/companys/account/%@",_account.companyAccountId] paramDic:dic WithReturnBlock:^(id returnValue) {
         [HUD show:@"修改成功"];
        if (weakself.returnBlock) {
            weakself.returnBlock(1, _account);
        }
        NSLog(@"%@",returnValue);
    } andErrorBlock:^(NSString *msg) {
        
    }];
    
}








@end
