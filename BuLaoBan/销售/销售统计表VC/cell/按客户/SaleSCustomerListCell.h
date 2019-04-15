//
//  SaleSCustomerListCell.h
//  BuLaoBan
//
//  Created by souxiuyun on 2019/4/3.
//  Copyright © 2019 XX. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SaleSCustomer;
@class SaleSSeller;
NS_ASSUME_NONNULL_BEGIN

@interface SaleSCustomerListCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet UILabel *timeLab;
@property (weak, nonatomic) IBOutlet UILabel *numberLab;
@property (weak, nonatomic) IBOutlet UILabel *unitLab;
@property (weak, nonatomic) IBOutlet UILabel *moneyLab;

@property (nonatomic,strong) SaleSCustomer *customerModel;
@property (nonatomic,strong) SaleSSeller *sellerModel;

@end

NS_ASSUME_NONNULL_END
