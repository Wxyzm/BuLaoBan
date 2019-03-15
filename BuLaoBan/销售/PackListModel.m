//
//  PackListModel.m
//  BuLaoBan
//
//  Created by souxiuyun on 2019/3/14.
//  Copyright © 2019 XX. All rights reserved.
//

#import "PackListModel.h"

@implementation PackListModel

-(instancetype)init{
    self = [super init];
    if (self ) {
        if (!_dyelot) {
            _dyelot = @"";
        }
        if (!_reel) {
            _reel = @"";
        }
        if (!_meet) {
            _meet = @"";
        }
        if (!_keyboardshodReturn) {
            _keyboardshodReturn = 2;
        }
    }
    return self;
}

@end
