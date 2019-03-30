//
//  PackListModel.h
//  BuLaoBan
//
//  Created by souxiuyun on 2019/3/14.
//  Copyright © 2019 XX. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PackListModel : NSObject

@property (nonatomic, copy) NSString *dyelot;    //缸号
@property (nonatomic, copy) NSString *reel;    //卷号
@property (nonatomic, copy) NSString *meet;    //米数

@property (nonatomic, copy) NSString *pinyin;    //排序用

@property (nonatomic, assign) NSInteger keyboardshodReturn;    //

@property (nonatomic,assign) BOOL noInput;    //是否允许输入，默认No是可以输入

@end

NS_ASSUME_NONNULL_END
