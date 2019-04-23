//
//  KindChoseController.h
//  BuLaoBan
//
//  Created by souxiuyun on 2019/4/22.
//  Copyright © 2019 XX. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN
typedef void(^KindChoseControllerReturnBlock)(NSInteger index);

@interface KindChoseController : BaseViewController

//回调
@property (nonatomic,copy) KindChoseControllerReturnBlock returnBlock;



@end

NS_ASSUME_NONNULL_END
