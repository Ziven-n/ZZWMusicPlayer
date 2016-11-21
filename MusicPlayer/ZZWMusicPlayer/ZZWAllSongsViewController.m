//
//  ZZWAllSongsViewController.m
//  ZZWMusicPlayer
//
//  Created by zzw on 16/6/2.
//  Copyright © 2016年 zzw. All rights reserved.
//

#import "ZZWAllSongsViewController.h"

#import "AllSongsTableViewCell.h"
#import "OptionsTableViewCell.h"
#import "MyRadioTableViewCell.h"


#import "ZZWSearchController.h"


@interface ZZWAllSongsViewController ()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate>


@end

@implementation ZZWAllSongsViewController {
    UISearchBar *_searchBar;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    //创建单元格
    [self creatTableView];
}

- (void)creatTableView {
    
    UITableView *tabView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ZScreenWidth, ZScreenHeight) style:UITableViewStyleGrouped];
    tabView.backgroundColor = RGB(244, 244, 244);
    
    //UISearchBar参考 -->   http://www.jianshu.com/p/66b5b777f5dc
    //               -->   http://my.oschina.net/u/2340880/blog/509756
    
    _searchBar=[[UISearchBar alloc]init];
    [_searchBar sizeToFit];//大小自适应
    _searchBar.backgroundImage = [[UIImage alloc] init];   //边框外部颜色
    _searchBar.tintColor = [UIColor grayColor];             //光标颜色
//    searchBar.backgroundColor = RGB(244, 244, 244);      //背景色
    _searchBar.placeholder=@"搜索";
//    searchBar.searchBarStyle = UISearchBarStyleDefault;
    _searchBar.autocapitalizationType=UITextAutocapitalizationTypeNone;
    _searchBar.showsCancelButton=NO;//不显示取消按钮
    //添加搜索框到页眉位置
    _searchBar.delegate=self;
    tabView.tableHeaderView = _searchBar;
    
    tabView.delegate = self;
    tabView.dataSource = self;
    
    [self.view addSubview:tabView];
}

#pragma mark － UITableViewDelegate 

//组
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 3;
}
//每组行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 1;
}


//创建单元格
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        
        UINib *nib = [UINib nibWithNibName:@"AllSongsTableViewCell" bundle:nil];
        [tableView registerNib:nib forCellReuseIdentifier:@"AllSongsTableViewCell"];
        
        AllSongsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AllSongsTableViewCell" forIndexPath:indexPath];
        
        return cell;
        
    }else if (indexPath.section == 1) {
        
        UINib *nib = [UINib nibWithNibName:@"OptionsTableViewCell" bundle:nil];
        [tableView registerNib:nib forCellReuseIdentifier:@"OptionsTableViewCell"];

        OptionsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OptionsTableViewCell" forIndexPath:indexPath];
        
        return cell;
        
    }else if (indexPath.section == 2) {
        UINib *nib = [UINib nibWithNibName:@"MyRadioTableViewCell" bundle:nil];
        [tableView registerNib:nib forCellReuseIdentifier:@"MyRadioTableViewCell"];
        
        MyRadioTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyRadioTableViewCell" forIndexPath:indexPath];
        
        return cell;
    }
    return nil;
}
//高度设置
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    switch (indexPath.section) {
        case 0:
            return 60;
            break;
        case 1:
            return ZScreenWidth/3*2;
            break;
        case 2:
            return 60;
            break;
        default:
            break;
    }
    
    return 0;
}
//选中
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ZLog(@"选中%ld",(long)indexPath.section);
}

//组的头视图的高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    //将组间距离缩到最小（写0会拉长距离，不知道为啥）
    return 0.1f;
}
#pragma mark --UISearchBarDelegate--
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar {
    
    //模态弹出另一个控制器
    ZZWSearchController *searchVC = [[ZZWSearchController alloc] init];
    
    //设置模态动画
    searchVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    
    [self presentViewController:searchVC animated:YES completion:nil];
    
    //禁止输入
    return NO;
}


@end
