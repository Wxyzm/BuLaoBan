//
//  SaleListCell.m
//  BuLaoBan
//
//  Created by apple on 2019/2/20.
//  Copyright © 2019年 XX. All rights reserved.
//

#import "SaleListCell.h"

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
    
    _colorTxt = [BaseViewFactory textFieldWithFrame:CGRectMake(177, 0, 50, 50) font:APPFONT(12) placeholder:@"颜色" textColor:UIColorFromRGB(0X9b9b9b) placeholderColor:UIColorFromRGB(PLAColorValue) delegate:self];
    [self.contentView addSubview:_colorTxt];
    
    _unitPriceTxt = [BaseViewFactory textFieldWithFrame:CGRectMake(246, 0, 50, 50) font:APPFONT(12) placeholder:@"单价" textColor:UIColorFromRGB(0X9b9b9b) placeholderColor:UIColorFromRGB(PLAColorValue) delegate:self];
    [self.contentView addSubview:_unitPriceTxt];
    
    _codeListBtn = [BaseViewFactory buttonWithFrame:CGRectMake(310.5, 0, 49, 50) font:APPFONT12 title:@"添加" titleColor:UIColorFromRGB(BlueColorValue) backColor:UIColorFromRGB(WhiteColorValue)];
    [self.contentView addSubview:_codeListBtn];

    _matchesNumTxt = [BaseViewFactory textFieldWithFrame:CGRectMake(370, 0, 45, 50) font:APPFONT(12) placeholder:@"匹数" textColor:UIColorFromRGB(0X9b9b9b) placeholderColor:UIColorFromRGB(PLAColorValue) delegate:self];
    [self.contentView addSubview:_matchesNumTxt];
    
    _salesNumTxt = [BaseViewFactory textFieldWithFrame:CGRectMake(430, 0, 100, 50) font:APPFONT(12) placeholder:@"销货量" textColor:UIColorFromRGB(0X9b9b9b) placeholderColor:UIColorFromRGB(PLAColorValue) delegate:self];
    [self.contentView addSubview:_salesNumTxt];
    
    _unitTxt = [BaseViewFactory textFieldWithFrame:CGRectMake(530, 0, 45, 50) font:APPFONT(12) placeholder:@"米" textColor:UIColorFromRGB(0X9b9b9b) placeholderColor:UIColorFromRGB(PLAColorValue) delegate:self];
    [self.contentView addSubview:_unitTxt];
    
    _amoutMoneyTxt = [BaseViewFactory textFieldWithFrame:CGRectMake(580, 0, 60, 50) font:APPFONT(12) placeholder:@"金额" textColor:UIColorFromRGB(0X9b9b9b) placeholderColor:UIColorFromRGB(PLAColorValue) delegate:self];
    [self.contentView addSubview:_amoutMoneyTxt];
    
    
    _deleteBtn = [BaseViewFactory buttonWithFrame:CGRectMake(660, 0, 45, 50) font:APPFONT12 title:@"删除" titleColor:UIColorFromRGB(BlueColorValue) backColor:UIColorFromRGB(WhiteColorValue)];
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

@end
