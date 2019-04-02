//
//  SaleSGoodsCell.h
//  BuLaoBan
//
//  Created by souxiuyun on 2019/4/2.
//  Copyright © 2019 XX. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SaleSGoodsCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *faceIma;
@property (weak, nonatomic) IBOutlet UILabel *numberLab;
@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet UILabel *colorLab;
@property (weak, nonatomic) IBOutlet UILabel *saleNumberLab;
@property (weak, nonatomic) IBOutlet UILabel *unitLab;
@property (weak, nonatomic) IBOutlet UILabel *customerNumLab;
@property (weak, nonatomic) IBOutlet UILabel *moneyLab;

@end

NS_ASSUME_NONNULL_END
