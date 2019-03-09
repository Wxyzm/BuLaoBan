//
//  SettlementInputCell.h
//  BuLaoBan
//
//  Created by apple on 2019/2/25.
//  Copyright © 2019年 XX. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class Settlement;
@interface SettlementInputCell : UITableViewCell

@property (nonatomic, strong) UILabel *nameLab;      //标题
@property (nonatomic, strong) UILabel *showLab;      //右侧展示

@property (nonatomic, strong) UIView *lineView;      //底部线条

@property (nonatomic, strong) Settlement *Settlement;      //Settlementmodel

@end

NS_ASSUME_NONNULL_END
