//
//  GoodsWeightView.h
//  BuLaoBan
//
//  Created by souxiuyun on 2019/3/7.
//  Copyright © 2019 XX. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^GoodsWeightViewChoseBlock)(NSString *weight);

@interface GoodsWeightView : UIView
/**
 @""：关闭   ：保存
 */
@property (nonatomic, copy) GoodsWeightViewChoseBlock choseBlock;
@end

NS_ASSUME_NONNULL_END
