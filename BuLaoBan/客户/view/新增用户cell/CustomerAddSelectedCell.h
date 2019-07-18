//
//  CustomerAddSelectedCell.h
//  BuLaoBan
//
//  Created by souxiuyun on 2019/7/4.
//  Copyright © 2019 XX. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CustomerAddTypeModel;
@protocol CustomerAddSelectedCellDelegate <NSObject>

- (void)selectedBtnWithModel:(CustomerAddTypeModel *)model;

@end

NS_ASSUME_NONNULL_BEGIN

@interface CustomerAddSelectedCell : UITableViewCell

@property (nonatomic,strong) UILabel *nameLab;
@property (nonatomic,strong) UILabel *starLab;
@property (nonatomic,strong) YLButton *selectedBtn;
@property (nonatomic,strong) UIView *line;
@property (nonatomic,strong) CustomerAddTypeModel *model;
@property (nonatomic,weak) id<CustomerAddSelectedCellDelegate> delegate;


@end

NS_ASSUME_NONNULL_END
