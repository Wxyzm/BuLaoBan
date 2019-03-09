//
//  StastisticTopCell.m
//  BuLaoBan
//
//  Created by souxiuyun on 2019/3/9.
//  Copyright © 2019 XX. All rights reserved.
//

#import "StastisticTopCell.h"

@implementation StastisticTopCell{
    
    
    
    
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.backgroundColor = UIColorFromRGB(BlueColorValue);
        [self setUP];
    }
    return self;
}

- (void)setUP
{
    NSArray *titleArr = @[@"客户",@"期初应收",@"应收金额",@"已收金额",@"已收金额",@"应收余额"];
    for (int i = 0; i; <#increment#>) {
        <#statements#>
    }
    
    
    
    
}


- (UIView*)viewWithFrame:(CGRect)frame andTitle:(NSString *)title andisMoney:(BOOL)isMoney {
    UIView *view =[BaseViewFactory viewWithFrame:frame color:UIColorFromRGB(BlueColorValue)];
    UIView *line = [BaseViewFactory viewWithFrame:CGRectMake(frame.size.width-1, 0, 1, frame.size.height) color:UIColorFromRGB(LineColorValue)];
    [view addSubview:line];
    UILabel *lab = [BaseViewFactory labelWithFrame:CGRectZero textColor:UIColorFromRGB(WhiteColorValue) font:APPFONT12 textAligment:NSTextAlignmentLeft andtext:title];
    [view addSubview:lab];
    if (isMoney) {
        lab.frame = CGRectMake(20, 0, frame.size.width-21, frame.size.height);
    }else{
        lab.frame = CGRectMake(10, 0, frame.size.width-11, frame.size.height);

    }
    
    return view;
}



@end
