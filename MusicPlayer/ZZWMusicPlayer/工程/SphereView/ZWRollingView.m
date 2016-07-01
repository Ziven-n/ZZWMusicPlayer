//
//  ZWRollingView.m
//  ZZWMusicPlayer
//
//  Created by zzw on 16/6/20.
//  Copyright © 2016年 zzw. All rights reserved.
//

#import "ZWRollingView.h"

@interface ZWRollingView ()

@property (nonatomic,retain) UILabel *textLable;
@property (nonatomic,retain) NSTimer *mytimer;

@end

@implementation ZWRollingView

//重写set方法
- (void)setInputText:(NSString *)inputText {
    
    if (!_textColor) {
        
        //计算文字长和宽
        CGSize size = [inputText sizeWithAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:15]}];
        _textLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
        _textLable.font = [UIFont systemFontOfSize:15];
        _textLable.text = inputText;
        [self addSubview:_textLable];
        //超出部分裁剪
        self.clipsToBounds = YES;
        
        //添加动画
        if (!_mytimer) {
            
            _mytimer = [NSTimer scheduledTimerWithTimeInterval:.1  target:self selector:@selector(_addAnimate) userInfo:nil repeats:YES];
        }
        
        
    }
    
}

- (void)setTextColor:(UIColor *)textColor {
    
    _textLable.textColor = textColor;
}

//动画效果
- (void)_addAnimate {
    
    
    
    [UIView animateWithDuration:.1 delay:0 options:UIViewAnimationOptionCurveLinear  animations:^{
        
        _textLable.frame = CGRectMake(_textLable.frame.origin.x - 8, _textLable.frame.origin.y, _textLable.frame.size.width,  _textLable.frame.size.height);
        
    } completion:^(BOOL finished) {
        
        if (_textLable.frame.origin.x + _textLable.frame.size.width < 0) {
            _textLable.frame = CGRectMake(self.frame.size.width, 0, _textLable.frame.size.width, _textLable.frame.size.height);
        }
        
    }];
}

@end