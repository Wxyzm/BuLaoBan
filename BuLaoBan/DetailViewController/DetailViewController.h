//
//  DetailViewController.h
//  BuLaoBan
//
//  Created by apple on 2019/2/22.
//  Copyright © 2019年 XX. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface DetailViewController : BaseViewController<UISplitViewControllerDelegate>

- (void)changeChildViewController:(NSInteger)sign;

@end

NS_ASSUME_NONNULL_END
