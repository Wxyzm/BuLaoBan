//
//  CompView.m
//  BuLaoBan
//
//  Created by apple on 2019/2/12.
//  Copyright © 2019年 XX. All rights reserved.
//

#import "CompView.h"
#import "Component.h"

@interface CompView ()<UITextFieldDelegate>

@end

@implementation CompView

-(instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = UIColorFromRGB(WhiteColorValue);
        [self setUP];
    }
    
    return self;
}

- (void)setUP{
    _comNameLab = [BaseViewFactory labelWithFrame:CGRectMake(30, 0, 86, 40) textColor:UIColorFromRGB(BlackColorValue) font:APPFONT13 textAligment:NSTextAlignmentRight andtext:@""];
    [self addSubview:_comNameLab];
    
    _valueTxt = [BaseViewFactory textFieldWithFrame:CGRectMake(116, 0, 184, 40) font:APPFONT13 placeholder:@"百分比" textColor:UIColorFromRGB(BlackColorValue) placeholderColor:UIColorFromRGB(0xbdbdbd) delegate:self];
    _valueTxt.keyboardType = UIKeyboardTypeNumberPad;
    [self addSubview:_valueTxt];
    
    UIView *line = [BaseViewFactory viewWithFrame:CGRectMake(30, 39, 270, 1) color:UIColorFromRGB(LineColorValue)];
    [self addSubview:line];
    
}

-(void)setComponent:(Component *)component{
    _component = component;
    _comNameLab.text = [NSString stringWithFormat:@"%@%@：",component.componentName.length>0?component.componentName:@"",component.componentEnName.length>0?component.componentEnName:@""];
    _valueTxt.text = component.componentValue.length>0?component.componentValue:@"";
    
}


-(BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    
    _component.componentValue = textField.text;
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if ([string isEqualToString:@""]) {
        return YES;
    }
    return [self validateNumber:string];
}

- (BOOL)validateNumber:(NSString*)number {
    BOOL res = YES;
    NSCharacterSet* tmpSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
    int i = 0;
    while (i < number.length) {
        NSString * string = [number substringWithRange:NSMakeRange(i, 1)];
        NSRange range = [string rangeOfCharacterFromSet:tmpSet];
        if (range.length == 0) {
            res = NO;
            break;
        }
        i++;
    }
    return res;
}

@end
