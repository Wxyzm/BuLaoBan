//
//  AccountListCell.m
//  BuLaoBan
//
//  Created by souxiuyun on 2019/3/22.
//  Copyright © 2019 XX. All rights reserved.
//

#import "AccountListCell.h"
@interface AccountListCell ()



@end


@implementation AccountListCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.backgroundColor = UIColorFromRGB(WhiteColorValue);
        [self setUP];
        
    }
    
    return self;
}

- (void)setUP{
    _accnameLab = [BaseViewFactory labelWithFrame:CGRectMake(20, 10, 400, 13) textColor:UIColorFromRGB(BlackColorValue) font:APPFONT13 textAligment:NSTextAlignmentLeft andtext:@""];
    [self.contentView addSubview:_accnameLab];
    
    _accNumLab = [BaseViewFactory labelWithFrame:CGRectMake(20, 34, 400, 13) textColor:UIColorFromRGB(0x797979) font:APPFONT12 textAligment:NSTextAlignmentLeft andtext:@"账号："];
    [self.contentView addSubview:_accNumLab];
    
    UIButton *editBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [editBtn setImage:[UIImage imageNamed:@"Acc_edit"] forState:UIControlStateNormal];
    [self.contentView addSubview:editBtn];
    [editBtn addTarget:self action:@selector(editBtnClick) forControlEvents:UIControlEventTouchUpInside];
    editBtn.frame = CGRectMake(562, 21, 18, 18);
    
    _accKindLab = [BaseViewFactory labelWithFrame:CGRectMake(100, 34, 420, 13) textColor:UIColorFromRGB(0x797979) font:APPFONT12 textAligment:NSTextAlignmentRight andtext:@"账号类型："];
    [self.contentView addSubview:_accKindLab];
    
    
}

//编辑
- (void)editBtnClick{
    
    
    
}


@end
