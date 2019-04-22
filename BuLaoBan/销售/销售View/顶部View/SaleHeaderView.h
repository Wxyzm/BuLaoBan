//
//  SaleHeaderView.h
//  BuLaoBan
//
//  Created by apple on 2019/2/19.
//  Copyright © 2019年 XX. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^SaleHeaderViewBtnBlock)(NSInteger tag);

@interface SaleHeaderView : UIView

@property (nonatomic, strong) UIButton *getBtn;          //取单


/**
 0:销售历史   1：s销售统计    2：挂单   3：取单
 */
@property (nonatomic, copy) SaleHeaderViewBtnBlock returnBlock;

//设置取单按钮数量
- (void)setgetBtnNumber:(NSInteger)number;

@end

NS_ASSUME_NONNULL_END
