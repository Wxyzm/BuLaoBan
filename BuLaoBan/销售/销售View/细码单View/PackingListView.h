//
//  PackingListView.h
//  BuLaoBan
//
//  Created by souxiuyun on 2019/3/14.
//  Copyright © 2019 XX. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SaleSamModel;
@class DeliveDetails;
NS_ASSUME_NONNULL_BEGIN

typedef void(^PackingListViewSaveBlock)(SaleSamModel *saleSamModel);

@interface PackingListView : UIView

@property (nonatomic, strong) SaleSamModel    *saleSamModel;
@property (nonatomic, strong) DeliveDetails   *deliveDetails;



@property (nonatomic, copy) PackingListViewSaveBlock returnBlock;

- (void)showView;
- (void)dismiss;

@end

NS_ASSUME_NONNULL_END
