//
//  SettleMoneyCell.h
//  BuLaoBan
//
//  Created by souxiuyun on 2019/3/16.
//  Copyright © 2019 XX. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class Settlement;

typedef void(^SettleMoneyCellReturnBlock)(Settlement *model);

@interface SettleMoneyCell : UITableViewCell
@property (nonatomic, strong) UILabel *nameLab;      //标题
@property (nonatomic, strong) UIView *lineView;      //底部线条
@property (nonatomic, strong) Settlement *Settlement;      //Settlementmodel

@property (nonatomic,copy) SettleMoneyCellReturnBlock returnBlock;

@end

NS_ASSUME_NONNULL_END
