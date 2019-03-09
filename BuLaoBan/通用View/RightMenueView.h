//
//  RightMenueView.h
//  BuLaoBan
//
//  Created by souxiuyun on 2019/3/6.
//  Copyright © 2019 XX. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^RightMenueViewReturnBlock)(NSInteger index);

@interface RightMenueView : UIView

-(instancetype)initWithTitleArr:(NSArray *)titleArr;

@property(nonatomic,copy)RightMenueViewReturnBlock returnBlock;

@end

NS_ASSUME_NONNULL_END
