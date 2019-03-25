//
//  ReceivablesView.m
//  BuLaoBan
//
//  Created by souxiuyun on 2019/3/22.
//  Copyright © 2019 XX. All rights reserved.
//

#import "ReceivablesView.h"
#import "ComCustomer.h"
#import "Accounts.h"
@implementation ReceivablesView{
    
    
}

-(void)awakeFromNib{
    [super awakeFromNib];
    
    [_closeBtn addTarget:self action:@selector(closebtnClick) forControlEvents:UIControlEventTouchUpInside];
    [_saveBtn addTarget:self action:@selector(savebtnClick) forControlEvents:UIControlEventTouchUpInside];

    _accountBtn  = [BaseViewFactory ylButtonWithFrame:CGRectMake(100, 132, 480, 44) font:APPFONT13 title:@"" titleColor:UIColorFromRGB(BlackColorValue) backColor:UIColorFromRGB(WhiteColorValue)];
    [_accountBtn setImage:[UIImage imageNamed:@"down_chose"] forState:UIControlStateNormal];
    _accountBtn.titleLabel.textAlignment = NSTextAlignmentRight;
    [_accountBtn setTitleRect:CGRectMake(0, 0, 465, 44)];
    [_accountBtn setImageRect:CGRectMake(470, 20, 14, 14)];
    [self addSubview:_accountBtn];
    [_accountBtn addTarget:self action:@selector(accountBtnClick) forControlEvents:UIControlEventTouchUpInside];
    _MoneyTxt.keyboardType = UIKeyboardTypeDecimalPad;
    
    for (int i = 0; i<4; i++) {
        UIView *line = [BaseViewFactory viewWithFrame:CGRectMake(20, 87.5+44*i, 580, 1) color:UIColorFromRGB(LineColorValue)];
        [self addSubview:line];
    }

}
#pragma mark ==== set
-(void)setCommodel:(ComCustomer *)commodel{
    _commodel = commodel;
    _nameLab.text = commodel.name;
}

-(void)setAccount:(Accounts *)account{
    _account = account;
    [_accountBtn setTitle:account.accountName forState:UIControlStateNormal];    
}


#pragma mark ==== btnclick

//关闭
- (void)closebtnClick{
    WeakSelf(self);
    if (weakself.returnBlock) {
        weakself.returnBlock(0);
    }
}

//新增
- (void)accountBtnClick{
    WeakSelf(self);
    if (weakself.returnBlock) {
        weakself.returnBlock(1);
    }
}

//保存
- (void)savebtnClick{
    [self saveAllInfo];
}

#pragma mark ===== 保存
- (void)saveAllInfo{
    if (!_account) {
        [HUD show:@"请选择账户"];
        return;
    }
    if (!_commodel) {
        [HUD show:@"客户信息获取失败"];
        return;
    }
    if (_MoneyTxt.text.length<=0) {
        [HUD show:@"请输入收款金额"];
        return;
    }
    NSDate *date=[NSDate date];
    NSDateFormatter *format1=[[NSDateFormatter alloc] init];
    [format1 setDateFormat:@"yyyy-MM-dd"];
    NSString *dateStr;
    dateStr=[format1 stringFromDate:date];
    User *user = [[UserPL shareManager] getLoginUser];
    
    NSDictionary *dic = @{@"companyId":user.defutecompanyId,             //公司ID*
                          @"orderDate":dateStr,                          //收款日期*
                          @"customerId":_commodel.comId,                 //客户ID*
                          @"sellerId":_commodel.salesman,                //业务员ID*
                          @"companyAccountId":_account.companyAccountId, //公司账户ID*
                          @"companyCurrencyId":_commodel.companyCurrencyId,       //币别Id*(默认从客户带过来)
                          @"receiptAmount":[NSString stringWithFormat:@"%.2f",[_MoneyTxt.text floatValue]]            //收款金额
                          };
    [[HttpClient sharedHttpClient] requestPOST:@"/finance/receipt" Withdict:dic WithReturnBlock:^(id returnValue) {
        NSLog(@"%@",returnValue);
        WeakSelf(self);
        if (weakself.returnBlock) {
            weakself.returnBlock(2);
        }
    } andErrorBlock:^(NSString *msg) {
        NSLog(@"%@",msg);
    }];
    
}




@end
