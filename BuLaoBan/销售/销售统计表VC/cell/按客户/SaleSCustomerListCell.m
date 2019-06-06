//
//  SaleSCustomerListCell.m
//  BuLaoBan
//
//  Created by souxiuyun on 2019/4/3.
//  Copyright © 2019 XX. All rights reserved.
//

#import "SaleSCustomerListCell.h"
#import "SaleSCustomer.h"
#import "SaleSSeller.h"

@implementation SaleSCustomerListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setCustomerModel:(SaleSCustomer *)customerModel{
    _customerModel = customerModel;
    _nameLab.text = customerModel.customerName;
    _timeLab.text = customerModel.sellTimes;
    if (customerModel.sellNum.count>0) {
        NSDictionary *dic = customerModel.sellNum[0];
        _numberLab.text = [NSString stringWithFormat:@"%@",dic[@"value"]];
        _unitLab.text = dic[@"unit"];
    }else{
        _numberLab.text = @"";
        _unitLab.text = @"";
    }
    if (customerModel.deliverPrice.count>0) {
        NSDictionary *dic = customerModel.deliverPrice[0];
        _moneyLab.text = [NSString stringWithFormat:@"￥ %@",dic[@"value"]];
    }else{
        _moneyLab.text = @"";
    }
    
}

-(void)setSellerModel:(SaleSSeller *)sellerModel{
    _sellerModel = sellerModel;
    _nameLab.text = sellerModel.sellerName;
    _timeLab.text = sellerModel.sellTimes;
    if (sellerModel.sellNum.count>0) {
        NSDictionary *dic = sellerModel.sellNum[0];
        _numberLab.text = [NSString stringWithFormat:@"%@",dic[@"value"]];
        _unitLab.text = dic[@"unit"];
    }else{
        _numberLab.text = @"";
        _unitLab.text = @"";
    }
    if (sellerModel.deliverPrice.count>0) {
        NSDictionary *dic = sellerModel.deliverPrice[0];
        _moneyLab.text = [NSString stringWithFormat:@"￥ %@",dic[@"value"]];
    }else{
        _moneyLab.text = @"";
    }
    
    
    
}

@end
