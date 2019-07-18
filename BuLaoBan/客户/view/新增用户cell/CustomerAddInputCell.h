//
//  CustomerAddInputCell.h
//  BuLaoBan
//
//  Created by souxiuyun on 2019/7/4.
//  Copyright © 2019 XX. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CustomerAddTypeModel;
NS_ASSUME_NONNULL_BEGIN

@interface CustomerAddInputCell : UITableViewCell

@property (nonatomic,strong) UILabel *nameLab;
@property (nonatomic,strong) UILabel *starLab;
@property (nonatomic,strong) UITextField *inputTxt;
@property (nonatomic,strong) UIView *line;

@property (nonatomic,strong) CustomerAddTypeModel *model;



@end

NS_ASSUME_NONNULL_END
