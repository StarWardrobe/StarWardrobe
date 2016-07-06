//
//  CommunityViewController.m
//  StarWardrobee
//
//  Created by Mac on 16/7/3.
//  Copyright © 2016年 Happy. All rights reserved.
//

#import "CommunityViewController.h"
#import "ZTabBar.h"
#import "ZHTTPManager.h"
#import "ZCompontentModel.h"
#import "ZCommentsModel.h"
#import "ZUserModel.h"
#import "CommuityTableViewCell.h"
#import "RefreshTool.h"
#import "ZZCarouselControl.h"
#define CellID @"cell"

@interface CommunityViewController ()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate,ZZCarouselDataSource,ZZCarouselDelegate>{
    UIScrollView *_bgScrollView;
    CGFloat maxHeght;
    ZTabBar *_tabBar;
    NSInteger selectIndex;
}
@property (strong, nonatomic)NSMutableArray *titlesArr;
@property (strong, nonatomic)NSMutableArray *dataArr;
@property (strong, nonatomic)UITableView *myTableView;
@property (strong, nonatomic)NSMutableArray *picUrlArr;
@end

@implementation CommunityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"社区";
    
    _titlesArr = [NSMutableArray array];
    [self createView];
    [self createTableView];
    [self getData];
    
    
}
- (NSMutableArray *)dataArr {
    if (!_dataArr) {
        _dataArr =[NSMutableArray array];
    }
    return _dataArr;
}
- (void)createView {
    UIScrollView *bgView = [[UIScrollView alloc]initWithFrame:kMainBounds];
    bgView.backgroundColor = [UIColor cyanColor];
    bgView.showsVerticalScrollIndicator =NO;
    bgView.delegate =self;
    bgView.tag = 20;
    [self.view addSubview:bgView];
    _bgScrollView = bgView;
    
    ZZCarouselControl *caruoseControl =[[ZZCarouselControl alloc]initWithFrame:CGRectMake(0, 0, kMainBoundsW, 200)];
    //设置时间
    caruoseControl.carouseScrollTimeInterval = 3.0f;
    caruoseControl.delegate =self;
    caruoseControl.dataSource =self;
    [bgView addSubview:caruoseControl];
    
    [ZHTTPManager getRequestWithUrl:@"http://api-v2.mall.hichao.com/forum/banner?gc=appstore&gf=iphone&gn=mxyc_ip&gv=6.6.3&gi=DA51E858-FC0D-4ACA-94C8-EC43CA9AC969&gs=640x1136&gos=8.4&access_token=6t8NoQYMw_NMtAl6aAtqVFwHEiV1Ve_1ENnI7aOs3KQ" andPragramer:nil withResposeBlock:^(id responseObject, NSError *error) {
        
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSDictionary *dataDic = dic[@"data"];
        NSArray *itemArr = dataDic[@"items"];
        //图片URL
        _picUrlArr = [NSMutableArray array];
        for (NSDictionary *temp in itemArr) {
            NSDictionary *commpontDic =temp[@"component"];
            NSString *picUrl = commpontDic[@"picUrl"];
            [_picUrlArr addObject:picUrl];
        }
        [caruoseControl reloadData];
    }];
    
    //获取tabBar上的文字
    [ZHTTPManager getRequestWithUrl:@"http://api-v2.mall.hichao.com/forum/navigator" andPragramer:@{@"gc":@"appstore",@"gf":@"iphone",@"gn":@"mxyc_ip",@"gv":@"6.6.3",@"gi":@"DA51E858-FC0D-4ACA-94C8-EC43CA9AC969",@"gs":@"640x1136",@"gos":@"8.4",@"access_token":@"6t8NoQYMw_NMtAl6aAtqVFwHEiV1Ve_1ENnI7aOs3KQ"} withResposeBlock:^(id responseObject, NSError *error) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSDictionary *dataDic = dic[@"data"];
        NSArray *itemsArr = dataDic[@"items"];
        __weak typeof(self) weakSelf = self;
        for (NSDictionary *temp in itemsArr) {
            NSString *title = temp[@"nav_name"];
            [weakSelf.titlesArr addObject:title];
        }
        
        ZTabBar *tabBar = [[ZTabBar alloc]initWithFrame:CGRectMake(0, 200, kMainBoundsW, 50) andTitles:_titlesArr withBlock:^(NSInteger index) {
            
            selectIndex = index;
            NSArray *images = @[[UIImage imageNamed:@"mascot_1"],[UIImage imageNamed:@"mascot_2"]];
            [RefreshTool refreshWithImages:images andViewController:self andTableView:_myTableView];
            
            [self getData];
        }];
        tabBar.backgroundColor = [UIColor purpleColor];
        [_bgScrollView addSubview:tabBar];
        _tabBar = tabBar;
        
    }];
    
    maxHeght = 250;
}
#pragma mark - carouseControlDelegate
//scrollView要显示放入图片数组
- (NSArray *)zzcarousel:(ZZCarouselControl *)carouselView {
    
    return _picUrlArr;
}
//添加imageView
- (UIView *)zzcarousel:(ZZCarouselControl *)carouselView carouselFrame:(CGRect)frame data:(NSArray *)data viewForItemAtIndex:(NSInteger)index {
    
    UIView *view =[[UIView alloc]initWithFrame:frame];
    UIImageView *imageView =[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
    [imageView sd_setImageWithURL:[NSURL URLWithString:data[index]]];
    [view addSubview:imageView];
    
    return view;
}

- (void)createTableView {
    UITableView *myTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 250, kMainBoundsW, kMainBoundsH-250) style:UITableViewStyleGrouped];
    myTableView.delegate =self;
    myTableView.dataSource = self;
    //myTableView.backgroundColor = [UIColor redColor];
    myTableView.scrollEnabled = NO;
    [_bgScrollView addSubview:myTableView];
    _myTableView = myTableView;
    
    [_myTableView registerClass:[CommuityTableViewCell class] forCellReuseIdentifier:CellID];
    NSArray *images = @[[UIImage imageNamed:@"mascot_1"],[UIImage imageNamed:@"mascot_2"]];
    [RefreshTool refreshWithImages:images andViewController:self andTableView:_myTableView];
}

- (void)getData {
    
    
    NSArray *nameArr = @[@"热门",@"关注",@"红人"];
    NSArray *idArr = @[@"5",@"6",@"2"];
    
    [_dataArr removeAllObjects];
    [ZHTTPManager getRequestWithUrl:@"http://api-v2.mall.hichao.com/forum/timeline" andPragramer:@{@"nav_id":idArr[selectIndex],@"nav_name":nameArr[selectIndex],@"flag=":@"",@"user_id":@"",@"gc":@"appstore",@"gf":@"iphone",@"gn":@"mxyc_ip",@"gv":@"6.6",@"gi":@"DA51E858-FC0D-4ACA-94C8-EC43CA9AC969",@"gs":@"640x1136",@"gos":@"8.4",@"access_token":@""} withResposeBlock:^(id responseObject, NSError *error) {
        NSDictionary *dic =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        //NSLog(@"%@",dic);
        NSDictionary *dataDic = dic[@"data"];
        NSArray *itemsArr = dataDic[@"items"];
        if (selectIndex ==0) {
            for (NSDictionary *temp in itemsArr) {
                NSDictionary *comDic =temp[@"component"];
               // NSLog(@"%@",comDic);
                ZCompontentModel *model =[ZCompontentModel ZCompontentModelWithDic:comDic];
                [_dataArr addObject:model];
                
            }
        }else {
            for (int i=0; i<itemsArr.count; i++) {
                if (0==i) {
                    NSDictionary *temp = itemsArr[0][@"component"];
                    NSArray *foucusArr = temp[@"focus_users"];
                    NSMutableArray *starArr = [NSMutableArray array];
                    for (NSDictionary *t in foucusArr) {
                        NSDictionary *commDic = t[@"component"];
                        ZCompontentModel *model =  [ZCompontentModel ZCompontentModelWithDic:commDic];
                        [starArr addObject:model];
                    }
                    [_dataArr addObject:starArr];
                }else {
                    NSDictionary *bigDic = itemsArr[i][@"component"];
                    ZCompontentModel *BigModel =[ZCompontentModel ZCompontentModelWithDic:bigDic];
                    [_dataArr addObject:BigModel];
                    
                }
                
            }
        }
        //NSLog(@"++++%@",_dataArr[0]);
        maxHeght +=(364+50)*self.dataArr.count;
        //NSLog(@"-------%ld",self.dataArr.count);
        _bgScrollView.contentSize = CGSizeMake(0, maxHeght);
        [_myTableView reloadData];
        [_myTableView.mj_header endRefreshing];
    }];
    
}
#pragma mark - TableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 1;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // NSLog(@"===%ld",self.dataArr.count);
    return self.dataArr.count;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CommuityTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:CellID forIndexPath:indexPath];
    
    [cell deleteAllSubviews];
    
    if (selectIndex ==0) {
        
        ZCompontentModel *model = self.dataArr[indexPath.section];
        cell.model = model;
        
    }else {
        if (indexPath.section==0) {
            //[cell deleteAllSubviews];
            //重新布局
            NSMutableArray *starArr = self.dataArr[indexPath.section];
            //NSLog(@"%@",starArr);
            UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kMainBoundsW, 365)];
            //scrollView.backgroundColor = [UIColor yellowColor];
            scrollView.pagingEnabled = YES;
            scrollView.contentSize = CGSizeMake(kMainBoundsW*starArr.count, 365);
            [cell.contentView addSubview:scrollView];
            
            for (int i=0; i<starArr.count; i++) {
                ZCompontentModel *model = starArr[i];
                //NSLog(@"%@----%@",model.picUrl,model.title);
                UIImageView *imageView =[[UIImageView alloc]init];
                imageView.center = CGPointMake(kMainBoundsW/2+kMainBoundsW*i, 100);
                imageView.bounds = CGRectMake(0, 0, 100, 100);
                imageView.layer.cornerRadius = 50;
                imageView.layer.masksToBounds = YES;
                [imageView sd_setImageWithURL:[NSURL URLWithString:model.picUrl]];
                UILabel *label = [[UILabel alloc]init];
                label.center = CGPointMake(kMainBoundsW/2+kMainBoundsW*i, 200);
                label.bounds = CGRectMake(0, 0, 200, 30);
                label.text = model.title;
                label.textAlignment = NSTextAlignmentCenter;
                [scrollView addSubview:imageView];
                [scrollView addSubview:label];
            }
        }else{
            
            ZCompontentModel *model = self.dataArr[indexPath.section];
            cell.model = model;
        }
        
    }
    
    return cell;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (selectIndex!=0&&section==0) {
        return nil;
    }
    
    ZCompontentModel *model = self.dataArr[section];
    ZUserModel *userModel = model.user;
    UIView *bgView = [UIView new];
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 5, 40, 40)];
    [imageView sd_setImageWithURL:[NSURL URLWithString:userModel.userAvatar]];
    imageView.layer.cornerRadius = 20;
    imageView.layer.masksToBounds =YES;
    [bgView addSubview:imageView];
    
    for (int i=0; i<2; i++) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(60, 5+20*i, 100, 20)];
        label.font = [UIFont systemFontOfSize:12];
        if (0==i) {
            label.text = userModel.username;
        }else {
            label.text = userModel.datatime;
        }
        [bgView addSubview:label];
    }
    return bgView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (selectIndex!=0&&section==0) {
        return 0;
    }
    return 50;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 365;
    
}
#pragma mark - scrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    if (scrollView.tag ==20) {
        //滑动
        
        if (_bgScrollView.contentOffset.y<134) {
            _tabBar.frame = CGRectMake(0, 200, kMainBoundsW, 50);
            _myTableView.frame =CGRectMake(0, 250, kMainBoundsW, kMainBoundsH);
            _myTableView.contentOffset = CGPointMake(0, 0);
            return ;
        }
        
        _myTableView.center =CGPointMake(self.view.center.x, self.view.center.y+_bgScrollView.contentOffset.y);
        //_myTableView.bounds = CGRectMake(0, 0, kMainBoundsW, kMainBoundsH);
        //NSLog(@"%f",_bgScrollView.contentOffset.y);
        _tabBar.frame = CGRectMake(0, _bgScrollView.contentOffset.y+64, kMainBoundsW, 50);
        
        
        _myTableView.contentOffset =CGPointMake(0, _bgScrollView.contentOffset.y-200);
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
