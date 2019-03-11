//
//  StastisticCell.m
//  BuLaoBan
//
//  Created by souxiuyun on 2019/3/11.
//  Copyright © 2019 XX. All rights reserved.
//

#import "StastisticCell.h"
#import "StasticeItem.h"
@implementation StastisticCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

-(void)setItem:(StasticeItem *)Item{
    _Item = Item;
    _nameLab.text = Item.customerName;
    _recevaBefoLab.text =[NSString stringWithFormat:@"¥ %@",Item.receivableAmountBefore];
    _recevaCurrLab.text =[NSString stringWithFormat:@"¥ %@",Item.receivableAmountCurrent];
    _receiptCurrLab.text =[NSString stringWithFormat:@"¥ %@",Item.receiptAmountCurrent];
    _balanceLab.text =[NSString stringWithFormat:@"¥ %.1f",[Item.receivableAmountCurrent floatValue]-[Item.receiptAmountCurrent floatValue]];
}



@end
