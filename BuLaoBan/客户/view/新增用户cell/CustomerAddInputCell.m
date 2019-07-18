//
//  CustomerAddInputCell.m
//  BuLaoBan
//
//  Created by souxiuyun on 2019/7/4.
//  Copyright © 2019 XX. All rights reserved.
//

#import "CustomerAddInputCell.h"
#import "CustomerAddTypeModel.h"

@interface CustomerAddInputCell ()<UITextFieldDelegate>



@end


@implementation CustomerAddInputCell{
    BOOL isHaveDian;
}

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
    _starLab.hidden = YES;
    [self.contentView addSubview:_starLab];
    _inputTxt = [BaseViewFactory textFieldWithFrame:CGRectZero font:APPFONT13 placeholder:@"" textColor:UIColorFromRGB(BlackColorValue) placeholderColor:nil delegate:self];
    [self.contentView addSubview:_inputTxt];
    _inputTxt.textAlignment = NSTextAlignmentRight;
    _line = [BaseViewFactory viewWithFrame:CGRectZero color:UIColorFromRGB(LineColorValue)];
    [self.contentView addSubview:_line];
    
}

-(void)setModel:(CustomerAddTypeModel *)model{
    _model = model;
    _nameLab.text = model.title;
    if (_model.isMustInput) {
        _starLab.hidden = NO;
    }else{
        _starLab.hidden = YES;
    }
    if ([_model.title isEqualToString:@"期初欠款"]) {
        _inputTxt.keyboardType = UIKeyboardTypeDecimalPad;
    }else{
        _inputTxt.keyboardType = UIKeyboardTypeDefault;
    }
    
    _inputTxt.placeholder = [NSString stringWithFormat:@"请输入%@",model.title];
    _inputTxt.text = model.showvalue;
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
    _inputTxt.sd_layout
    .rightSpaceToView(self.contentView, 20)
    .topEqualToView(self.contentView)
    .bottomEqualToView(self.contentView)
    .widthIs(200);
    _line.sd_layout
    .leftSpaceToView(self.contentView, 20)
    .bottomEqualToView(self.contentView)
    .rightSpaceToView(self.contentView, 0)
    .heightIs(1);
    
    
}

-(BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    _model.showvalue = textField.text;
    return YES;
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if (![_model.title isEqualToString:@"期初欠款"]) {
        return YES;
    }
    
    
    if ([textField.text rangeOfString:@"."].location == NSNotFound)
    {
        isHaveDian = NO;
    }
    if ([string length] > 0)
    {
        unichar single = [string characterAtIndex:0];//当前输入的字符
        if ((single >= '0' && single <= '9') || single == '.')//数据格式正确
        {
            //首字母不能为0和小数点
            if([textField.text length] == 0)
            {
                
                if(single == '.')
                {
                    //  [self showMyMessage:@"亲，第一个数字不能为小数点!"];
                    [textField.text stringByReplacingCharactersInRange:range withString:@""];
                    return NO;
                }
            }
            //输入的字符是否是小数点
            if (single == '.')
            {
                
                if(!isHaveDian)//text中还没有小数点
                {
                    
                    isHaveDian = YES;
                    return YES;
                    
                }else{
                    //   [self showMyMessage:@"亲，您已经输入过小数点了!"];
                    [textField.text stringByReplacingCharactersInRange:range withString:@""];
                    return NO;
                }
                
            }else{
                if (isHaveDian) {//存在小数点
                    
                    //判断小数点的位数
                    NSRange ran = [textField.text rangeOfString:@"."];
                    if (range.location - ran.location <= 2) {
                        return YES;
                    }else{
                        //    [self showMyMessage:@"亲，您最多输入两位小数!"];
                        return NO;
                    }
                    
                }else{
                    return YES;
                }
            }
        }else{//输入的数据格式不正确
            [textField.text stringByReplacingCharactersInRange:range withString:@""];
            return NO;
            
        }
    }
    
    else
        
    {
        return YES;
        
    }
    
    
    
}

@end
