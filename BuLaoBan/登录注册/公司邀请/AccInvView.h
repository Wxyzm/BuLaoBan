//
//  AccInvView.h
//  BuLaoBan
//
//  Created by souxiuyun on 2019/4/26.
//  Copyright © 2019 XX. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AccInvView : UIView

@property (nonatomic,strong) NSDictionary *infoDic;

- (void)showView:(UIView *)view;
- (void)dismiss;

@end

NS_ASSUME_NONNULL_END
