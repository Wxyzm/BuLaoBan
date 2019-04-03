//
//  SaleSTopView.h
//  BuLaoBan
//
//  Created by souxiuyun on 2019/4/2.
//  Copyright © 2019 XX. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^SaleSTopViewReturnBlock)(NSInteger tag);

@interface SaleSTopView : UIView

@property (nonatomic,copy) SaleSTopViewReturnBlock returnBlock;

@end

NS_ASSUME_NONNULL_END
