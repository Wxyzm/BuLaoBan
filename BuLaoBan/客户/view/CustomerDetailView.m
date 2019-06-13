//
//  CustomerDetailView.m
//  BuLaoBan
//
//  Created by apple on 2019/2/11.
//  Copyright © 2019年 XX. All rights reserved.
//

#import "CustomerDetailView.h"
#import "ComCustomerDetail.h"

@implementation CustomerDetailView{
    UILabel *_nameLab;      //
    UILabel *_acceptLab;    //应收欠款
    UILabel *_manLab;       //业务员
    UILabel *_otherManLab;  //参与者
    UILabel *_memoLab;      //备注
    UILabel *_linkManLab;   //联系人
    UILabel *_phoneLab;   //联系人
    UILabel *_mailLab;      //邮箱
    UILabel *_adressLab;    //地址

    
    
}

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = UIColorFromRGB(BackColorValue);
        [self setUP];
    }
    return  self;
}

- (void)setUP{
    CGFloat viewWidth = ScreenWidth - 400;
    UIView *topview = [BaseViewFactory viewWithFrame:CGRectMake(0, 0, viewWidth, 200) color:UIColorFromRGB(WhiteColorValue)];
    [self addSubview:topview];
    
    
    _nameLab = [BaseViewFactory labelWithFrame:CGRectMake(16, 16, viewWidth-32, 28) textColor:UIColorFromRGB(BlackColorValue) font:APPFONT(18) textAligment:NSTextAlignmentLeft andtext:@""];
    [self addSubview:_nameLab];
    
    _acceptLab = [BaseViewFactory labelWithFrame:CGRectMake(16, 56, viewWidth-32, 22) textColor:UIColorFromRGB(BlackColorValue) font:APPFONT(14) textAligment:NSTextAlignmentLeft andtext:@"应收欠款："];
    [self addSubview:_acceptLab];
    
    _manLab = [BaseViewFactory labelWithFrame:CGRectMake(16, 88, viewWidth-32, 22) textColor:UIColorFromRGB(BlackColorValue) font:APPFONT(14) textAligment:NSTextAlignmentLeft andtext:@"业务员："];
    [self addSubview:_manLab];
    
    _otherManLab = [BaseViewFactory labelWithFrame:CGRectMake(16, 118, viewWidth-32, 22) textColor:UIColorFromRGB(BlackColorValue) font:APPFONT(14) textAligment:NSTextAlignmentLeft andtext:@"参与者："];
    [self addSubview:_otherManLab];
    
    _memoLab = [BaseViewFactory labelWithFrame:CGRectMake(16, 148, viewWidth-32, 20) textColor:UIColorFromRGB(BlackColorValue) font:APPFONT(14) textAligment:NSTextAlignmentLeft andtext:@"备注："];
    [self addSubview:_memoLab];
    
    UIView *boomview = [BaseViewFactory viewWithFrame:CGRectMake(0, 210, viewWidth, 200) color:UIColorFromRGB(WhiteColorValue)];
    [self addSubview:boomview];
    
    UILabel * showlab = [BaseViewFactory labelWithFrame:CGRectMake(16, 16, viewWidth-32, 22) textColor:UIColorFromRGB(BlackColorValue) font:APPFONT(16) textAligment:NSTextAlignmentLeft andtext:@"联系方式"];
    [boomview addSubview:showlab];
    
    _linkManLab = [BaseViewFactory labelWithFrame:CGRectMake(16, 52, viewWidth-32, 20) textColor:UIColorFromRGB(BlackColorValue) font:APPFONT(14) textAligment:NSTextAlignmentLeft andtext:@"联系人："];
    [boomview addSubview:_linkManLab];
    
    _phoneLab = [BaseViewFactory labelWithFrame:CGRectMake(16, 82, viewWidth-32, 20) textColor:UIColorFromRGB(BlackColorValue) font:APPFONT(14) textAligment:NSTextAlignmentLeft andtext:@"联系电话："];
    [boomview addSubview:_phoneLab];
    
    _mailLab = [BaseViewFactory labelWithFrame:CGRectMake(16, 112, viewWidth-32, 20) textColor:UIColorFromRGB(BlackColorValue) font:APPFONT(14) textAligment:NSTextAlignmentLeft andtext:@"邮箱："];
    [boomview addSubview:_mailLab];
    
    _adressLab = [BaseViewFactory labelWithFrame:CGRectMake(16, 142, viewWidth-32, 20) textColor:UIColorFromRGB(BlackColorValue) font:APPFONT(14) textAligment:NSTextAlignmentLeft andtext:@"地址："];
    [boomview addSubview:_adressLab];
}

-(void)setDetailModel:(ComCustomerDetail *)detailModel{
    _detailModel = detailModel;
    _nameLab.text = detailModel.name;
    _acceptLab.text =[NSString stringWithFormat:@"应收欠款：￥  %@",detailModel.receivableAmount];
    _manLab.text = [NSString stringWithFormat:@"业务员：：%@",detailModel.salesmanName] ;
    if (detailModel.participants.count>0) {
        NSDictionary *dic =detailModel.participants[0];
        _otherManLab.text =[NSString stringWithFormat:@"参与者：%@",[dic objectForKey:@"userName"]] ;
    }else{
        _otherManLab.text =@"参与者：";
    }
    _memoLab.text =[NSString stringWithFormat:@"备注：%@",detailModel.remark] ;
    _linkManLab.text =[NSString stringWithFormat:@"联系人：%@",detailModel.manager];
    _phoneLab.text =[NSString stringWithFormat:@"手机号：%@",detailModel.telephone];
    _mailLab.text =[NSString stringWithFormat:@"邮箱：%@",detailModel.email];
    _adressLab.text =[NSString stringWithFormat:@"地址：%@%@%@%@",detailModel.provinceName,detailModel.cityName,detailModel.areaName,detailModel.address];

    
}






@end
