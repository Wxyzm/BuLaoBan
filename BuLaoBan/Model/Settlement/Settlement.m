//
//  Settlement.m
//  BuLaoBan
//
//  Created by apple on 2019/2/25.
//  Copyright © 2019年 XX. All rights reserved.
//

#import "Settlement.h"

@implementation Settlement

-(instancetype)init{
    self = [super init];
    if (self) {
        if (!_unit) {
            _unit = @"";
        }
        if (!_showValue) {
            _showValue = @"";
        }
        if (!_title) {
            _title = @"";
        }
    }
    return self;
}


@end
