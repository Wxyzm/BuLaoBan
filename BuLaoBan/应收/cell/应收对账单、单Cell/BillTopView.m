//
//  BillTopView.m
//  BuLaoBan
//
//  Created by souxiuyun on 2019/3/9.
//  Copyright © 2019 XX. All rights reserved.
//

#import "BillTopView.h"
@implementation BillTopView

-(instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        [[NSBundle mainBundle] loadNibNamed:@"BillTopView" owner:self options:nil];
        _contentView.frame = self.bounds;
        [self addSubview:_contentView];
    }
    return self;
}


@end
