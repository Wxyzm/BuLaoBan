//
//  MenueView.h
//  BuLaoBan
//
//  Created by apple on 2019/1/28.
//  Copyright © 2019年 XX. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^MenueViewReturnBlock)(NSInteger index);

NS_ASSUME_NONNULL_BEGIN

@interface MenueView : UIView

@property (strong, nonatomic) UIImageView *faceIma;

@property (copy, nonatomic) MenueViewReturnBlock returnBlock;

@end

NS_ASSUME_NONNULL_END
