//
//  SaleListCell.h
//  BuLaoBan
//
//  Created by apple on 2019/2/20.
//  Copyright © 2019年 XX. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SaleSamModel;
@class DeliveDetails;
NS_ASSUME_NONNULL_BEGIN
typedef void(^SaleListCellReturnBlock)(SaleSamModel *model,NSInteger type);

@interface SaleListCell : UITableViewCell

@property (nonatomic, strong) SaleSamModel *model;
//销售历史
@property (nonatomic, strong) DeliveDetails *deliveDetails;


/**
 type:0删除 1细码单 2填写完成
 */
@property (nonatomic, copy) SaleListCellReturnBlock returnBlock;


/**
 细码单
 */
@property (nonatomic, strong) UIButton *codeListBtn;

@end

NS_ASSUME_NONNULL_END
