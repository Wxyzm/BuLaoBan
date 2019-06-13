//
//  GetDelCell.h
//  BuLaoBan
//
//  Created by souxiuyun on 2019/4/17.
//  Copyright © 2019 XX. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SellOrderDeliver;
NS_ASSUME_NONNULL_BEGIN

@interface GetDelCell : UITableViewCell

@property (nonatomic,strong)UIButton *deleteBtn;
@property (nonatomic,strong) SellOrderDeliver *model;



@end

NS_ASSUME_NONNULL_END
