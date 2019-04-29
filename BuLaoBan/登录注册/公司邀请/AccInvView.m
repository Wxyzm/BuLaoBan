//
//  AccInvView.m
//  BuLaoBan
//
//  Created by souxiuyun on 2019/4/26.
//  Copyright © 2019 XX. All rights reserved.
//

#import "AccInvView.h"

@interface AccInvView()
@property (nonatomic, strong) UIButton      *backButton;
@property (nonatomic, strong) UIView        *sideView;
@end

@implementation AccInvView{
    
    UILabel *_toplab;
    UILabel *_comlab;
    BOOL _isShow;

}

-(instancetype)init{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
        [self setup];
    }
    
    return self;
}

- (void)setup{
    [self addSubview:self.backButton];
    [self addSubview:self.sideView];
    _toplab = [BaseViewFactory labelWithFrame:CGRectMake(0, 0, 600, 44) textColor:UIColorFromRGB(WhiteColorValue) font:APPFONT(14) textAligment:NSTextAlignmentCenter andtext:@"设置员工"];
    _toplab.backgroundColor = UIColorFromRGB(BlueColorValue);
    [self.sideView addSubview:_toplab];
    
    UIButton *closeBtn = [BaseViewFactory setImagebuttonWithWidth:16 imagePath:@"window_close"];
    [closeBtn addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    [self.sideView addSubview:closeBtn];
    closeBtn.frame = CGRectMake(564, 14, 16, 16);
    
    UILabel *nameLab = [BaseViewFactory labelWithFrame:CGRectMake(20, 54, 100, 44) textColor:UIColorFromRGB(BlackColorValue) font:APPFONT(13) textAligment:NSTextAlignmentLeft andtext:@"公司名称"];
    [self.sideView addSubview:nameLab];
    
    _comlab  = [BaseViewFactory labelWithFrame:CGRectMake(120, 54, 460, 44) textColor:UIColorFromRGB(0x9B9B9B) font:APPFONT(13) textAligment:NSTextAlignmentRight andtext:@""];
    [self.sideView addSubview:_comlab];
    
    UIView *line = [BaseViewFactory viewWithFrame:CGRectMake(20, 98, 580, 1) color:UIColorFromRGB(LineColorValue)];
    [self.sideView addSubview:line];
    
    
    UIButton *refuseBtn = [BaseViewFactory buttonWithFrame:CGRectMake(85, 126, 200, 40) font:APPFONT14 title:@"拒绝" titleColor:UIColorFromRGB(WhiteColorValue) backColor:UIColorFromRGB(0xFF4949)];
    refuseBtn.layer.cornerRadius = 2;
    [refuseBtn addTarget:self action:@selector(refuseCLick) forControlEvents:UIControlEventTouchUpInside];
    [self.sideView addSubview:refuseBtn];

    UIButton *accBtn = [BaseViewFactory buttonWithFrame:CGRectMake(315, 126, 200, 40) font:APPFONT14 title:@"同意" titleColor:UIColorFromRGB(WhiteColorValue) backColor:UIColorFromRGB(BlueColorValue)];
    accBtn.layer.cornerRadius = 2;
    [accBtn addTarget:self action:@selector(accBtnCLick) forControlEvents:UIControlEventTouchUpInside];
    [self.sideView addSubview:accBtn];
}

/*
 {
 code = 200;
 companys =     (
 {
 companyId = 3775;
 companyInfoAuthority = 1;
 companyUserAuthority = 1;
 deleteAuthority = 1;
 endTime = "";
 manageAuthority = 1;
 name = "\U793a\U4f8b\U6837\U54c1\U95f4";
 payAuthority = 1;
 payStatus = 0;
 roleId = 1;
 type = 1;
 }
 );
 inviteCompanys =     (
 {
 companyName = yxzf;
 invitationCode = "PeRIwXU13AMCYv6p5aQRXCurX/Digy8c1cANecEiOAq6p2RVuJEFnTW3BdGrUYkU";
 inviterName = xx;
 }
 );
 joinedCompanys =     (
 );
 manageCompanys =     (
 {
 companyId = 3775;
 endTime = "";
 name = "\U793a\U4f8b\U6837\U54c1\U95f4";
 payStatus = 0;
 roleType = 0;
 type = 1;
 }
 );
 message = "";
 }
 */

//拒绝
- (void)refuseCLick{
    NSDictionary *dic = @{@"invitationCode":_infoDic[@"invitationCode"],@"isAgree":@"0"};
    [[HttpClient sharedHttpClient] requestPOST:@"/companys/users" Withdict:dic WithReturnBlock:^(id returnValue) {
        [HUD show:@"已拒绝邀请"];
    } andErrorBlock:^(NSString *msg) {
        
    }];
}

- (void)accBtnCLick{
    NSDictionary *dic = @{@"invitationCode":_infoDic[@"invitationCode"],@"isAgree":@"1"};
    [[HttpClient sharedHttpClient] requestPOST:@"/companys/users" Withdict:dic WithReturnBlock:^(id returnValue) {
        [HUD show:@"已接受邀请"];
        [self loadUserCompanyID];
    } andErrorBlock:^(NSString *msg) {
        
    }];
}

- (void)loadUserCompanyID{
    [[UserPL shareManager] userAccountGetComIdAndComNameWithReturnBlock:^(id returnValue) {
        [HUD show:@"登录成功"];
        if ([returnValue[@"companyName"] isEqualToString:@"示例样品间"]) {
            //前往角色选择
           
        }else{
            [self performSelector:@selector(gotoHomeVC) withObject:nil afterDelay:0.5];
        }
    } andErrorBlock:^(NSString *msg) {
        
    }];
}



-(void)setInfoDic:(NSDictionary *)infoDic{
    _infoDic = infoDic;
    _toplab.text = [NSString stringWithFormat:@"%@邀请你加入公司",infoDic[@"inviterName"]];
    _comlab.text = [NSString stringWithFormat:@"%@公司",infoDic[@"companyName"]];
}

- (void)gotoHomeVC{
    [[UserPL shareManager] showHomeViewController];
}


#pragma - mark public method
- (void)showView:(UIView *)view
{
    [view addSubview:self];
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
        _sideView = [BaseViewFactory viewWithFrame:CGRectMake(ScreenWidth/2-300, 160, 600, 200) color:UIColorFromRGB(WhiteColorValue)];
        
    }
    return _sideView;
}

@end
