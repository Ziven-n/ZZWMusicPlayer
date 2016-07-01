//
//  SeekResultCell.m
//  ZZWMusicPlayer
//
//  Created by zzw on 16/6/15.
//  Copyright © 2016年 zzw. All rights reserved.
//

#import "SeekResultCell.h"

@interface SeekResultCell ()
@property (weak, nonatomic) IBOutlet UILabel *songName;         //歌曲名
@property (weak, nonatomic) IBOutlet UILabel *singerName;       //歌手名
@property (weak, nonatomic) IBOutlet UILabel *albumName;        //专辑名

@end

@implementation SeekResultCell

- (void)awakeFromNib {
    [super awakeFromNib];
    //取消选中
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    //这里创建是为了避免设置的线在重用单元格时颜色加深
    UILabel *lineLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, ZScreenWidth, 0.5)];
    lineLable.backgroundColor = RGBA(0, 0, 0, 0.1);
    [self addSubview:lineLable];
    
    
    _songName.sd_layout.leftSpaceToView(self.contentView,10).topSpaceToView(self.contentView,10).autoHeightRatio(0).widthIs(ZScreenWidth-10-30);

    _singerName.sd_layout.leftSpaceToView(self.contentView,10).topSpaceToView(_songName,5).heightIs(20).rightSpaceToView(self.contentView,10);
    
    _albumName.sd_layout.leftSpaceToView(self.contentView,10).topSpaceToView(_singerName,5).heightIs(20).rightSpaceToView(self.contentView,10);
    
    [self setupAutoHeightWithBottomView:_albumName bottomMargin:10];
    
}

- (void)setSearchModel:(ZZWSearchModel *)searchModel {
    
    _searchModel = searchModel;
    self.songName.text = searchModel.filename;
    self.singerName.text = searchModel.singername;
    self.albumName.text = [NSString stringWithFormat:@"专辑:%@",[searchModel.album_name isEqualToString:@""]?@",,Ծ‸Ծ,,":searchModel.album_name];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
