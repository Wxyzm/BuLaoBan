//
//  SaleHistoryController.h
//  BuLaoBan
//
//  Created by apple on 2019/2/27.
//  Copyright © 2019年 XX. All rights reserved.
//

#import "BaseViewController.h"
@class SellOrderDeliverDetail;

typedef void(^SaleHistoryReturnBlock)(SellOrderDeliverDetail * _Nonnull detailModel);

NS_ASSUME_NONNULL_BEGIN

@interface SaleHistoryController : BaseViewController

@property (nonatomic,copy) SaleHistoryReturnBlock returnBlock;


@end

NS_ASSUME_NONNULL_END
