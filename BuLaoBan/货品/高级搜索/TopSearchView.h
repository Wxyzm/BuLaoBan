//
//  TopSearchView.h
//  BuLaoBan
//
//  Created by souxiuyun on 2019/4/1.
//  Copyright © 2019 XX. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^TopSearchViewReturnBlock)(NSDictionary *keyDic);

@interface TopSearchView : UIView

@property (nonatomic,copy) TopSearchViewReturnBlock returnBlock;


- (void)showView;
- (void)dismiss;

@end

NS_ASSUME_NONNULL_END
