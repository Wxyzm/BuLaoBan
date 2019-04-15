//
//  AddCusCell.m
//  BuLaoBan
//
//  Created by souxiuyun on 2019/4/7.
//  Copyright © 2019 XX. All rights reserved.
//

#import "AddCusCell.h"
#import "AddCusModel.h"
@interface AddCusCell ()<UITextFieldDelegate>



@end


@implementation AddCusCell

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
    _nameLab = [BaseViewFactory labelWithFrame:CGRectMake(20, 0, 100, 44) textColor:UIColorFromRGB(BlackColorValue) font:APPFONT13 textAligment:NSTextAlignmentLeft andtext:@""];
    [self.contentView addSubview:_nameLab];
    
    _infoTxt = [BaseViewFactory textFieldWithFrame:CGRectMake(130, 0, 160, 44) font:APPFONT13 placeholder:@"" textColor:UIColorFromRGB(BlackColorValue) placeholderColor:nil delegate:self];
    _infoTxt.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:_infoTxt];
    
    _selectBtn = [YLButton buttonWithbackgroundColor:UIColorFromRGB(WhiteColorValue) titlecolor:UIColorFromRGB(BlueColorValue) cornerRadius:0 andtarget:self action:@selector(selectBtnClick) titleFont:APPFONT13 title:@""];
    _selectBtn.titleLabel.textAlignment = NSTextAlignmentRight;
    _selectBtn.frame = CGRectMake(130, 0, 160, 44);
    [_selectBtn setTitleRect:CGRectMake(0, 0, 160, 44)];
    _selectBtn.hidden = YES;
    [self.contentView addSubview:_selectBtn];

    UIView *line = [BaseViewFactory viewWithFrame:CGRectMake(20, 44, 280, 1) color:UIColorFromRGB(0xdcdcdc)];
    [self.contentView addSubview:line];
}

-(void)setModel:(AddCusModel *)model{
    _model = model;
    if ([model.name containsString:@"名称"]) {
         _nameLab.attributedText = [self modifyDigitalColor:UIColorFromRGB(RedColorValue) normalColor:UIColorFromRGB(BlackColorValue) aneText:model.name];
        _infoTxt.placeholder = @"输入客户名称";
    }else if ([model.name containsString:@"联系人"]){
        _nameLab.text = model.name;
        _infoTxt.placeholder = @"输入联系人姓名";
    }
    else{
        _nameLab.text = model.name;
        _infoTxt.placeholder = [NSString stringWithFormat:@"输入%@",model.name];
    }
    
    if (model.tag == 1) {
        _selectBtn.hidden = NO;
        _infoTxt.hidden = YES;
        if (model.StrValue.length>0) {
            [_selectBtn setTitle:[NSString stringWithFormat:@"%@",model.StrValue] forState:UIControlStateNormal];
        }else{
            [_selectBtn setTitle:[NSString stringWithFormat:@"选择%@",model.name] forState:UIControlStateNormal];
        }
    }else{
        _selectBtn.hidden = YES;
        _infoTxt.hidden = NO;
    }

}

#pragma mark ==== 选择按钮点击
- (void)selectBtnClick{
    
    
}

#pragma mark ==== UITextFieldDelegate
-(BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    
    _model.StrValue = textField.text;
    
    return YES;
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
