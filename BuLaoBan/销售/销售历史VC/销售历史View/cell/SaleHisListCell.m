//
//  SaleHisListCell.m
//  BuLaoBan
//
//  Created by apple on 2019/2/27.
//  Copyright © 2019年 XX. All rights reserved.
//

#import "SaleHisListCell.h"
#import "SellOrderDeliver.h"

@interface SaleHisListCell ()<UITextFieldDelegate>

/**
 单据名称
 */
@property (nonatomic, strong) UILabel *nameLab;
/**
 单据单号
 */
@property (nonatomic, strong) UILabel *numberLab;
/**
 单据日期
 */
@property (nonatomic, strong) UILabel *dateLab;


@end


@implementation SaleHisListCell
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
    
    _nameLab = [BaseViewFactory labelWithFrame:CGRectMake(12, 10,276 , 18) textColor:UIColorFromRGB(BlackColorValue) font:APPFONT14 textAligment:NSTextAlignmentLeft andtext:@""];
    [self.contentView addSubview:_nameLab];
    
    _numberLab = [BaseViewFactory labelWithFrame:CGRectMake(12, 34,138 , 16) textColor:UIColorFromRGB(0x858585) font:APPFONT13 textAligment:NSTextAlignmentLeft andtext:@"单号：SA2019010001"];
    [self.contentView addSubview:_numberLab];
    
    _dateLab = [BaseViewFactory labelWithFrame:CGRectMake(150, 34,138 , 16) textColor:UIColorFromRGB(0x858585) font:APPFONT13 textAligment:NSTextAlignmentRight andtext:@"日期：2019-01-20"];
    [self.contentView addSubview:_dateLab];
    
    UIView *line = [BaseViewFactory viewWithFrame:CGRectMake(12, 59, 288, 1) color:UIColorFromRGB(LineColorValue)];
    [self.contentView addSubview:line];

}

- (void)setModel:(SellOrderDeliver *)model{
    _model = model;
    _nameLab.text = model.customerName;
    _numberLab.text = [NSString stringWithFormat:@"单号：%@",model.deliverNo];
    _dateLab.text = [NSString stringWithFormat:@"日期：%@",model.deliverDate];
    if (model.selected) {
        self.contentView.backgroundColor = UIColorFromRGB(0xeff6f9);
    }else{
        self.contentView.backgroundColor = UIColorFromRGB(WhiteColorValue);
        
    }
}


@end
