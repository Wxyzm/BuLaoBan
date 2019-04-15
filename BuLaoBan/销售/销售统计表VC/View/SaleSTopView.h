//
//  SaleSTopView.h
//  BuLaoBan
//
//  Created by souxiuyun on 2019/4/2.
//  Copyright © 2019 XX. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class Statics;

typedef void(^SaleSTopViewReturnBlock)(NSInteger tag);

@interface SaleSTopView : UIView


@property (nonatomic, strong) UITextField  *numberTxt;
@property (nonatomic,copy) SaleSTopViewReturnBlock returnBlock;
@property (nonatomic,strong) Statics *statics;


/**
 设置按钮标题
 
 @param tag 6:开始日期 7:结束日期 8:客户 9：业务员
 */
- (void)setTitle:(NSString *)title withTag:(NSInteger)tag;

@end

NS_ASSUME_NONNULL_END
