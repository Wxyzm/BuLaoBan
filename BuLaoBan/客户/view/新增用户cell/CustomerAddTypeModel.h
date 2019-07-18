//
//  CustomerAddTypeModel.h
//  BuLaoBan
//
//  Created by souxiuyun on 2019/7/4.
//  Copyright © 2019 XX. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CustomerAddTypeModel : NSObject

@property (nonatomic,copy) NSString *title;
@property (nonatomic,assign) BOOL isMustInput;
/**
 1：输入 2选择  3输入加选择
 */
@property (nonatomic,assign) NSInteger cellType;

@property (nonatomic,copy) NSString *showvalue;
@property (nonatomic,copy) NSString *valueId;
@property (nonatomic,copy) NSString *upStr;



@end

NS_ASSUME_NONNULL_END
