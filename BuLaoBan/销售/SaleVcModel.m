//
//  SaleVcModel.m
//  BuLaoBan
//
//  Created by souxiuyun on 2019/3/13.
//  Copyright © 2019 XX. All rights reserved.
//

#import "SaleVcModel.h"

@implementation SaleVcModel

-(instancetype)init{
    self = [super init];
    if (self) {
     
        if (!_sampleList) {
            _sampleList = [NSMutableArray arrayWithCapacity:0];
        }
    }
    return self;
}

@end
