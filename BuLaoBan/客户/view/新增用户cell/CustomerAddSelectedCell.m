//
//  CustomerAddSelectedCell.m
//  BuLaoBan
//
//  Created by souxiuyun on 2019/7/4.
//  Copyright © 2019 XX. All rights reserved.
//

#import "CustomerAddSelectedCell.h"
#import "CustomerAddTypeModel.h"

@implementation CustomerAddSelectedCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.backgroundColor = UIColorFromRGB(WhiteColorValue);
        [self setUpUI];
    }
    return self;
}

- (void)setUpUI{
    _nameLab = [BaseViewFactory labelWithFrame:CGRectZero textColor:UIColorFromRGB(BlackColorValue) font:APPFONT13 textAligment:NSTextAlignmentLeft andtext:@""];
    [self.contentView addSubview:_nameLab];
    _starLab= [BaseViewFactory labelWithFrame:CGRectZero textColor:UIColorFromRGB(0xFC3030) font:APPFONT13 textAligment:NSTextAlignmentLeft andtext:@"*"];
    [self.contentView addSubview:_starLab];
  
    _selectedBtn = [YLButton buttonWithbackgroundColor:UIColorFromRGB(WhiteColorValue) titlecolor:UIColorFromRGB(BlackColorValue) cornerRadius:0 andtarget:self action:@selector(selectedBtnClick) titleFont:APPFONT13 title:@""];
    _selectedBtn.titleLabel.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:_selectedBtn];
    [_selectedBtn setImageRect:CGRectMake(190, 20, 10, 10)];
    [_selectedBtn setTitleRect:CGRectMake(0, 0, 185, 44)];
    [_selectedBtn setImage:[UIImage imageNamed:@"down_chose"] forState:UIControlStateNormal];
    _line = [BaseViewFactory viewWithFrame:CGRectZero color:UIColorFromRGB(LineColorValue)];
    [self.contentView addSubview:_line];
    
}


-(void)setModel:(CustomerAddTypeModel *)model{
    _model = model;
    _nameLab.text = model.title;
    if (model.showvalue.length>0) {
        [_selectedBtn setTitle:model.showvalue forState:UIControlStateNormal];
    }else{
        [_selectedBtn setTitle:@"" forState:UIControlStateNormal];

    }
    if (_model.isMustInput) {
        _starLab.hidden = NO;
    }else{
        _starLab.hidden = YES;
    }
    _nameLab.sd_layout
    .leftSpaceToView(self.contentView, 20)
    .topEqualToView(self.contentView)
    .bottomEqualToView(self.contentView);
    [_nameLab setSingleLineAutoResizeWithMaxWidth:100];
    _starLab.sd_layout
    .leftSpaceToView(_nameLab, 0)
    .topEqualToView(self.contentView)
    .bottomEqualToView(self.contentView);
    [_starLab setSingleLineAutoResizeWithMaxWidth:100];
    _selectedBtn.sd_layout
    .rightSpaceToView(self.contentView, 14)
    .topEqualToView(self.contentView)
    .bottomEqualToView(self.contentView)
    .widthIs(200);
    _line.sd_layout
    .leftSpaceToView(self.contentView, 20)
    .bottomEqualToView(self.contentView)
    .rightSpaceToView(self.contentView, 0)
    .heightIs(1);
}




- (void)selectedBtnClick{
    if ([self.delegate respondsToSelector:@selector(selectedBtnWithModel:)]) {
        [self.delegate selectedBtnWithModel:_model];
    }
}




@end
