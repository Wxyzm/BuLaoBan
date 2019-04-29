//
//  TypeChoseView.h
//  BuLaoBan
//
//  Created by souxiuyun on 2019/4/27.
//  Copyright © 2019 XX. All rights reserved.
//

#import <UIKit/UIKit.h>


NS_ASSUME_NONNULL_BEGIN

typedef void(^TypeChoseViewReturnBlock)(NSInteger index);
@interface TypeChoseView : UIView

@property (nonatomic,copy)TypeChoseViewReturnBlock returnBlock;

- (void)dismiss;

- (void)showInView;
@end

NS_ASSUME_NONNULL_END
