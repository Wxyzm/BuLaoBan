//
//  SaleListTopView.m
//  BuLaoBan
//
//  Created by apple on 2019/2/20.
//  Copyright © 2019年 XX. All rights reserved.
//

#import "SaleListTopView.h"

@implementation SaleListTopView

-(instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = UIColorFromRGB(BlueColorValue);
        [self setUP];
    }
    return self;
}


- (void)setUP{
    NSArray *titlearr = @[@"图片",@"编号/品名",@"颜色",@"单价",@"细码单",@"匹数",@"销货量",@"金额",@"操作"];
    for (int i = 0; i<titlearr.count; i++) {
        UILabel *lab = [BaseViewFactory labelWithFrame:CGRectZero textColor:UIColorFromRGB(WhiteColorValue) font:APPFONT12 textAligment:NSTextAlignmentLeft andtext:titlearr[i]];
        [self addSubview:lab];
        UIView *line = [BaseViewFactory viewWithFrame:CGRectZero color:UIColorFromRGB(LineColorValue)];
        [self addSubview:line];
        switch (i) {
            case 0:{
                lab.frame = CGRectMake(10, 0, 26, 40);
                line.frame = CGRectMake(49.5, 0, 1, 40);
                break;
            }
            case 1:{
                lab.frame = CGRectMake(58, 0, 80, 40);
                line.frame = CGRectMake(169.5, 0, 1, 40);
                break;
            }
            case 2:{
                lab.frame = CGRectMake(177, 0, 26, 40);
                line.frame = CGRectMake(239.5, 0, 1, 40);
                break;
            }
            case 3:{
                lab.frame = CGRectMake(246, 0, 26, 40);
                line.frame = CGRectMake(309.5, 0, 1, 40);
                break;
            }
            case 4:{
                lab.frame = CGRectMake(317, 0, 40, 40);
                line.frame = CGRectMake(359.5, 0, 1, 40);
                break;
            }
            case 5:{
                lab.frame = CGRectMake(370, 0, 26, 40);
                line.frame = CGRectMake(419.5, 0, 1, 40);
                break;
            }
            case 6:{
                lab.frame = CGRectMake(430, 0, 40, 40);
                line.frame = CGRectMake(519.5, 0, 1, 40);
                break;
            }
            case 7:{
                lab.frame = CGRectMake(530, 0, 26, 40);
                line.frame = CGRectMake(569.5, 0, 1, 40);
                break;
            }
//            case 8:{
//                lab.frame = CGRectMake(580, 0, 40, 40);
//                line.frame = CGRectMake(659.5, 0, 1, 40);
//                break;
//            }
            case 8:{
                lab.frame = CGRectMake(670, 0, 40, 40);
                line.hidden = YES;
                break;
            }
            default:
                break;
        }
        
        
    }
    
    
    
}


@end
