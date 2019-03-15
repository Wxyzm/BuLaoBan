//
//  PacklistCell.m
//  BuLaoBan
//
//  Created by souxiuyun on 2019/3/14.
//  Copyright © 2019 XX. All rights reserved.
//  已经没事了！要问为何？因为！我来了

#import "PacklistCell.h"
#import "PackListModel.h"
#import "IQKeyboardManager.h"

@interface PacklistCell ()<UITextFieldDelegate>



@end
@implementation PacklistCell{
 
    

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
    _dyelotTxt = [BaseViewFactory textFieldWithFrame:CGRectMake(0, 0, 150, 30) font:APPFONT12 placeholder:@"" textColor:UIColorFromRGB(BlackColorValue) placeholderColor:nil delegate:self];
    _dyelotTxt.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:_dyelotTxt];
    
    _reelTxt = [BaseViewFactory textFieldWithFrame:CGRectMake(150, 0, 100, 30) font:APPFONT12 placeholder:@"" textColor:UIColorFromRGB(BlackColorValue) placeholderColor:nil delegate:self];
    _reelTxt.textAlignment = NSTextAlignmentCenter;
    _reelTxt.userInteractionEnabled = NO;
    [self.contentView addSubview:_reelTxt];
    
    _meetTxt = [BaseViewFactory textFieldWithFrame:CGRectMake(250, 0, 150, 30) font:APPFONT12 placeholder:@"" textColor:UIColorFromRGB(BlackColorValue) placeholderColor:nil delegate:self];
    _meetTxt.textAlignment = NSTextAlignmentCenter;
    _meetTxt.keyboardType = UIKeyboardTypeNumberPad;
    [self.contentView addSubview:_meetTxt];
    
    UIView *line = [BaseViewFactory viewWithFrame:CGRectMake(0, 0, 400, 1) color:UIColorFromRGB(LineColorValue)];
    [self.contentView addSubview:line];
    
    UIView *line1 = [BaseViewFactory viewWithFrame:CGRectMake(149.5, 0, 1, 30) color:UIColorFromRGB(LineColorValue)];
    [self.contentView addSubview:line1];
    
    UIView *line2 = [BaseViewFactory viewWithFrame:CGRectMake(249.5, 0, 1, 30) color:UIColorFromRGB(LineColorValue)];
    [self.contentView addSubview:line2];
    
    
    UIView *line3 = [BaseViewFactory viewWithFrame:CGRectMake(0, 0, 1, 30) color:UIColorFromRGB(LineColorValue)];
    [self.contentView addSubview:line3];
    
    UIView *line4 = [BaseViewFactory viewWithFrame:CGRectMake(399, 0, 1, 30) color:UIColorFromRGB(LineColorValue)];
    [self.contentView addSubview:line4];
    
}

-(void)setPackModel:(PackListModel *)packModel{
    _packModel = packModel;
    _dyelotTxt.text = packModel.dyelot;
    _reelTxt.text = packModel.reel;
    _meetTxt.text = packModel.meet;
    
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (textField ==_meetTxt) {
        //当下一个缸号无数据时需带入数据
        WeakSelf(self);
        if (weakself.InsertBlock) {
            weakself.InsertBlock(_packModel);
        }
        [[IQKeyboardManager sharedManager] goNext];

    }else{
        [[IQKeyboardManager sharedManager] goNext];

    }
    return YES;
}

-(BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    
    _packModel.dyelot= _dyelotTxt.text;
    _packModel.reel =_reelTxt.text;
    _packModel.meet= _meetTxt.text;
    if (_dyelotTxt.text.length<=0&&_meetTxt.text.length<=0) {
        _packModel.reel = @"";
        _reelTxt.text = @"";
    }
    if (_packModel.keyboardshodReturn<1) {
        _packModel.keyboardshodReturn+=1;
        return NO;
    }
    return YES;
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if (textField ==_meetTxt) {
        if ([string isEqualToString:@""]) {
            return YES;
        }
        if (_packModel.dyelot.length<=0) {
            [HUD showMessage:@"请输入缸号" inView:self.contentView];
            return NO;
        }
    }
    
    return YES;
}



@end
