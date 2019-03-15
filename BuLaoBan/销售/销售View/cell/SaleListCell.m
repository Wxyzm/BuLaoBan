//
//  SaleListCell.m
//  BuLaoBan
//
//  Created by apple on 2019/2/20.
//  Copyright © 2019年 XX. All rights reserved.
//

#import "SaleListCell.h"
#import "SaleSamModel.h"
#import "IQKeyboardManager.h"

@interface SaleListCell ()<UITextFieldDelegate>

/**
 图片
 */
@property (nonatomic, strong) UIImageView *faceIma;

/**
 编号
 */
@property (nonatomic, strong) UITextField *numTxt;

/**
 品名
 */
@property (nonatomic, strong) UITextField *nameTxt;


/**
 颜色
 */
@property (nonatomic, strong) UITextField *colorTxt;

/**
 单价
 */
@property (nonatomic, strong) UITextField *unitPriceTxt;

/**
 细码单
 */
@property (nonatomic, strong) UIButton *codeListBtn;

/**
 匹数
 */
@property (nonatomic, strong) UITextField *matchesNumTxt;

/**
 销货量
 */
@property (nonatomic, strong) UITextField *salesNumTxt;

/**
 单位
 */
@property (nonatomic, strong) UITextField *unitTxt;

/**
 金额
 */
@property (nonatomic, strong) UITextField *amoutMoneyTxt;


/**
 操作删除按钮
 */
@property (nonatomic, strong) UIButton *deleteBtn;


@end


@implementation SaleListCell


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
    
    _faceIma = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 30, 30)];
    [self.contentView addSubview:_faceIma];
    _faceIma.clipsToBounds = YES;
    _faceIma.backgroundColor = UIColorFromRGB(BackColorValue);
    
    _numTxt = [BaseViewFactory textFieldWithFrame:CGRectMake(58, 7, 100, 15) font:APPFONT12 placeholder:@"" textColor:UIColorFromRGB(BlackColorValue) placeholderColor:UIColorFromRGB(PLAColorValue) delegate:self];
    _numTxt.userInteractionEnabled = NO;
    _numTxt.text = @"HK-TR017";
    [self.contentView addSubview:_numTxt];

    _nameTxt = [BaseViewFactory textFieldWithFrame:CGRectMake(58, 29, 100, 13) font:APPFONT(10) placeholder:@"" textColor:UIColorFromRGB(0X666666) placeholderColor:UIColorFromRGB(PLAColorValue) delegate:self];
    _nameTxt.userInteractionEnabled = NO;
    _nameTxt.text = @"SZ弹力汉布";
    [self.contentView addSubview:_nameTxt];
    
    _colorTxt = [BaseViewFactory textFieldWithFrame:CGRectMake(177, 0, 50, 50) font:APPFONT(12) placeholder:@"颜色" textColor:UIColorFromRGB(BlackColorValue) placeholderColor:UIColorFromRGB(PLAColorValue) delegate:self];
    [self.contentView addSubview:_colorTxt];
    
    _unitPriceTxt = [BaseViewFactory textFieldWithFrame:CGRectMake(246, 0, 50, 50) font:APPFONT(12) placeholder:@"单价" textColor:UIColorFromRGB(BlackColorValue) placeholderColor:UIColorFromRGB(PLAColorValue) delegate:self];
    _unitPriceTxt.keyboardType = UIKeyboardTypeDecimalPad;
    [self.contentView addSubview:_unitPriceTxt];
    
    _codeListBtn = [BaseViewFactory buttonWithFrame:CGRectMake(310.5, 0, 49, 50) font:APPFONT12 title:@"添加" titleColor:UIColorFromRGB(BlueColorValue) backColor:UIColorFromRGB(WhiteColorValue)];
    [_codeListBtn addTarget:self action:@selector(codeListBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:_codeListBtn];

    _matchesNumTxt = [BaseViewFactory textFieldWithFrame:CGRectMake(370, 0, 45, 50) font:APPFONT(12) placeholder:@"匹数" textColor:UIColorFromRGB(BlackColorValue) placeholderColor:UIColorFromRGB(PLAColorValue) delegate:self];
    _matchesNumTxt.keyboardType = UIKeyboardTypeDecimalPad;
    [self.contentView addSubview:_matchesNumTxt];
    
    _salesNumTxt = [BaseViewFactory textFieldWithFrame:CGRectMake(430, 0, 100, 50) font:APPFONT(12) placeholder:@"销货量" textColor:UIColorFromRGB(BlackColorValue) placeholderColor:UIColorFromRGB(PLAColorValue) delegate:self];
    _salesNumTxt.keyboardType = UIKeyboardTypeDecimalPad;
    [self.contentView addSubview:_salesNumTxt];
    
    _unitTxt = [BaseViewFactory textFieldWithFrame:CGRectMake(530, 0, 45, 50) font:APPFONT(12) placeholder:@"米" textColor:UIColorFromRGB(BlackColorValue) placeholderColor:UIColorFromRGB(PLAColorValue) delegate:self];
    [self.contentView addSubview:_unitTxt];
    
    _amoutMoneyTxt = [BaseViewFactory textFieldWithFrame:CGRectMake(580, 0, 60, 50) font:APPFONT(12) placeholder:@"金额" textColor:UIColorFromRGB(BlackColorValue) placeholderColor:UIColorFromRGB(PLAColorValue) delegate:self];
    _amoutMoneyTxt.keyboardType = UIKeyboardTypeDecimalPad;
    [self.contentView addSubview:_amoutMoneyTxt];
    
    
    _deleteBtn = [BaseViewFactory buttonWithFrame:CGRectMake(660, 0, 45, 50) font:APPFONT12 title:@"删除" titleColor:UIColorFromRGB(BlueColorValue) backColor:UIColorFromRGB(WhiteColorValue)];
    [_deleteBtn addTarget:self action:@selector(deleteBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:_deleteBtn];

    
    for (int i = 0; i<10; i++) {
        UIView *line = [BaseViewFactory viewWithFrame:CGRectZero color:UIColorFromRGB(LineColorValue)];
        [self.contentView addSubview:line];
        switch (i) {
            case 0:{
                line.frame = CGRectMake(49.5, 0, 1, 50);
                break;
            }
            case 1:{
                line.frame = CGRectMake(169.5, 0, 1, 50);
                break;
            }
            case 2:{
                line.frame = CGRectMake(239.5, 0, 1, 50);
                break;
            }
            case 3:{
                line.frame = CGRectMake(309.5, 0, 1, 50);
                break;
            }
            case 4:{
                line.frame = CGRectMake(359.5, 0, 1, 50);
                break;
            }
            case 5:{
                line.frame = CGRectMake(419.5, 0, 1, 50);
                break;
            }
            case 6:{
                line.frame = CGRectMake(519.5, 0, 1, 50);
                break;
            }
            case 7:{
                line.frame = CGRectMake(569.5, 0, 1, 50);
                break;
            }
            case 8:{
                line.frame = CGRectMake(659.5, 0, 1, 50);
                break;
            }
            case 9:{
                line.hidden = YES;
                break;
            }
            default:
                break;
        }
        
        
    }
    UIView *line1 = [BaseViewFactory viewWithFrame:CGRectMake(0, 49, 704, 1) color:UIColorFromRGB(LineColorValue)];
    [self.contentView addSubview:line1];
    
}

-(void)setModel:(SaleSamModel *)model{
    _model = model;
    [_faceIma sd_setImageWithURL:[NSURL URLWithString:model.urlStr] placeholderImage:nil]; //图片
    _numTxt.text = model.itemNo;  //编号
    _nameTxt.text = model.name;   //名称
    _colorTxt.text = model.color; //颜色
    _unitPriceTxt.text = model.unitPrice;    //单价
    _matchesNumTxt.text = model.pieces;      //匹数
    _salesNumTxt.text = model.salesVol;      //销货量
    _unitTxt.text = model.unit;              //单位
    _amoutMoneyTxt.text = model.money;       //金额
    if (model.packingList.count>0) {
        //若新增了细码单，则无法输入米数和匹数销货量，且总码单是细码单算出来的（匹数和米数）
        _matchesNumTxt.userInteractionEnabled = NO;
        _salesNumTxt.userInteractionEnabled = NO;
        [_codeListBtn setTitle:@"查看" forState:UIControlStateNormal];

    }else{
        [_codeListBtn setTitle:@"添加" forState:UIControlStateNormal];

        _matchesNumTxt.userInteractionEnabled = YES;
        _salesNumTxt.userInteractionEnabled = YES;
    }
    
    
}


#pragma mark==== 按钮点击

/**
 添加细码单
 */
- (void)codeListBtnClick{
    if (_model.salesVol.length>0||_model.pieces.length) {
        [HUD show:@"输入匹数或销货量后无法添加细码单"];
        return;
    }
    WeakSelf(self);
    if (weakself.returnBlock) {
        weakself.returnBlock(_model, 1);
    }
}


/**
 删除
 */
- (void)deleteBtnClick{
    WeakSelf(self);
    if (weakself.returnBlock) {
        weakself.returnBlock(_model, 0);
    }
}

#pragma mark==== textfield
-(BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    if (textField ==_colorTxt) {
        //颜色
        _model.color =_colorTxt.text;
    }else if (textField == _unitPriceTxt){
        //单价
        _model.unitPrice = _unitPriceTxt.text;
        [self setModelMoney];

    }else if (textField ==_matchesNumTxt){
        //匹数
        _model.pieces = _matchesNumTxt.text;
    }else if (textField ==_salesNumTxt){
        //销货量
        _model.salesVol = _salesNumTxt.text;
        [self setModelMoney];
    }else if (textField ==_unitTxt){
        //单位
        _model.unit = _unitTxt.text;
    }else if (textField ==_amoutMoneyTxt){
        //金额
        _model.money = _amoutMoneyTxt.text;
    }
    
    WeakSelf(self);
    if (weakself.returnBlock) {
        weakself.returnBlock(_model, 2);
    }
    return YES;
    
}




//算出总价
- (void)setModelMoney{
    if (_model.unitPrice.length>0&&_model.salesVol.length) {
        _model.money = [NSString stringWithFormat:@"%.2f",[_model.unitPrice floatValue]*[_model.salesVol floatValue]];
        _amoutMoneyTxt.text = _model.money;
    }
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [[IQKeyboardManager sharedManager] goNext];
    return YES;
}



//有细码单无细码单    是否扣进库存   现在做不扣进库存

//细码单全部从新输入，若销货单输入米数或匹数总数，点击新增细码单无法点击
//若新增了细码单，则无法输入米数和匹数，且总码单是细码单算出来的（匹数和米数）




@end
