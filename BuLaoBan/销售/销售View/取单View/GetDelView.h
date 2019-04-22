//
//  GetDelView.h
//  BuLaoBan
//
//  Created by souxiuyun on 2019/4/17.
//  Copyright © 2019 XX. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^GetDelViewReturnBlock)(NSString *orderID);
@interface GetDelView : UIView


@property (nonatomic,strong) NSMutableArray *dataArr;

@property (nonatomic,copy) GetDelViewReturnBlock returnBlock;


- (void)dismiss;
- (void)showInView;


@end

NS_ASSUME_NONNULL_END
