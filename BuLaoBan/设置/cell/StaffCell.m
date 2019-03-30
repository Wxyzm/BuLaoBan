//
//  StaffCell.m
//  BuLaoBan
//
//  Created by souxiuyun on 2019/3/5.
//  Copyright © 2019 XX. All rights reserved.
//

#import "StaffCell.h"
#import "CompanyUsers.h"
@implementation StaffCell{
    
    UIImageView *_faceIma;
    UILabel *_nameLab;
    UILabel *_phoneLab;
    UILabel *_positionLab;
    UIButton *_doBtn;
    
}

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
    _faceIma = [[UIImageView alloc]initWithFrame:CGRectMake(20, 10, 30, 30)];
    [self.contentView addSubview:_faceIma];
    _faceIma.clipsToBounds = YES;
    _faceIma.layer.cornerRadius = 2;
    _faceIma.backgroundColor = UIColorFromRGB(BackColorValue);
    
    _nameLab = [BaseViewFactory labelWithFrame:CGRectZero textColor:UIColorFromRGB(BlackColorValue) font:APPFONT12 textAligment:NSTextAlignmentCenter andtext:@""];
    [self.contentView addSubview:_nameLab];

    _phoneLab = [BaseViewFactory labelWithFrame:CGRectZero textColor:UIColorFromRGB(BlackColorValue) font:APPFONT12 textAligment:NSTextAlignmentCenter andtext:@""];
    [self.contentView addSubview:_phoneLab];
    
    _positionLab = [BaseViewFactory labelWithFrame:CGRectZero textColor:UIColorFromRGB(BlackColorValue) font:APPFONT12 textAligment:NSTextAlignmentCenter andtext:@""];
    [self.contentView addSubview:_positionLab];
    
    _doBtn = [BaseViewFactory buttonWithFrame:CGRectZero font:APPFONT12 title:@"转移" titleColor:UIColorFromRGB(BlackColorValue) backColor:[UIColor clearColor]];
    [self.contentView addSubview:_doBtn];
    
    _nameLab.sd_layout
    .leftSpaceToView(_faceIma, 22)
    .centerYEqualToView(_faceIma)
    .widthIs(68)
    .heightIs(50);
    
    _phoneLab.sd_layout
    .leftSpaceToView(_nameLab, 46)
    .centerYEqualToView(_faceIma)
    .widthIs(166)
    .heightIs(50);
    
    _positionLab.sd_layout
    .leftSpaceToView(_phoneLab, 6)
    .centerYEqualToView(_faceIma)
    .widthIs(116)
    .heightIs(50);
    
    _doBtn.sd_layout
    .leftSpaceToView(_positionLab, 18)
    .centerYEqualToView(_faceIma)
    .widthIs(84)
    .heightIs(50);
    
}

-(void)setModel:(CompanyUsers *)model{
    _model = model;
    _nameLab.text = model.name;
    _phoneLab.text = model.mobile;
    _positionLab.text = model.roleName;
    [_faceIma sd_setImageWithURL:[NSURL URLWithString:model.avatar] placeholderImage:nil];

    
}

@end
