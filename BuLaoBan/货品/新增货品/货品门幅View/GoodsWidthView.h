//
//  GoodsWidthView.h
//  BuLaoBan
//
//  Created by apple on 2019/2/12.
//  Copyright © 2019年 XX. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^GoodsWidthViewChoseBlock)(NSString *width);


@interface GoodsWidthView : UIView

@property (nonatomic, strong) NSMutableArray *dataArr;

/**
 @""：关闭   1
 */
@property (nonatomic, copy) GoodsWidthViewChoseBlock choseBlock;
@end

NS_ASSUME_NONNULL_END
