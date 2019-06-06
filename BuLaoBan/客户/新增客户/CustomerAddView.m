//
//  CustomerAddView.m
//  BuLaoBan
//
//  Created by souxiuyun on 2019/3/19.
//  Copyright © 2019 XX. All rights reserved.
//

#import "CustomerAddView.h"
#import "ManSelectCell.h"
#import "ComCustomerDetail.h"
#import "CompanyUsers.h"
#import "Participants.h"
@interface CustomerAddView ()<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *ListTab;

@end
@implementation CustomerAddView{
    
    BOOL _isShow;
    BOOL    isHaveDian;
}

-(instancetype)init{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
        self.backgroundColor = [UIColor clearColor];
        _parArr = [NSMutableArray arrayWithCapacity:0];
        _comArr = [NSMutableArray arrayWithCapacity:0];
        isHaveDian = NO;
        [self setUP];
    }
    return self;
}

- (void)setUP{
    [[NSBundle mainBundle] loadNibNamed:@"CustomerAddView" owner:self options:nil];
    [self addSubview:self.sideView];
    self.sideView.backgroundColor = [UIColor clearColor];

    _salerBtn = [BaseViewFactory ylButtonWithFrame:CGRectMake(100, 308, 480, 44) font:APPFONT13 title:@"" titleColor:UIColorFromRGB(BlackColorValue) backColor:UIColorFromRGB(WhiteColorValue)];
    [_salerBtn setImage:[UIImage imageNamed:@"down_chose"] forState:UIControlStateNormal];
    [_salerBtn setTitle:@"选择" forState:UIControlStateNormal];
    _salerBtn.titleLabel.textAlignment = NSTextAlignmentRight;
    [_salerBtn setTitleRect:CGRectMake(0, 0, 465, 44)];
    [_salerBtn setImageRect:CGRectMake(470, 20, 14, 14)];
    [self.showView addSubview:_salerBtn];
    
    _spartakeBtn= [BaseViewFactory ylButtonWithFrame:CGRectMake(100, 352, 480, 44) font:APPFONT13 title:@"" titleColor:UIColorFromRGB(BlackColorValue) backColor:UIColorFromRGB(WhiteColorValue)];
    [_spartakeBtn setImage:[UIImage imageNamed:@"down_chose"] forState:UIControlStateNormal];
    _spartakeBtn.titleLabel.textAlignment = NSTextAlignmentRight;
    [_spartakeBtn setTitle:@"选择" forState:UIControlStateNormal];

    [_spartakeBtn setTitleRect:CGRectMake(0, 0, 465, 44)];
    [_spartakeBtn setImageRect:CGRectMake(470, 20, 14, 14)];
    [self.showView addSubview:_spartakeBtn];
    for (int i = 0; i<9; i++) {
        UIView *LINE = [BaseViewFactory viewWithFrame:CGRectMake(20, 88+44*i-0.5, 580, 1) color:UIColorFromRGB(LineColorValue)];
        [self.showView addSubview:LINE];
    }
    //按钮点击
    [_closeBtn addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    _saveBtn.tag = 1000;
    _salerBtn.tag = 1001;
    _spartakeBtn.tag = 1002;

    [_saveBtn addTarget:self action:@selector(customerBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [_salerBtn addTarget:self action:@selector(customerBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [_spartakeBtn addTarget:self action:@selector(customerBtnClick:) forControlEvents:UIControlEventTouchUpInside];

    [self addSubview:self.ListTab];
    self.ListTab.hidden = YES;
    self.ListTab.sd_layout
    .centerXEqualToView(self)
    .topSpaceToView(self, 120)
    .heightIs(530)
    .widthIs(300);
}



#pragma - mark set

-(void)setModel:(ComCustomerDetail *)model{
    _model = model;
    _topLab.text = @"编辑客户";
    _moneyTxt.userInteractionEnabled = NO;

    _comNameTxt.text = model.name;
    _linkManTxt.text = model.manager;
    _phoneTxt.text = model.telephone;
    _mailTxt.text = model.email;
    _adressTxt.text = model.address;
    _moneyTxt.text = model.receivableAmount;
    _memoTxt.text = model.remark;
    [_salerBtn setTitle:model.salesmanName forState:UIControlStateNormal];
    if (model.participants.count>0) {
        NSDictionary *dic =model.participants[0];
        [_spartakeBtn setTitle:[dic objectForKey:@"userName"] forState:UIControlStateNormal];
    }
}



-(void)setComArr:(NSMutableArray *)comArr{
    _comArr = comArr;
    [self.ListTab reloadData];
    
}

-(void)setParArr:(NSMutableArray *)parArr{
    _parArr = parArr;
    [self.ListTab reloadData];
}
#pragma - mark 按钮

- (void)customerBtnClick:(UIButton *)btn{
    
    switch (btn.tag) {
        case 1000:{
            //保存
            if (_comNameTxt.text.length<=0) {
                [HUD show:@"客户公司名称为必填项"];
                return;
            }
            if (_salerBtn.titleLabel.text.length<=0) {
                [HUD show:@"业务员为必填项"];
                return;
            }
                   break;
        }
        case 1001:{
            //参与者
            _type = 1;
            self.showView.hidden = YES;
            self.ListTab.hidden = NO;
            [_parArr removeAllObjects];
            [self.ListTab reloadData];

            break;
        }
        case 1002:{
            //业务员
            _type = 2;
            self.showView.hidden = YES;
            self.ListTab.hidden = NO;
            [_comArr removeAllObjects];
            [self.ListTab reloadData];
            break;
        }
        default:
            break;
    }
    WeakSelf(self);
    if (weakself.returnBlock) {
        weakself.returnBlock(btn.tag-1000, _model);
    }
    
}

//关闭选人
- (void)closeBtnClick{
    self.showView.hidden = NO;
    self.ListTab.hidden = YES;
    
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
#pragma - mark textFielddelegaet

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [[IQKeyboardManager sharedManager] goNext];
    return YES;
}

-(BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    return YES;
}

- (NSDictionary *)getSetUPDic{
    NSMutableDictionary *setDic = [[NSMutableDictionary alloc]init];
    [setDic setValue:_comNameTxt.text forKey:@"name"];
    if (_model.nature.length>0) {
        [setDic setValue:_model.nature forKey:@"nature"];
    }else{
        [setDic setValue:@"2" forKey:@"nature"];
    }
    //联系人
    if (_linkManTxt.text.length>0) {
        [setDic setValue:_linkManTxt.text forKey:@"manager"];
    }
    //电话
    if (_phoneTxt.text.length>0) {
        [setDic setValue:_phoneTxt.text forKey:@"telephone"];
    }
     //邮箱
    if (_mailTxt.text.length>0) {
        [setDic setValue:_mailTxt.text forKey:@"email"];
    }
     //地址
    if (_adressTxt.text.length>0) {
        [setDic setValue:_adressTxt.text forKey:@"address"];
    }
    //备注
    if (_memoTxt.text.length>0) {
        [setDic setValue:_memoTxt.text forKey:@"remark"];
    }
   
    
    [setDic setValue:_model.salesman forKey:@"salesman"];
    User *user = [[UserPL shareManager] getLoginUser];
    
    if (!_model.comId) {
        [setDic setValue:user.defutecompanyId forKey:@"companyId"];
        //期初欠款
        if (_moneyTxt.text.length>0) {
            [setDic setValue:_moneyTxt.text forKey:@"receivableAmount"];
        }
    }
    return setDic;
}

- (id)GetParticiDic{
    if ( _model.ParticiUserID.length>0) {
        return @{@"type":@"1",@"userIds":_model.ParticiUserID,@"groupIds":@""};
    }
    return nil;
}

- (void)clearAllInfo{
    _model = [ComCustomerDetail new];
    _topLab.text = @"新增客户";
    _moneyTxt.userInteractionEnabled = YES;
    _comNameTxt.text = @"";
    _linkManTxt.text = @"";
    _phoneTxt.text = @"";
    _mailTxt.text = @"";
    _adressTxt.text = @"";
    _moneyTxt.text = @"";
    [_salerBtn setTitle:@"选择" forState:UIControlStateNormal];
    [_spartakeBtn setTitle:@"选择" forState:UIControlStateNormal];
    _memoTxt.text = @"";
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
        lab.text = @"业务员";
    }else{
         lab.text = @"参与者";
    }
    
    
    return view;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (_type ==1) {
        return _comArr.count;
    }else{
          return _parArr.count;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
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
    if (_type == 1) {
       //1参与者
        CompanyUsers *comUser = _comArr[indexPath.row];
        _model.salesmanName = comUser.name;
        _model.salesman = comUser.userId;
        [_salerBtn setTitle:comUser.name forState:UIControlStateNormal];
    }else{
        //2业务员
        Participants *Partici = _parArr[indexPath.row];
        _model.ParticiUserID = Partici.userId;
        _model.ParticiUserName = Partici.userName;
        [_spartakeBtn setTitle:Partici.userName forState:UIControlStateNormal];
    }
    [self closeBtnClick];
}



#pragma mark   get

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



- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if (!_moneyTxt.isFirstResponder) {
        return YES;
    }
    
    if ([textField.text rangeOfString:@"."].location == NSNotFound)
    {
        isHaveDian = NO;
    }
    if ([string length] > 0)
    {
        unichar single = [string characterAtIndex:0];//当前输入的字符
        if ((single >= '0' && single <= '9') || single == '.')//数据格式正确
        {
            //首字母不能为0和小数点
            if([textField.text length] == 0)
            {
                
                if(single == '.')
                {
                    //  [self showMyMessage:@"亲，第一个数字不能为小数点!"];
                    [textField.text stringByReplacingCharactersInRange:range withString:@""];
                    return NO;
                }
            }
            //输入的字符是否是小数点
            if (single == '.')
            {
                
                if(!isHaveDian)//text中还没有小数点
                {
                    
                    isHaveDian = YES;
                    return YES;
                    
                }else{
                    //   [self showMyMessage:@"亲，您已经输入过小数点了!"];
                    [textField.text stringByReplacingCharactersInRange:range withString:@""];
                    return NO;
                }
                
            }else{
                if (isHaveDian) {//存在小数点
                    
                    //判断小数点的位数
                    NSRange ran = [textField.text rangeOfString:@"."];
                    if (range.location - ran.location <= 2) {
                        return YES;
                    }else{
                        //    [self showMyMessage:@"亲，您最多输入两位小数!"];
                        return NO;
                    }
                    
                }else{
                    return YES;
                }
            }
        }else{//输入的数据格式不正确
            [textField.text stringByReplacingCharactersInRange:range withString:@""];
            return NO;
            
        }
    }
    
    else
        
    {
        return YES;
        
    }
   
    
    
}

@end
