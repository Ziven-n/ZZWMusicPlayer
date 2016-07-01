//
//  ZWRollingView.h
//  ZZWMusicPlayer
//
//  Created by zzw on 16/6/20.
//  Copyright © 2016年 zzw. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZWRollingView : UIView

/**
 *  使用时直接initwithframe，设置文字即可
 *  注：
 *      1.frame要设置恰当（特别是高度，self的frame宽高就是滚动条的frame宽高）
 *      2.要设置文字
 */

@property (nonatomic,copy) NSString *inputText;                 //设置滚动文字

@property (nonatomic,strong) UIColor *textColor;                //设置文字颜色(非必需)

@end
