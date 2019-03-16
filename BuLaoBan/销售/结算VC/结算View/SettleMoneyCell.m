//
//  SettleMoneyCell.m
//  BuLaoBan
//
//  Created by souxiuyun on 2019/3/16.
//  Copyright © 2019 XX. All rights reserved.
//

#import "SettleMoneyCell.h"

@implementation SettleMoneyCell{
    UITextField *_inputTxt;
    
    
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style  reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setUp];
    }
    return self;
}

- (void)setUp{
    
    
    
}




@end
