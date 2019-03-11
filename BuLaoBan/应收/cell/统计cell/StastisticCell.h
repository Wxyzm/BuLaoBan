//
//  StastisticCell.h
//  BuLaoBan
//
//  Created by souxiuyun on 2019/3/11.
//  Copyright © 2019 XX. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class StasticeItem;
@interface StastisticCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet UILabel *recevaBefoLab;
@property (weak, nonatomic) IBOutlet UILabel *recevaCurrLab;
@property (weak, nonatomic) IBOutlet UILabel *receiptCurrLab;
@property (weak, nonatomic) IBOutlet UILabel *balanceLab;

@property (nonatomic , strong) StasticeItem *Item;          //

@end

NS_ASSUME_NONNULL_END
