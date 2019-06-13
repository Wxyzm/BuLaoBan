 //
//  GetDelCell.m
//  BuLaoBan
//
//  Created by souxiuyun on 2019/4/17.
//  Copyright © 2019 XX. All rights reserved.
//

#import "GetDelCell.h"
#import "SellOrderDeliver.h"

@implementation GetDelCell{
    
    UILabel *_nameLab;   //公司名称
    UILabel *_numberLab; //单号
    UILabel *_dateLab;   //日期
}


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setUp];
    }
    return self;
}




- (void)setUp{
    _nameLab = [BaseViewFactory labelWithFrame:CGRectMake(20, 10, 500, 19) textColor:UIColorFromRGB(BlackColorValue) font:APPFONT14 textAligment:NSTextAlignmentLeft andtext:@""];
    [self.contentView addSubview:_nameLab];
    
    _numberLab = [BaseViewFactory labelWithFrame:CGRectMake(20, 34, 200, 17) textColor:UIColorFromRGB(0x797979) font:APPFONT12 textAligment:NSTextAlignmentLeft andtext:@"单号："];
    [self.contentView addSubview:_numberLab];
    
    _dateLab = [BaseViewFactory labelWithFrame:CGRectMake(220, 34, 200, 17) textColor:UIColorFromRGB(0x797979) font:APPFONT12 textAligment:NSTextAlignmentRight andtext:@"日期："];
    [self.contentView addSubview:_dateLab];
    
   _deleteBtn = [BaseViewFactory buttonWithFrame:CGRectMake(540, 0, 60, 60) font:APPFONT15 title:@"删除" titleColor:UIColorFromRGB(BlueColorValue) backColor:UIColor.clearColor];
    [self.contentView addSubview:_deleteBtn];

    
    UIView *line = [BaseViewFactory viewWithFrame:CGRectMake(0, 59, 600, 1) color:UIColorFromRGB(BackColorValue)];
    [self.contentView addSubview:line];
}

-(void)setModel:(SellOrderDeliver *)model{
    _model = model;
    _nameLab.text = model.customerName;
    _numberLab.text = [NSString stringWithFormat:@"单号：%@",model.deliverNo];
    _dateLab.text = [NSString stringWithFormat:@"日期：%@",model.deliverDate];
}



@end
