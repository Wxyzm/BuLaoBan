//
//  CustomerCell.m
//  BuLaoBan
//
//  Created by apple on 2019/2/11.
//  Copyright © 2019年 XX. All rights reserved.
//

#import "CustomerCell.h"
#import "ComCustomer.h"

@implementation CustomerCell{
    UILabel *_nameLab;
    UILabel *_moneyLab;

}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.backgroundColor = UIColorFromRGB(WhiteColorValue);
        [self setUP];
    }
    return self;
}

- (void)setUP{
    
    _nameLab = [BaseViewFactory labelWithFrame:CGRectMake(12, 10, 256, 18) textColor:UIColorFromRGB(BlackColorValue) font:APPFONT14 textAligment:NSTextAlignmentLeft andtext:@""];
    [self.contentView addSubview:_nameLab];
    
    _moneyLab = [BaseViewFactory labelWithFrame:CGRectMake(12, 34, 226, 16) textColor:UIColorFromRGB(0x858585) font:APPFONT13 textAligment:NSTextAlignmentLeft andtext:@"业务员"];
    [self.contentView addSubview:_moneyLab];
    
    
    UIView *line = [BaseViewFactory viewWithFrame:CGRectMake(10, 0, 290, 1) color:UIColorFromRGB(LineColorValue)];
    [self.contentView addSubview:line];
}

-(void)setCustomer:(ComCustomer *)customer{
    _nameLab.text = customer.name;
    _moneyLab.text = [NSString stringWithFormat:@"业务员：%@",customer.salesmanName];
    if (customer.isSelected) {
        self.contentView.backgroundColor = UIColorFromRGB(0xeff6f9);
    }else{
        self.contentView.backgroundColor = UIColorFromRGB(WhiteColorValue);
        
    }
}


@end
