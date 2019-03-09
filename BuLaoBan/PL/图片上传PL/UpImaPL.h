//
//  UpImaPL.h
//  BuLaoBan
//
//  Created by souxiuyun on 2019/3/6.
//  Copyright © 2019 XX. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface UpImaPL : NSObject

/**
上传图片

@param imageArr 图片数组
@param returnBlock 成功
@param errorBlock 失败
*/
+ (void)UpImaPLupImgArr:(NSArray*)imageArr
             WithTypeDic:(NSDictionary *)typedic
        WithReturnBlock:(PLReturnValueBlock) returnBlock
         andErrorBlock:(PLErrorCodeBlock) errorBlock;


@end

NS_ASSUME_NONNULL_END
