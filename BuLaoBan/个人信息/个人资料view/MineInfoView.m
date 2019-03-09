//
//  MineInfoView.m
//  BuLaoBan
//
//  Created by apple on 2019/2/28.
//  Copyright © 2019年 XX. All rights reserved.
//

#import "MineInfoView.h"
#import "UserInfoModel.h"
@interface MineInfoView()<UITextFieldDelegate>



@end
@implementation MineInfoView{
    
    UIImageView *_faceIma;
    UITextField *_nameTxt;
    UITextField *_phoneTxt;
    UITextField *_mailTxt;

    
}

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = UIColorFromRGB(WhiteColorValue);
        [self setUp];
    }
    return self;
}

- (void)setUp{
    
    CGFloat Width = ScreenWidth-400;
    UILabel *lab = [BaseViewFactory labelWithFrame:CGRectMake(20, 0, 40, 80) textColor:UIColorFromRGB(BlackColorValue) font:APPFONT13 textAligment:NSTextAlignmentLeft andtext:@"头像"];
    [self addSubview:lab];
    
    _faceIma = [[UIImageView alloc]initWithFrame:CGRectMake(Width-70, 15, 50, 50)];
    [self addSubview:_faceIma];
    _faceIma.clipsToBounds = YES;
    _faceIma.layer.cornerRadius = 25;
    _faceIma.backgroundColor = UIColorFromRGB(BackColorValue);
    
    _nameTxt = [BaseViewFactory textFieldWithFrame:CGRectMake(100,80, Width-120, 50) font:APPFONT13 placeholder:@"输入用户名" textColor:UIColorFromRGB(BlackColorValue) placeholderColor:nil delegate:self];
    _nameTxt.textAlignment = NSTextAlignmentRight;
    [self addSubview:_nameTxt];

    _phoneTxt = [BaseViewFactory textFieldWithFrame:CGRectMake(100,130 , Width-120, 50) font:APPFONT13 placeholder:@"输入手机号" textColor:UIColorFromRGB(0x9B9B9B) placeholderColor:nil delegate:self];
    _phoneTxt.textAlignment = NSTextAlignmentRight;
    [self addSubview:_phoneTxt];
    _phoneTxt.userInteractionEnabled = NO;
    
    _mailTxt  = [BaseViewFactory textFieldWithFrame:CGRectMake(100,180 , Width-120, 50) font:APPFONT13 placeholder:@"输入邮箱" textColor:UIColorFromRGB(BlackColorValue) placeholderColor:nil delegate:self];
    _mailTxt.textAlignment = NSTextAlignmentRight;
    [self addSubview:_mailTxt];
    
    
    NSArray *titleArr = @[@"用户名",@"手机",@"邮箱"];
    for (int i = 0; i<4; i++) {
        if (i!=3) {
            UILabel *titlelab= [BaseViewFactory labelWithFrame:CGRectMake(20, 80+50*i, 60, 50) textColor:UIColorFromRGB(BlackColorValue) font:APPFONT13 textAligment:NSTextAlignmentLeft andtext:titleArr[i]];
            [self addSubview:titlelab];
        }
        
        UIView *line = [BaseViewFactory viewWithFrame:CGRectMake(0, 80+50*i-0.5, Width, 1) color:UIColorFromRGB(LineColorValue)];
        [self addSubview:line];

    }
}

-(void)setInfoModel:(UserInfoModel *)infoModel{
    _infoModel = infoModel;
    [_faceIma sd_setImageWithURL:[NSURL URLWithString:infoModel.avatar] placeholderImage:nil];
    _nameTxt.text = infoModel.userName;
    _phoneTxt.text = infoModel.mobile;
    _mailTxt.text = infoModel.email;
    
    
}

-(BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    if ([_nameTxt isFirstResponder]) {
        _infoModel.userName = _nameTxt.text;
        
    }else if ([_phoneTxt isFirstResponder]){
        _infoModel.mobile = _phoneTxt.text;
        
    }else if ([_mailTxt isFirstResponder]){
        _infoModel.email = _mailTxt.text;
        
    }
    return YES;
}



- (NSDictionary *)returnUpDic{
    NSDictionary *dic = @{
                          @"userName":_infoModel.userName,
                          @"avatar":_infoModel.avatar,
                          @"email":_infoModel.email,
                          @"weixin":_infoModel.weixin,
                          @"position":_infoModel.position,
                          @"address":_infoModel.address,
                          @"telephone":_infoModel.telephone,
                          @"birthday":_infoModel.birthday,
                          @"fax":_infoModel.fax,
                          @"companyName":_infoModel.companyName,
                          @"companyDesc":_infoModel.companyDesc,
                          @"scope":_infoModel.scope,
                          @"theodolite":_infoModel.theodolite,
                          @"pics":[_infoModel.pics componentsJoinedByString:@","],
                          @"visibleModules":[_infoModel.visibleModules componentsJoinedByString:@","]
                          };
//    [_infoDic setValue:_infoModel.avatar forKey:@"avatar"];
//    [_infoDic setValue:_infoModel.userName forKey:@"userName"];
//    [_infoDic setValue:_infoModel.mobile forKey:@"mobile"];
//    [_infoDic setValue:_infoModel.email forKey:@"email"];

    
    return dic;
}


@end
