//
//  InviteController.m
//  BuLaoBan
//
//  Created by souxiuyun on 2019/4/26.
//  Copyright © 2019 XX. All rights reserved.
//

#import "InviteController.h"
#import "AccInvView.h"

@interface InviteController ()

@property (nonatomic,strong) AccInvView *accView;

@property (nonatomic,strong) UILabel *showLab;

@end

@implementation InviteController{
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"接受邀请";
    [self setBarBackBtnWithImage:nil];
    [self.view addSubview:self.accView];
    [self loadInviteList];
}

- (void)loadInviteList{
    [[HttpClient sharedHttpClient] requestGET:@"/companys" Withdict:nil WithReturnBlock:^(id returnValue) {
        NSLog(@"%@",returnValue);
        NSArray *arr= returnValue[@"inviteCompanys"];
        if (arr.count>0) {
            self.showLab.hidden = YES;
            NSDictionary *dic = arr[0];
            self.accView.infoDic = dic;
            
            [self.accView showView:self.view];
        }else{
            self.showLab.hidden = NO;
        }
    } andErrorBlock:^(NSString *msg) {
        self.showLab.hidden = NO;

    }];
}

-(AccInvView *)accView{
    if (!_accView) {
        _accView = [[AccInvView alloc]init];
    }
    return _accView;
}

-(UILabel *)showLab{
    if (!_showLab) {
        _showLab = [BaseViewFactory labelWithFrame:CGRectMake(0, 260, ScreenWidth, 16) textColor:UIColorFromRGB(0x858585) font:APPFONT16 textAligment:NSTextAlignmentCenter andtext:@"请联系公司负责人邀请你加入公司"];
        [self.view addSubview:_showLab];
        _showLab.hidden = YES;
    }
    return _showLab;
}


@end
