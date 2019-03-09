//
//  ReceiveTopCell.m
//  BuLaoBan
//
//  Created by apple on 2019/2/27.
//  Copyright © 2019年 XX. All rights reserved.
//

#import "ReceiveTopCell.h"

@implementation ReceiveTopCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.backgroundColor = UIColorFromRGB(BlueColorValue);
        [self setUP];
    }
    return self;
}

- (void)setUP{
    NSArray *downtitleArr = @[@"单据类别",@"单据日期",@"单据号码",@"编号",@"品名",@"颜色",@"匹数",@"数量",@"单位",@"单价",@"应收金额",@"已收金额",@"应收余额"];
    NSArray *WidthArr = @[@"100",@"90",@"120",@"90",@"80",@"70",@"70",@"80",@"50",@"70",@"100",@"100",@"100"];
    CGFloat _originX = 0;
    for (int i = 0; i<downtitleArr.count; i++) {
        float Width = [WidthArr[i] floatValue];
        UIView *view;
        if (i==10||i==11||i==12) {
            view  = [self viewWithtitle:downtitleArr[i] andFrame:CGRectMake(_originX, 0, Width, 40) andIscenter:YES];
        }else{
            view = [self viewWithtitle:downtitleArr[i] andFrame:CGRectMake(_originX, 0, Width, 40) andIscenter:NO];
        }
        [self addSubview:view];
        
        _originX += Width;
        
    }

}


- (UIView *)viewWithtitle:(NSString *)title andFrame:(CGRect)viewFrame andIscenter:(BOOL)iscenter
{
    UIView *view = [BaseViewFactory viewWithFrame:viewFrame color:UIColorFromRGB(BlueColorValue)];
    UILabel *lab = [BaseViewFactory labelWithFrame:CGRectZero textColor:UIColorFromRGB(WhiteColorValue) font:APPFONT12 textAligment:NSTextAlignmentLeft andtext:title];
    [view addSubview:lab];
    lab.frame = CGRectMake(10, 0, viewFrame.size.width-10, 40);
    if (iscenter) {
        lab.textAlignment = NSTextAlignmentCenter;
        lab.frame = CGRectMake(0, 0, viewFrame.size.width, 40);
        
    }
    UIView *line = [BaseViewFactory viewWithFrame:CGRectMake(viewFrame.size.width-1, 0, 1, 40) color:UIColorFromRGB(LineColorValue)];
    [view addSubview:line];
    
    return view;
}



@end
