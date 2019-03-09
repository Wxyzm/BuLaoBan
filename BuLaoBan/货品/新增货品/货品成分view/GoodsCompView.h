//
//  GoodsCompView.h
//  BuLaoBan
//
//  Created by apple on 2019/2/12.
//  Copyright © 2019年 XX. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^GoodsCompViewChoseBlock)(NSString *comp);

@interface GoodsCompView : UIView


/**
 @""：关闭   ：保存
 */
@property (nonatomic, copy) GoodsCompViewChoseBlock choseBlock;

@end

NS_ASSUME_NONNULL_END
