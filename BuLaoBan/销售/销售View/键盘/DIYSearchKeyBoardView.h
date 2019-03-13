//
//  DIYSearchKeyBoardView.h
//  BuLaoBan
//
//  Created by apple on 2019/2/19.
//  Copyright © 2019年 XX. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^DIYSearchKeyBoardViewReturnBlock)(NSString *searchTxt);
@interface DIYSearchKeyBoardView : UIView
@property (nonatomic, copy) DIYSearchKeyBoardViewReturnBlock returnBlock;   

@end

NS_ASSUME_NONNULL_END
