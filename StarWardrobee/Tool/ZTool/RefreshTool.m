//
//  RefreshTool.m
//  StarWardrobee
//
//  Created by Mac on 16/7/5.
//  Copyright © 2016年 Happy. All rights reserved.
//

#import "RefreshTool.h"
#import "MJRefreshNormalHeader.h"

@implementation RefreshTool
+ (void)refreshWithImages:(NSArray *)images andViewController:(UIViewController *)vc andTableView:(UITableView *)scroll {
    MJRefreshGifHeader *header =[MJRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    
    [header setImages:images forState:MJRefreshStateRefreshing];
    //隐藏最后刷新时间
    header.lastUpdatedTimeLabel.hidden = YES;
    header.stateLabel.hidden =YES;
    //自定义文字
    [header setTitle:@"奋力加载中" forState:MJRefreshStateRefreshing];
    scroll.mj_header = header;
    [scroll.mj_header beginRefreshing];
}

- (void)loadNewData {


}
@end
