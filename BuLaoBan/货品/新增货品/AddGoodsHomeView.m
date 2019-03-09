//
//  AddGoodsHomeView.m
//  BuLaoBan
//
//  Created by apple on 2019/2/11.
//  Copyright © 2019年 XX. All rights reserved.
//

#import "AddGoodsHomeView.h"
#import "AddGoodsView.h"
#import "GoodsCompView.h"   //成分
#import "GoodsWidthView.h"  //门幅
#import "GoodsWeightView.h" //克重

@interface AddGoodsHomeView ()

/**
 新增属性填写
 */
@property (nonatomic, strong) AddGoodsView *addGoodsView;

/**
 成分
 */
@property (nonatomic, strong) GoodsCompView *goodsComView;

/**
 幅宽
 */
@property (nonatomic, strong) GoodsWidthView *goodsWidthView;

/**
 克重
 */
@property (nonatomic, strong) GoodsWeightView *goodsWeightView;

/**
底色按钮
 */
@property (nonatomic, strong) UIButton *backButton;


@end

@implementation AddGoodsHomeView{
    
    BOOL _isShow;
    NSMutableArray *_viewArr;
}

-(instancetype)init{
    if (self = [super init]) {
        self.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
        _viewArr = [NSMutableArray arrayWithCapacity:0];
        self.backgroundColor = [UIColor clearColor];
        _sampleDetail =[[SampleDetail alloc]init];
        UITapGestureRecognizer *tapGr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyBoard)];
        tapGr.cancelsTouchesInView = NO;
        [self addGestureRecognizer:tapGr];
#pragma mark -键盘弹出添加监听事件
//        // 键盘出现的通知
//        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
//        // 键盘消失的通知
//        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillBeHiden:) name:UIKeyboardWillHideNotification object:nil];
        [self setUp];
    }
    return self;
    
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

- (void)setUp{
    [self addSubview:self.backButton];
    [self addSubview:self.addGoodsView];
    [self addSubview:self.goodsComView];
    [self addSubview:self.goodsWidthView];
    [self addSubview:self.goodsWeightView];

    [_viewArr addObject:self.addGoodsView];
    [_viewArr addObject:self.goodsComView];
    [_viewArr addObject:self.goodsWidthView];
    [_viewArr addObject:self.goodsWeightView];

    //选择属性
    WeakSelf(self);
    self.addGoodsView.choseBlock = ^(NSInteger btnTag) {
        [weakself choseKindWithTag:btnTag];
    };
    self.goodsComView.choseBlock = ^(NSString * _Nonnull comp) {
        [weakself chosecomponentWithStr:comp];
    };
   
    self.goodsWidthView.choseBlock = ^(NSString * _Nonnull width) {
        [weakself choseWidthWithStr:width];
    };
    self.goodsWeightView.choseBlock = ^(NSString * _Nonnull weight) {
        [weakself choseWeightWithStr:weight];
    };
    
}

-(void)setSampleDetail:(SampleDetail *)sampleDetail{
    _sampleDetail = sampleDetail;
    self.addGoodsView.sampleModel = sampleDetail;
}


#pragma mark ========= 属性

/**
 按钮点击
 */
- (void)choseKindWithTag:(NSInteger)tag{
    for (UIView *view in _viewArr) {
        view.hidden = YES;
    }
   // self.addGoodsView.hidden = YES;
   //1：成分 2：门幅 3：克重   
    switch (tag) {
        case 0:{
            [self dismiss];
            break;
        }
        case 1:{
            self.goodsComView.hidden = NO;
            break;
        }
        case 2:{
            self.goodsWidthView.hidden = NO;

            break;
        }
        case 3:{
            self.goodsWeightView.hidden = NO;
            break;
        }
        case 5:{
            
            break;
        }
        default:
            break;
    }
}

/**
 成分
 */
- (void)chosecomponentWithStr:(NSString *)comp{
    
    //关闭   保存
    if (comp.length<=0) {
        //关闭 确定
        for (UIView *view in _viewArr) {
            view.hidden = YES;
        }
        self.addGoodsView.hidden = NO;
    }else{
        _sampleDetail.component = comp;
        self.addGoodsView.sampleModel = _sampleDetail;
        
    }
}

/**
 门幅
 */
- (void)choseWidthWithStr:(NSString *)widthStr{
    
    if (widthStr.length<=0) {
        //关闭 确定
        for (UIView *view in _viewArr) {
            view.hidden = YES;
        }
        self.addGoodsView.hidden = NO;
    }else{
        _sampleDetail.width = widthStr;
        self.addGoodsView.sampleModel = _sampleDetail;
        
    }
    
}
/**
 克重
 */
- (void)choseWeightWithStr:(NSString *)weightStr{
    
    if (weightStr.length<=0) {
        //关闭 确定
        for (UIView *view in _viewArr) {
            view.hidden = YES;
        }
        self.addGoodsView.hidden = NO;
    }else{
        _sampleDetail.weight = weightStr;
        self.addGoodsView.sampleModel = _sampleDetail;
        
    }
   
}


#pragma - mark public method
- (void)showView
{
    AppDelegate *app = (AppDelegate *)[[UIApplication  sharedApplication] delegate];
    [app.splitViewController.view addSubview:self];
    self.addGoodsView.hidden = NO;
    self.goodsComView.hidden = YES;
    _isShow = YES;
    [UIView animateWithDuration:0.2 animations:^{
       
    }];
    
    
}

- (void)dismiss
{
    if (!_isShow) return;
    
    _isShow = NO;
    
    
    [UIView animateWithDuration:0.2 animations:^{
      
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        _backButton.alpha = 0.3;
    }];
}

#pragma mark -hideKeyBoard

- (void)hideKeyBoard {
    [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];
}

#pragma mark -键盘监听方法
- (void)keyboardWillShow:(NSNotification *)notification
{
    NSDictionary *userInfo = notification.userInfo;
   // CGRect frame = [userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];//键盘动画结束时的frame
    NSTimeInterval timeInterval = [userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];//动画持续时间
    UIViewAnimationCurve curve = [userInfo[UIKeyboardAnimationCurveUserInfoKey] integerValue];//动画曲线类型
    //your animation code
 //   __weak typeof(self) weakself = self;
    [UIView setAnimationCurve:curve];
    [UIView animateWithDuration:timeInterval animations:^{
        //code
        self.frame = CGRectMake(0, -60, ScreenWidth, ScreenHeight);

    }];

}
- (void)keyboardWillBeHiden:(NSNotification *)notification
{
    NSDictionary *userInfo = notification.userInfo;
  //  CGRect frame = [userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];//键盘动画结束时的frame
    NSTimeInterval timeInterval = [userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];//动画持续时间
    UIViewAnimationCurve curve = [userInfo[UIKeyboardAnimationCurveUserInfoKey] integerValue];//动画曲线类型
    //your animation code
  //  __weak typeof(self) weakself = self;
    [UIView setAnimationCurve:curve];
    [UIView animateWithDuration:timeInterval animations:^{
        //code
        self.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);

    }];
}

#pragma mark ========= get

- (UIButton *)backButton
{
    if (!_backButton) {
        _backButton = [[UIButton alloc] initWithFrame:self.bounds];
        _backButton.backgroundColor = [UIColor blackColor];
        _backButton.alpha = 0.3;
        //        [_backButton addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    }
    return _backButton;
}

-(AddGoodsView *)addGoodsView{
    if (!_addGoodsView) {
        _addGoodsView = [[AddGoodsView alloc]initWithFrame:CGRectMake(ScreenWidth/2-300, 80, 600, 580)];
    }
    return _addGoodsView;
    
}

-(GoodsCompView *)goodsComView{
    if (!_goodsComView) {
        _goodsComView = [[GoodsCompView alloc]initWithFrame:CGRectMake(ScreenWidth/2-300, 80, 600, 324)];
        _goodsComView.hidden = YES;
    }
    return _goodsComView;
    
}

-(GoodsWidthView *)goodsWidthView{
    if (!_goodsWidthView) {
        _goodsWidthView = [[GoodsWidthView alloc]initWithFrame:CGRectMake(ScreenWidth/2-300, 80, 600, 324)];
        _goodsWidthView.hidden = YES;

    }
    return _goodsWidthView;
}

-(GoodsWeightView *)goodsWeightView{
    
    if (!_goodsWeightView) {
        _goodsWeightView= [[GoodsWeightView alloc]initWithFrame:CGRectMake(ScreenWidth/2-300, 80, 600, 530)];
        _goodsWeightView.hidden = YES;
        
    }
    return _goodsWeightView;
    
    
}


@end
