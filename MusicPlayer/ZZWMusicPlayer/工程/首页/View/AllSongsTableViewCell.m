//
//  AllSongsTableViewCell.m
//  ZZWMusicPlayer
//
//  Created by zzw on 16/6/2.
//  Copyright © 2016年 zzw. All rights reserved.
//

#import "AllSongsTableViewCell.h"

@implementation AllSongsTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];

    //取消选中
    self.selectionStyle = UITableViewCellSelectionStyleNone;


}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
