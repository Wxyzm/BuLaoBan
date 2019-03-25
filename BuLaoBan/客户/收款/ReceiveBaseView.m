//
//  ReceiveBaseView.m
//  BuLaoBan
//
//  Created by souxiuyun on 2019/3/23.
//  Copyright © 2019 XX. All rights reserved.
//

#import "ReceiveBaseView.h"
#import "ReceivablesView.h"
#import "AccountListView.h"
#import "AccountEditView.h"
#import "ComCustomer.h"
#import "Accounts.h"
@interface ReceiveBaseView ()

@property (nonatomic, strong) UIButton      *backButton;
@property (nonatomic, strong) ReceivablesView  *receView;
@property (nonatomic, strong) AccountListView  *listView;
@property (nonatomic, strong) AccountEditView  *editView;
@property (nonatomic, strong) NSMutableArray  *viewArr;;

@end


@implementation ReceiveBaseView{
    BOOL _isShow;
}



-(instancetype)init{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
        self.backgroundColor = [UIColor clearColor];
        [self setUP];
    }
    return self;
}
- (void)setUP{
    [self addSubview:self.backButton];
    [self addSubview:self.receView];
    [self addSubview:self.listView];
    [self addSubview:self.editView];
  
    _viewArr = [NSMutableArray arrayWithObjects:self.receView,self.listView,self.editView, nil];
    //收款界面
    WeakSelf(self);
    weakself.receView.returnBlock = ^(NSInteger tag) {
        if (tag ==0||tag ==2) {
            //关闭
            [weakself dismiss];
        }else{
            //选择账户
            [weakself showViewWithTag:1];

        }
    };
      //账户选择界面
    weakself.listView.returnBlock = ^(NSInteger tag, Accounts * _Nonnull account) {
        if (tag ==0) {
            //关闭
            self.editView.account = account;
            [weakself showViewWithTag:0];
        }else if (tag ==1){
            //新增
            self.editView.account = account;
            [weakself showViewWithTag:2];
        }else if (tag ==2)
        {
            //编辑
            self.editView.account = account;
            [weakself showViewWithTag:2];
        }
        else if (tag ==3){
             //选中
            self.receView.account = account;
            [weakself showViewWithTag:0];

        }
        
    };
   //新增编辑
    weakself.editView.returnBlock = ^(NSInteger tag, Accounts * _Nonnull account) {
        if (tag ==0) {
            //关闭
        }else if (tag ==1){
            //新增
            [self loadComAccountList];
        }else if (tag ==2){
            //编辑
             [self loadComAccountList];
        }
        [weakself showViewWithTag:1];

    };
    
    
}



- (void)showViewWithTag:(NSInteger )tag{
    
    for (UIView *view in _viewArr) {
        view.hidden = YES;
    }
    UIView *shview = _viewArr[tag];
    shview.hidden = NO;
}


#pragma mark ========= set
-(void)setCommodel:(ComCustomer *)commodel{
    _commodel = commodel;
    //收款view赋值
    self.receView.commodel = commodel;
    self.editView.comId = _commodel.comId;
    self.editView.companyCurrencyId = _commodel.companyCurrencyId;
}

-(void)setListArr:(NSMutableArray *)listArr{
    _listArr = listArr;
    self.listView.dataArr = listArr;
    
}

#pragma mark ========= 获取列表
#pragma mark ======  获取公司账户列表
- (void)loadComAccountList{
    
    [[HttpClient sharedHttpClient] requestGET:[NSString stringWithFormat:@"/companys/%@/account",_commodel.comId] Withdict:nil WithReturnBlock:^(id returnValue) {
        NSLog(@"%@",returnValue);
        NSMutableArray *listArr = [Accounts mj_objectArrayWithKeyValuesArray:returnValue[@"accounts"]];
        self.listArr = listArr;
        self.listView.dataArr = listArr;
    } andErrorBlock:^(NSString *msg) {
        
    }];
    
    
}



#pragma mark ========= menthod

- (void)dismiss{
    if (!_isShow) return;
    _isShow = NO;
    [UIView animateWithDuration:0.2 animations:^{
        
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        _backButton.alpha = 0.3;
    }];
    
    
}

- (void)showInView{
    AppDelegate *app = (AppDelegate *)[[UIApplication  sharedApplication] delegate];
    [app.splitViewController.view addSubview:self];
    _isShow = YES;
    [UIView animateWithDuration:0.2 animations:^{
        
    }];
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

-(ReceivablesView *)receView{
    
    if (!_receView) {
        _receView = [[[NSBundle mainBundle] loadNibNamed:@"ReceivablesView" owner:self options:nil] lastObject];
        _receView.frame = CGRectMake((ScreenWidth/2)-300, (ScreenHeight/2)-150, 600, 300);
    }
    
    return _receView;
}

-(AccountListView *)listView{
    if (!_listView) {
        _listView = [[AccountListView alloc]initWithFrame:CGRectMake((ScreenWidth/2)-300, (ScreenHeight/2)-150, 600, 300)];
        _listView.hidden = YES;

    }
    return _listView;
}

-(AccountEditView *)editView{
    if (!_editView) {
        _editView = [[AccountEditView alloc]initWithFrame:CGRectMake((ScreenWidth/2)-300, (ScreenHeight/2)-140, 600, 280)];
        _editView.hidden = YES;

    }
    return _editView;
}


@end
