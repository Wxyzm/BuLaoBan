//
//  SettleMoneyCell.m
//  BuLaoBan
//
//  Created by souxiuyun on 2019/3/16.
//  Copyright © 2019 XX. All rights reserved.
//

#import "SettleMoneyCell.h"
#import "Settlement.h"
@interface SettleMoneyCell ()<UITextFieldDelegate>



@end


@implementation SettleMoneyCell{
    UITextField *_inputTxt;
    UILabel *_yuanLab;
    BOOL    isHaveDian;

}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style  reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setUp];
    }
    return self;
}

- (void)setUp{
    _nameLab = [BaseViewFactory labelWithFrame:CGRectZero textColor:UIColorFromRGB(BlackColorValue) font:APPFONT16 textAligment:NSTextAlignmentLeft andtext:@""];
    [self.contentView addSubview:_nameLab];
    
    _lineView = [BaseViewFactory viewWithFrame:CGRectZero color:UIColorFromRGB(LineColorValue)];
    [self.contentView addSubview:_lineView];
    
    
    _yuanLab = [BaseViewFactory labelWithFrame:CGRectZero textColor:UIColorFromRGB(BlackColorValue) font:APPFONT16 textAligment:NSTextAlignmentLeft andtext:@"元"];
    [self.contentView addSubview:_yuanLab];
    
    _inputTxt = [BaseViewFactory textFieldWithFrame:CGRectZero font:APPFONT16 placeholder:@"输入金额" textColor:UIColorFromRGB(RedColorValue) placeholderColor:nil delegate:self];
    [self.contentView addSubview:_inputTxt];
    _inputTxt.keyboardType = UIKeyboardTypeDecimalPad;
    _inputTxt.textAlignment = NSTextAlignmentRight;
    
}


-(void)setSettlement:(Settlement *)Settlement{
    _Settlement = Settlement;
    _nameLab.text = Settlement.title;
    
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
    
    _yuanLab.sd_layout
    .rightSpaceToView(self.contentView, 16)
    .topSpaceToView(self.contentView, 0)
    .bottomSpaceToView(self.contentView, 0);
    [_yuanLab setSingleLineAutoResizeWithMaxWidth:20];
    
    _inputTxt.sd_layout
    .rightSpaceToView(_yuanLab, 0)
    .topSpaceToView(self.contentView, 0)
    .bottomSpaceToView(self.contentView, 0)
    .leftSpaceToView(_nameLab, 0);
 
}


-(BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    
    _Settlement.showValue = textField.text;
    WeakSelf(self);
    if (weakself.returnBlock) {
        weakself.returnBlock(_Settlement);
    }
    
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
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
