//
//  SampleSearchResultView.h
//  BuLaoBan
//
//  Created by souxiuyun on 2019/3/13.
//  Copyright © 2019 XX. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


typedef void(^SampleSearchResultViewReturnBlock)(Sample *SampleModel);

@interface SampleSearchResultView : UIView

@property (nonatomic, strong) NSMutableArray      *dataArr;
@property (nonatomic, copy) SampleSearchResultViewReturnBlock    returnBlock;


- (void)showinView:(UIView *)view;
- (void)dismiss;
@end

NS_ASSUME_NONNULL_END
