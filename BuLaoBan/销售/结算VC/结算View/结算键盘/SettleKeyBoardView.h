//
//  SettleKeyBoardView.h
//  BuLaoBan
//
//  Created by apple on 2019/2/25.
//  Copyright © 2019年 XX. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^SettleKeyBoardViewReturnBlock)(NSString *selectStr);

@interface SettleKeyBoardView : UIView

@property (nonatomic, copy) SettleKeyBoardViewReturnBlock returnBlock;      //标题

@end

NS_ASSUME_NONNULL_END
