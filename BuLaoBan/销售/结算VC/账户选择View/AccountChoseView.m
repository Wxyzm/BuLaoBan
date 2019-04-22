//
//  AccountChoseView.m
//  BuLaoBan
//
//  Created by souxiuyun on 2019/4/16.
//  Copyright © 2019 XX. All rights reserved.
//

#import "AccountChoseView.h"
#import "AccountListView.h"
#import "AccountEditView.h"
#import "Accounts.h"

@interface AccountChoseView(){
    BOOL _isShow;
}

@property (nonatomic, strong) UIButton      *backButton;
@property (nonatomic, strong) AccountListView  *listView;
@property (nonatomic, strong) AccountEditView  *editView;

@end

@implementation AccountChoseView

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
    [self addSubview:self.listView];
    [self addSubview:self.editView];
    WeakSelf(self);
    //账户选择界面
    weakself.listView.returnBlock = ^(NSInteger tag, Accounts * _Nonnull account) {
        weakself.listView.hidden = YES;

        if (tag ==0) {
            //关闭
            [weakself dismiss];
        }else if (tag ==1){
            //新增
            self.editView.account = account;
            weakself.editView.hidden = NO;

        }else if (tag ==2)
        {
            //编辑
            self.editView.account = account;
            weakself.editView.hidden = NO;
        }
        else if (tag ==3){
            //选中
            if (weakself.returnBlock) {
                weakself.returnBlock(account);
            }
            [weakself dismiss];
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
        weakself.listView.hidden = NO;
        weakself.editView.hidden = YES;
    };
    
    
}

#pragma mark ======  获取公司账户列表
- (void)loadComAccountList{
    User  *user = [[UserPL shareManager] getLoginUser];
        [[HttpClient sharedHttpClient] requestGET:[NSString stringWithFormat:@"/companys/%@/account",user.defutecompanyId] Withdict:nil WithReturnBlock:^(id returnValue) {
        NSLog(@"%@",returnValue);
        NSMutableArray *listArr = [Accounts mj_objectArrayWithKeyValuesArray:returnValue[@"accounts"]];
        self.listArr = listArr;
        self.listView.dataArr = listArr;
    } andErrorBlock:^(NSString *msg) {
        
    }];
}

-(void)setListArr:(NSMutableArray *)listArr{
    _listArr  = listArr;
    self.listView.dataArr = listArr;
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
    self.listView.hidden = NO;
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

-(AccountListView *)listView{
    if (!_listView) {
        _listView = [[AccountListView alloc]initWithFrame:CGRectMake((ScreenWidth/2)-300, (ScreenHeight/2)-150, 600, 300)];
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
