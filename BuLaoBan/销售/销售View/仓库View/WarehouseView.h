//
//  WarehouseView.h
//  BuLaoBan
//
//  Created by souxiuyun on 2019/5/6.
//  Copyright © 2019 XX. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Warehouses;
NS_ASSUME_NONNULL_BEGIN
typedef void(^WarehouseViewReturnBlock)(Warehouses *model);

@interface WarehouseView : UIView

@property (nonatomic,strong) NSMutableArray *dataArr;

@property (nonatomic,copy) WarehouseViewReturnBlock wareBlock;


- (void)dismiss;

- (void)showInView;

@end

NS_ASSUME_NONNULL_END
