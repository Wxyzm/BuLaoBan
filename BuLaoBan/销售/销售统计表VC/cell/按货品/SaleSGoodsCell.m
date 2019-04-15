//
//  SaleSGoodsCell.m
//  BuLaoBan
//
//  Created by souxiuyun on 2019/4/2.
//  Copyright © 2019 XX. All rights reserved.
//

#import "SaleSGoodsCell.h"
#import "SaleSSample.h"

@implementation SaleSGoodsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _faceIma.backgroundColor = UIColorFromRGB(BackColorValue);
    _faceIma.clipsToBounds = YES;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

-(void)setSampleModel:(SaleSSample *)sampleModel{
    _sampleModel = sampleModel;
    [_faceIma sd_setImageWithURL:[NSURL URLWithString:sampleModel.samplePicKey] placeholderImage:nil];
    _numberLab.text = sampleModel.itemNo;
    _nameLab.text = sampleModel.name;
    _colorLab.text = sampleModel.colorName;
    if (sampleModel.sellNum.count>0) {
        NSDictionary *dic = sampleModel.sellNum[0];
        _saleNumberLab.text = [NSString stringWithFormat:@"%@",dic[@"value"]];
        
        _unitLab.text = dic[@"unit"];
    }else{
        _saleNumberLab.text = @"";
        _unitLab.text = @"";
    }
    
    _customerNumLab.text = @"1";
    if (sampleModel.sellPrice.count>0) {
        NSDictionary *dic = sampleModel.sellNum[0];
        _moneyLab.text = [NSString stringWithFormat:@"￥ %@",dic[@"value"]];
    }else{
        _moneyLab.text = @"";
    }
    
}

@end
