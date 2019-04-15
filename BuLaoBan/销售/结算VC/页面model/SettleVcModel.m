//
//  SettleVcModel.m
//  BuLaoBan
//
//  Created by souxiuyun on 2019/3/16.
//  Copyright © 2019 XX. All rights reserved.
//

#import "SettleVcModel.h"

@implementation SettleVcModel

-(instancetype)init{
    self = [super init];
    if (self) {
        if (!_packListArr) {
            _packListArr = [NSMutableArray arrayWithCapacity:0];
        }
    }
    return self;
}

@end
