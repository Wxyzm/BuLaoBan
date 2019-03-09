//
//  BillCell.h
//  BuLaoBan
//
//  Created by souxiuyun on 2019/3/9.
//  Copyright © 2019 XX. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ReceivableItems;

NS_ASSUME_NONNULL_BEGIN

@interface BillCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UILabel *billNameLab;

@property (weak, nonatomic) IBOutlet UILabel *dateLab;

@property (weak, nonatomic) IBOutlet UILabel *billNumLab;

@property (weak, nonatomic) IBOutlet UILabel *shouldAccLab;

@property (weak, nonatomic) IBOutlet UILabel *haveAccLab;

@property (weak, nonatomic) IBOutlet UILabel *BalanceLab;

@property (nonatomic , strong) ReceivableItems *Items;          //新闻


@end

NS_ASSUME_NONNULL_END
