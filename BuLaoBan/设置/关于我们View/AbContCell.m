//
//  AbContCell.m
//  BuLaoBan
//
//  Created by souxiuyun on 2019/5/5.
//  Copyright © 2019 XX. All rights reserved.
//

#import "AbContCell.h"

@implementation AbContCell{
    
    UIImageView *_faceIma;
    UILabel *_nameLab;
    UILabel *_phoneLab;
    UIButton *_phoneBtn;
    NSString *_phoneStr;
    
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        _phoneStr = @"";
        [self setUP];
        
    }
    
    return self;
}

- (void)setUP{
    CGFloat width = ScreenWidth-400;
    _faceIma = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"ab_linkman"]];
    [self.contentView addSubview:_faceIma];
    _faceIma.frame = CGRectMake(30, 12, 26, 26);
    
    _nameLab = [BaseViewFactory labelWithFrame:CGRectMake(76, 0, 100, 50) textColor:UIColorFromRGB(BlackColorValue) font:APPFONT15 textAligment:NSTextAlignmentLeft andtext:@""];
    [self.contentView addSubview:_nameLab];

    _phoneLab  = [BaseViewFactory labelWithFrame:CGRectMake(220, 0, 120, 50) textColor:UIColorFromRGB(BlackColorValue) font:APPFONT15 textAligment:NSTextAlignmentLeft andtext:@""];
    [self.contentView addSubview:_phoneLab];
    
    _phoneBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_phoneBtn setImage:[UIImage imageNamed:@"ab_phone"] forState:UIControlStateNormal];
    [self.contentView addSubview:_phoneBtn];
    _phoneBtn.frame = CGRectMake(width - 56, 12, 26, 26);
    [_phoneBtn addTarget:self action:@selector(phoneBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    UIView *line = [BaseViewFactory viewWithFrame:CGRectMake(30, 0, width-30, 1) color:UIColorFromRGB(LineColorValue)];
    [self.contentView addSubview:line];

}





- (void)phoneBtnClick{
    
    if (_phoneStr.length<=0) {
        return;
    }
    NSMutableString* str=[[NSMutableString alloc] initWithFormat:@"telprompt://%@",_phoneStr];
    //            NSLog(@"str======%@",str);
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
}


- (void)setName:(NSString *)name andphone:(NSString *)phone{
    _nameLab.text = name;
    _phoneLab.text = phone;
    _phoneStr = phone;
    
    
}




@end
