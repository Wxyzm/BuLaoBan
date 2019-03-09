//
//  AddGoodsView.h
//  BuLaoBan
//
//  Created by apple on 2019/2/11.
//  Copyright © 2019年 XX. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^AddGoodsViewChoseBlock)(NSInteger btnTag);

@interface AddGoodsView : UIView

/**
 0：关闭  1：成分 2：克重 3：门幅  4：单位 
 */
@property (nonatomic, copy) AddGoodsViewChoseBlock choseBlock;
@property (nonatomic, strong) SampleDetail *sampleModel;

@property (nonatomic, assign) BOOL isNew;



@end

NS_ASSUME_NONNULL_END
