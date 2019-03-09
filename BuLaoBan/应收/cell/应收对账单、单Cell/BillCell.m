//
//  BillCell.m
//  BuLaoBan
//
//  Created by souxiuyun on 2019/3/9.
//  Copyright © 2019 XX. All rights reserved.
//

#import "BillCell.h"
#import "ReceivableItems.h"
@implementation BillCell

- (void)awakeFromNib {
    [super awakeFromNib];
}


-(void)setItems:(ReceivableItems *)Items{
    _Items = Items;
    switch ([Items.type intValue]) {
        case 0:{
            _billNameLab.text = @"应收初始单";
            break;
        }
        case 1:{
            _billNameLab.text = @"销货单";

            break;
        }
        case 2:{
            _billNameLab.text = @"退货单";

            break;
        }
        case 3:{
            _billNameLab.text = @"期初应收余额";

            break;
        }
        case 4:{
               _billNameLab.text = @"收款单";
            break;
        }
        default:
            break;
    }
    _dateLab.text = Items.orderDate;
    _billNumLab.text = Items.orderNo;
    if ([Items.receivableAmount floatValue]==0) {
        _shouldAccLab.text = @"";
    }else{
        _shouldAccLab.text = [NSString stringWithFormat:@"¥ %@",Items.receivableAmount];
    }
    if ([Items.receiptAmount floatValue]==0) {
        _haveAccLab.text = @"";
    }else{
        _haveAccLab.text = [NSString stringWithFormat:@"¥ %@",Items.receiptAmount];
    }
    _BalanceLab.text = [NSString stringWithFormat:@"¥ %.1f",[ Items.receivableAmount floatValue]-[Items.receiptAmount floatValue]];
}




@end
