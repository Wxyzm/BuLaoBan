//
//  ReceiveCell.m
//  BuLaoBan
//
//  Created by apple on 2019/2/27.
//  Copyright © 2019年 XX. All rights reserved.
//

#import "ReceiveCell.h"
#import "GoodsIteams.h"
@implementation ReceiveCell{
    NSMutableArray *_textArr;
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
    _textArr = [NSMutableArray arrayWithCapacity:0];
    
    NSArray *titleArr = @[@"销售退货单",@"2019-01-20",@"XXXX",@"XXXX",@"红色",@"6",@"匹数",@"100.00",@"米",@"¥ 10.00",@"¥ 1000.00",@"¥ 2000.00",@"¥ 5000.00"];

    NSArray *WidthArr = @[@"100",@"90",@"120",@"90",@"80",@"70",@"70",@"80",@"50",@"70",@"100",@"100",@"100"];
    CGFloat _originX = 0;
    for (int i = 0; i<titleArr.count; i++) {
        float Width = [WidthArr[i] floatValue];
        UIView *view;
        if (i>8) {
            view  = [self viewWithtitle:titleArr[i] andFrame:CGRectMake(_originX, 0, Width, 40) andIscenter:YES];
        }else{
            view = [self viewWithtitle:titleArr[i] andFrame:CGRectMake(_originX, 0, Width, 40) andIscenter:NO];
        }
        [self.contentView addSubview:view];
        
        _originX += Width;
        
    }
    UIView *line = [BaseViewFactory viewWithFrame:CGRectMake(0, 39, 1220, 1) color:UIColorFromRGB(LineColorValue)];
    [self.contentView addSubview:line];

}

- (UIView *)viewWithtitle:(NSString *)title andFrame:(CGRect)viewFrame andIscenter:(BOOL)isright
{
    UIView *view = [BaseViewFactory viewWithFrame:viewFrame color:UIColorFromRGB(WhiteColorValue)];
    UILabel *lab = [BaseViewFactory labelWithFrame:CGRectZero textColor:UIColorFromRGB(BlackColorValue) font:APPFONT12 textAligment:NSTextAlignmentLeft andtext:title];
    [view addSubview:lab];
    lab.frame = CGRectMake(10, 0, viewFrame.size.width-10, 40);
    if (isright) {
        lab.textAlignment = NSTextAlignmentRight;
        lab.frame = CGRectMake(0, 0, viewFrame.size.width-10, 40);
        
    }
    UIView *line = [BaseViewFactory viewWithFrame:CGRectMake(viewFrame.size.width-1, 0, 1, 40) color:UIColorFromRGB(LineColorValue)];
    [view addSubview:line];
    [_textArr addObject:lab];
    return view;
}

-(void)setItems:(GoodsIteams *)Items{
    _Items = Items;
    NSString *title = @"";
    switch ([Items.type intValue]) {
        case 0:{
            title = @"应收初始单";
            break;
        }
        case 1:{
             title = @"销货单";
            break;
        }
        case 2:{
            title = @"退货单 ";

            break;
        }
        case 3:{
            title = @"期初应收余额";

            break;
        }
        case 4:{
            title = @"收款单";

            break;
        }
        default:
            break;
    }
    NSString *orderDate;
    if ([Items.orderDate isEqualToString:@"1970-01-01"]) {
        orderDate = @"";
    }else{
       orderDate  =Items.orderDate.length>0?Items.orderDate:@"";
    }
    NSString *orderNo =Items.orderNo.length>0?Items.orderNo:@"";
    NSString *itemNo =Items.itemNo.length>0?Items.itemNo:@"";
    NSString *name =Items.name.length>0?Items.name:@"";
    NSString *color =Items.color.length>0?Items.color:@"";
    NSString *pishu =@"";//返回数据w没有
    NSString *num =Items.num.length>0?Items.num:@"";
    NSString *numUnit =Items.numUnit.length>0?Items.numUnit:@"";
    NSString *unitPrice =[NSString stringWithFormat:@"¥ %@",Items.unitPrice.length>0?Items.unitPrice:@""];
    NSString *receivableAmount =[NSString stringWithFormat:@"¥ %@",Items.receivableAmount.length>0?Items.receivableAmount:@""];
    NSString *receiptAmount =[NSString stringWithFormat:@"¥ %@",Items.receiptAmount.length>0?Items.receiptAmount:@""];
    NSString *balence =[NSString stringWithFormat:@"¥ %.1f",[Items.receivableAmount floatValue]-[Items .receiptAmount floatValue]];

    
    
    NSArray *titleArr = @[title,orderDate,orderNo,itemNo,name,color,pishu,num,numUnit,unitPrice,receivableAmount,receiptAmount,balence];
    for (int i = 0; i<_textArr.count; i++) {
        UILabel *lab = _textArr[i];
        if (i>8) {
            lab.textColor = UIColorFromRGB(RedColorValue);
        }
        if (i<titleArr.count) {
            lab.text = titleArr[i];
        }
    }
    
    
    
}



@end
