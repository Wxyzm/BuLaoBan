//
//  SaleSamModel.m
//  BuLaoBan
//
//  Created by souxiuyun on 2019/3/13.
//  Copyright © 2019 XX. All rights reserved.
//

#import "SaleSamModel.h"

@implementation SaleSamModel
-(instancetype)init{
    self = [super init];
    if (self) {
        if (!_packingList) {
            _packingList = [NSMutableArray arrayWithCapacity:0];
        }
        
    }
    return self;
}
@end
