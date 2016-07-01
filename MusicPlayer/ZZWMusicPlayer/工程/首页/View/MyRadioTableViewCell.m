//
//  MyRadioTableViewCell.m
//  ZZWMusicPlayer
//
//  Created by zzw on 16/6/8.
//  Copyright © 2016年 zzw. All rights reserved.
//

#import "MyRadioTableViewCell.h"

#import "ZWRollingView.h"

@interface MyRadioTableViewCell ()

@property (nonatomic,retain) ZWRollingView *rollView;

@end


@implementation MyRadioTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    //取消选中
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    ZLog(@"%f",self.frame.size.height);
    
    UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(ZScreenWidth/4, 5, ZScreenWidth-ZScreenWidth/4, 20)];
    lable.text = @"个性电台";
    lable.textAlignment = NSTextAlignmentLeft;
    [self addSubview:lable];
    
    if (!_rollView) {
        _rollView = [[ZWRollingView alloc] initWithFrame:CGRectMake(ZScreenWidth/4, 35, ZScreenWidth-ZScreenWidth/4, 20)];
        _rollView.inputText = @"这里是一个跑马灯的效果,真的只是一个效果。。。";
        [self addSubview:_rollView];
    }
    
    
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake((ZScreenWidth/4-40)/2, 10, 40, 40)];
    [imgView setImage:[UIImage imageNamed:@"hp_player_btn_play_highlight"]];
    [self addSubview:imgView];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}




@end


