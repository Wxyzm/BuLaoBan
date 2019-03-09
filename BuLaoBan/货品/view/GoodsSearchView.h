//
//  GoodsSearchView.h
//  BuLaoBan
//
//  Created by apple on 2019/2/10.
//  Copyright © 2019年 XX. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^GoodsSearchViewReturnBlock)(NSString *searchtxt);

@interface GoodsSearchView : UIView

@property (copy, nonatomic) GoodsSearchViewReturnBlock returnBlock;

@end

NS_ASSUME_NONNULL_END
