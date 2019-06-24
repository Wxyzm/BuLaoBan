//
//  NewPackListView.h
//  BuLaoBan
//
//  Created by souxiuyun on 2019/6/18.
//  Copyright © 2019 XX. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class SaleSamModel;
@class DeliveDetails;

typedef void(^NewPackingListViewSaveBlock)(SaleSamModel *saleSamModel);

@interface NewPackListView : UIView

@property (nonatomic, strong) SaleSamModel    *saleSamModel;
@property (nonatomic, strong) DeliveDetails   *deliveDetails;
@property (nonatomic, copy) NewPackingListViewSaveBlock returnBlock;

- (void)showView;
- (void)dismiss;
@end

NS_ASSUME_NONNULL_END
