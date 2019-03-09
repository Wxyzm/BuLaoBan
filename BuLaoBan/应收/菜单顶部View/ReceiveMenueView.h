//
//  ReceiveMenueView.h
//  BuLaoBan
//
//  Created by apple on 2019/2/27.
//  Copyright © 2019年 XX. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^ReceiveMenueViewBlock)(NSInteger tag);


@interface ReceiveMenueView : UIView

/**
 0:应收对账单/货品 1:应收对账单/单 2:应收统计表
 */
@property (nonatomic , copy) ReceiveMenueViewBlock returnBlock;         //

- (void)showinView:(UIView *)view;
- (void)dismiss;

@end

NS_ASSUME_NONNULL_END
