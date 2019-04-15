//
//  AddCusCell.h
//  BuLaoBan
//
//  Created by souxiuyun on 2019/4/7.
//  Copyright © 2019 XX. All rights reserved.
//

#import <UIKit/UIKit.h>


NS_ASSUME_NONNULL_BEGIN
@class AddCusModel;

@interface AddCusCell : UITableViewCell

@property (nonatomic,strong) UILabel *nameLab;

@property (nonatomic,strong) UITextField *infoTxt;

@property (nonatomic,strong) YLButton *selectBtn;

@property (nonatomic,strong) AddCusModel *model;

@end

NS_ASSUME_NONNULL_END
