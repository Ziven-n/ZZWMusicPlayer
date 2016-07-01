//
//  ZZWSearchController.m
//  ZZWMusicPlayer
//
//  Created by zzw on 16/6/12.
//  Copyright © 2016年 zzw. All rights reserved.
//

#import "ZZWSearchController.h"

#import "ZZWSearchModel.h"
#import "XLSphereView.h"

#import "SeekResultCell.h"

@interface ZZWSearchController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UISearchBar *MySearchBar;
@property (nonatomic,retain) UITableView *songsTabView;

@property (nonatomic,strong) XLSphereView *sphereView;          //3D视图
@property (nonatomic,retain) NSMutableArray *itemArray;         //3D标签的文字数据源
@property (nonatomic,retain) NSMutableArray *randomArray;       //3D标签的文字数据源

@property (nonatomic,retain) NSArray *data;                     //网络请求初步解析之后返回的大数组
@property (nonatomic,retain) NSMutableArray *persondata;        //json转成model后，model的存放地

@property (nonatomic,retain) SeekResultCell *cell;
@property (nonatomic,assign) NSInteger loadtime;                //上拉次数统计
@end

@implementation ZZWSearchController

- (void)viewDidLoad {
    [super viewDidLoad];

    //创建3D球状标签
    [self _creat3DballView];
    
}

- (void)_creat3DballView {
    
    //设置搜索栏第一响应者
    [_MySearchBar becomeFirstResponder];

    _sphereView = [[XLSphereView alloc] initWithFrame:CGRectMake(ZScreenWidth/4, 70, ZScreenWidth/2, ZScreenWidth/2)];
    NSMutableArray *array = [[NSMutableArray alloc] initWithCapacity:0];
    
    //数据源（等接口）
    NSArray *mainArray = @[@"晴天",@"周杰伦",@"许嵩",@"纯音乐",@"掏粪boy",@"那英",@"张杰",@"世界上最难唱的歌",@"白天不懂夜的黑",@"口琴版",@"有一天",@"该死的温柔",@"你是不是傻",@"未闻花名",@" Lilac ",@"是我不够好",@"试试",@"陈奕迅",@"张碧晨",@"当爱已成往事",@"林志炫",@"错的人",@"床边故事",@"刘涛",@"不该 周杰伦",@" I will ",@"太阳的后裔",@"荣祖儿",@"如果没有明天",@"明天你好",@"牛奶咖啡",@"夏洛特烦恼",@" Blacklight ",@" Hope ",@"一条林荫道",@"夜里的向日葵",@"那英",@"更多...",@" unravel ",@"花之色",@" Winter Sky ",@" NEXT TO YOU ",@" V.K克",@"爱无限",@" Somewhere ",@"阴天",@"看月亮爬上来",@"今天你要嫁给我",@"短发",@"演员",@"薛之谦",@"多幸运",@"我不再相信",@"超越无限",@"温暖你的冬",@"笑忘书",@"年轮",@"不将就"];

    //可变数组要先初始化才能使用
    _randomArray = @[].mutableCopy;
    _itemArray  = @[].mutableCopy;
    [_randomArray addObjectsFromArray:mainArray];
    for (int i= 0; i<10; i++) {
        
        NSInteger index = arc4random() % [_randomArray count];
        [_itemArray addObject:_randomArray[index]];
        [_randomArray removeObjectAtIndex:index];
        
    }
    
    //设置button
    for (NSInteger i = 0; i < _itemArray.count; i ++) {
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
        [btn setTitle:[NSString stringWithFormat:@"%@", _itemArray[i]] forState:UIControlStateNormal];
        btn.tag = i;
        btn.backgroundColor = [UIColor colorWithRed:arc4random_uniform(255)/255. green:arc4random_uniform(255)/255. blue:arc4random_uniform(255)/255. alpha:1.];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:20];
        
        //根据字体大小设置button的frame
        CGSize size = [_itemArray[i] sizeWithAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:20]}];
        btn.frame = CGRectMake(0, 0, size.width, 30);
        btn.layer.cornerRadius = 3;
        btn.clipsToBounds = YES;
        [btn addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [array addObject:btn];
        [_sphereView addSubview:btn];
    }
    [_sphereView setItems:array];
    [self.view addSubview:_sphereView];
    
}
//每个转动button的点击事件
- (void)buttonPressed:(UIButton *)btn
{
    [_sphereView timerStop];
    
    [UIView animateWithDuration:0.3 animations:^{
        btn.transform = CGAffineTransformMakeScale(2., 2.);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.3 animations:^{
            btn.transform = CGAffineTransformMakeScale(1., 1.);
        } completion:^(BOOL finished) {
            [_sphereView timerStart];
            
        }];
    }];
    _MySearchBar.text = _itemArray[btn.tag];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -- UISearchBarDelegate --
//搜索按钮点击事件
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {

    [_sphereView removeFromSuperview];
    _sphereView = nil;
    
    //设置请求字典
    NSDictionary *parameters = @{@"s":searchBar.text,
                                 @"size":@30,
                                 @"page":@1
                                 };
    //网络请求
    [ZZWSearchModel getDataWithSearchParameters:parameters Success:^(NSArray *dataArray) {
        
        if (dataArray) {
            
            //每次都清空数据(单元格reloadData会重新生成cell，所以赋值的时候得重新写入数据)
            _persondata = nil;
            _data = dataArray;
            ZLog(@"%ld",_data.count);
            for (NSDictionary *myJson in _data)  {
                
                ZZWSearchModel *model =[ZZWSearchModel mj_objectWithKeyValues:myJson];
                
                if (!_persondata) {
                    
                    _persondata = [NSMutableArray new];
                }
                [_persondata addObject:model];
                
            }
            
            //创建单元格
            self.songsTabView.hidden = NO;
            
            [_songsTabView reloadData];
            
        }else {
            
            [self showHint:@"没有搜索结果哦!" yOffset:-ZScreenHeight/3];
        }
    } Failure:^(NSError *error) {
        
        ZLog(@"%@",error);
    }];
    

    [_MySearchBar resignFirstResponder];
}

//cancel点击事件
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    
    [_MySearchBar resignFirstResponder];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar {
    
    return YES;
}

#pragma mark -- UITableViewDelegate --

//每组行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _persondata.count;
}


//创建单元格（初始化、上下滚动、刷新都会调用此方法）
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [_MySearchBar resignFirstResponder];
    UINib *nib = [UINib nibWithNibName:@"SeekResultCell" bundle:nil];
    [tableView registerNib:nib forCellReuseIdentifier:@"SeekResultCell"];
    
    _cell = [tableView dequeueReusableCellWithIdentifier:@"SeekResultCell" forIndexPath:indexPath];
    
    //给cell里的model设置数据
    _cell.searchModel = _persondata[indexPath.row];
    
    return _cell;
   
}
//高度设置
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
//    id model = _persondata[indexPath.row];
    
    return [_songsTabView cellHeightForIndexPath:indexPath model:_persondata[indexPath.row] keyPath:@"searchModel" cellClass:[SeekResultCell class] contentViewWidth:ZScreenWidth];
}
//选中
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
//    ZLog(@"选中%ld",(long)indexPath.section);
}

- (UITableView *)songsTabView {
    
    if (!_songsTabView) {
        
        _songsTabView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, ZScreenWidth, ZScreenHeight-64) style:UITableViewStylePlain];
        _songsTabView.delegate = self;
        _songsTabView.dataSource = self;
        _songsTabView.separatorStyle = UITableViewCellSeparatorStyleNone;   //去掉分割线
        _songsTabView.showsVerticalScrollIndicator = NO;                    //去掉垂直滚动条
        [self.view addSubview:_songsTabView];
        
        //上拉刷新
        MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
        header.stateLabel.textColor = RGB(30, 198, 91);
        header.lastUpdatedTimeLabel.textColor = RGB(30, 198, 91);
        _songsTabView.mj_header = header;
        
        //下拉加载更多
        MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
        footer.stateLabel.textColor = RGB(30, 198, 91);
        _songsTabView.mj_footer = footer;
        
    }
    
    return _songsTabView;
}



#pragma mark -- 上下拉刷新数据 --

//下拉刷新
- (void)loadNewData {
    [_songsTabView.mj_header beginRefreshing];
    [_songsTabView.mj_header performSelector:@selector(endRefreshing) withObject:nil afterDelay:1];
}
//上拉加载
- (void)loadMoreData {
    [_songsTabView.mj_footer beginRefreshing];
    
    if (!_loadtime) {
        
        _loadtime = 1;
    }
    _loadtime ++;
    //设置请求字典
    NSDictionary *parameters = @{@"s":_MySearchBar.text,
                                 @"size":@30,
                                 @"page":@(_loadtime)
                                 };
    //网络请求
    [ZZWSearchModel getDataWithSearchParameters:parameters Success:^(NSArray *dataArray) {
        if (dataArray) {
            
            _data = dataArray;
            for (NSDictionary *myJson in _data)  {
                
                ZZWSearchModel *model =[ZZWSearchModel mj_objectWithKeyValues:myJson];
                
                if (!_persondata) {
                    
                    _persondata = [NSMutableArray new];
                }
                [_persondata addObject:model];
                
            }
            
            [_songsTabView reloadData];
            [_songsTabView.mj_footer endRefreshing];
            
        }else {
            
            [_songsTabView.mj_footer endRefreshingWithNoMoreData];
            ZLog(@"没有数据");
        }
    } Failure:^(NSError *error) {
        
        ZLog(@"%@",error);
    }];
    
}
@end
