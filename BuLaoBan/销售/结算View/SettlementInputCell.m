//
//  SettlementInputCell.m
//  BuLaoBan
//
//  Created by apple on 2019/2/25.
//  Copyright © 2019年 XX. All rights reserved.
//

#import "SettlementInputCell.h"
#import "Settlement.h"

@implementation SettlementInputCell{
    
    UIImageView *_rightIma;
    
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self initUI];
    }
    
    return self;
}


- (void)initUI{
    
    _nameLab = [BaseViewFactory labelWithFrame:CGRectZero textColor:UIColorFromRGB(BlackColorValue) font:APPFONT16 textAligment:NSTextAlignmentLeft andtext:@""];
    [self.contentView addSubview:_nameLab];
    
    _showLab = [BaseViewFactory labelWithFrame:CGRectZero textColor:UIColorFromRGB(BlackColorValue) font:APPFONT16 textAligment:NSTextAlignmentRight andtext:@""];
    [self.contentView addSubview:_showLab];
    
    _lineView = [BaseViewFactory viewWithFrame:CGRectZero color:UIColorFromRGB(LineColorValue)];
    [self.contentView addSubview:_lineView];

    _rightIma = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"right"]];
    [self.contentView addSubview:_rightIma];

}

-(void)setSettlement:(Settlement *)Settlement{
    _Settlement = Settlement;
    _nameLab.text = Settlement.title;
    if (Settlement.isRedText) {
        _showLab.attributedText = [self modifyDigitalColor:UIColorFromRGB(RedColorValue) normalColor:UIColorFromRGB(BlackColorValue) aneText: Settlement.showValue];
    }else{
        _showLab.text = Settlement.showValue;

    }
    
    
    _nameLab.sd_layout
    .leftSpaceToView(self.contentView, 16)
    .topEqualToView(self.contentView)
    .bottomEqualToView(self.contentView)
    .widthIs(100);
    
    _lineView.sd_layout
    .leftSpaceToView(self.contentView, 16)
    .bottomEqualToView(self.contentView)
    .rightEqualToView(self.contentView)
    .heightIs(1);
    
    
    if (Settlement.ValueType == ValueType_Input) {
        _rightIma.hidden = YES;
        _showLab.sd_layout
        .rightSpaceToView(self.contentView, 16)
        .topEqualToView(self.contentView)
        .bottomEqualToView(self.contentView)
        .leftSpaceToView(_nameLab, 10);
    }else if (Settlement.ValueType == ValueType_Select){
        _rightIma.hidden = NO;

        _rightIma.sd_layout
        .rightSpaceToView(self.contentView, 16)
        .centerYEqualToView(self.contentView)
        .widthIs(8)
        .heightIs(13);
        
        _showLab.sd_layout
        .rightSpaceToView(_rightIma, 16)
        .topEqualToView(self.contentView)
        .bottomEqualToView(self.contentView)
        .leftSpaceToView(_nameLab, 10);
        
       
    }else{
        _rightIma.hidden = YES;

    }
    
  
    
    
    
}


/**
 修改字符串中数字颜色, 并返回对应富文本
 
 @param color 数字颜色, 包括小数
 @param normalColor 默认颜色
 @return 结果富文本
 */
- (NSMutableAttributedString *)modifyDigitalColor:(UIColor *)color normalColor:(UIColor *)normalColor aneText:(NSString *)text;
{
    NSRegularExpression *regular = [NSRegularExpression regularExpressionWithPattern:@"([0-9]\\d*\\.?\\d*)" options:0 error:NULL];
    
    NSArray<NSTextCheckingResult *> *ranges = [regular matchesInString:text options:0 range:NSMakeRange(0, [text length])];
    
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:text attributes:@{NSForegroundColorAttributeName : normalColor}];
    
    for (int i = 0; i < ranges.count; i++) {
        [attStr setAttributes:@{NSForegroundColorAttributeName : color} range:ranges[i].range];
    }
    return attStr;
}


@end
