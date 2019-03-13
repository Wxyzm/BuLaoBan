//
//  CustomerSelectedCell.h
//  BuLaoBan
//
//  Created by souxiuyun on 2019/3/12.
//  Copyright © 2019 XX. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ComCustomer;
NS_ASSUME_NONNULL_BEGIN

@interface CustomerSelectedCell : UITableViewCell
@property (nonatomic, strong) ComCustomer      *model;

@end

NS_ASSUME_NONNULL_END
