//
//  AccountChoseView.h
//  BuLaoBan
//
//  Created by souxiuyun on 2019/4/16.
//  Copyright © 2019 XX. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class Accounts;
typedef void(^AccountChoseViewReturnBlock)(Accounts *model);
@interface AccountChoseView : UIView

@property (nonatomic,strong) NSMutableArray *listArr; //账户列表

@property (nonatomic,copy) AccountChoseViewReturnBlock returnBlock;

- (void)dismiss;
- (void)showInView;
@end

NS_ASSUME_NONNULL_END
