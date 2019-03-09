//
//  picModel.h
//  BuLaoBan
//
//  Created by apple on 2019/2/11.
//  Copyright © 2019年 XX. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface picModel : NSObject

@property (nonatomic, copy) NSString *docId;
@property (nonatomic, copy) NSString *sampleDocId;
@property (nonatomic, copy) NSString *sampleDocKey;
@property (nonatomic, copy) NSString *position;
@property (nonatomic, strong) UIImage *showImage;


@end

NS_ASSUME_NONNULL_END
