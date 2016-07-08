//
//  MainViewController.m
//  StarWardrobee
//
//  Created by Mac on 16/7/3.
//  Copyright © 2016年 Happy. All rights reserved.
//

#import "MainViewController.h"
#import "CMainHeaderModel.h"
#import "MainInternationView.h"
#import "MainFootTableViewCell.h"
#import "CMainWaterFallModel.h"

//枚举tag值
typedef enum : NSUInteger {
    mainScrellViewTag = 100,
    headerScrellViewTag,
    TableViewLeft,
    TableViewRight,
    buttonTag,
    
} mainVCTags;

@interface MainViewController ()<UIScrollViewDelegate,UITableViewDataSource,UITableViewDelegate>
{
    UIView *buttonView;
    CGFloat _colHeight[2];
    UIScrollView *mainScreenScroll;
    CGFloat NewHeight;
    UILabel *labe;
}
@property(retain,nonatomic)NSMutableArray *dataArray;
@property(retain,nonatomic)NSMutableArray *indexArray;

@end

@implementation MainViewController

- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}
- (NSMutableArray *)indexArray {
    if (!_indexArray) {
        _indexArray = @[@[].mutableCopy,@[].mutableCopy].mutableCopy;
    }
    return _indexArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _colHeight[0] = 0;
    _colHeight[1] = 0;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"bottom_comment_button@2x"] style:UIBarButtonItemStylePlain target:self action:@selector(messag)];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"bottom_head_sort@2x"] style:UIBarButtonItemStylePlain target:self action:@selector(Categor)];
    mainScreenScroll = [[UIScrollView alloc]init];
    mainScreenScroll.frame = kMainBounds;
    mainScreenScroll.delegate = self;
    mainScreenScroll.tag = mainScrellViewTag;
    [self.view addSubview:mainScreenScroll];
    [self createTopScrollView];
    [self createTimeLimit];
    [self createInternationView];
    [self createBringToTop];
    [self createTableViewFall];

    [self getWaterFallDataWith:0];
   
}
- (void)createBringToTop {
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 200, 40)];
    UISearchBar * bar = [[UISearchBar alloc]initWithFrame:view.frame];
    [view addSubview:bar];
    self.navigationItem.titleView = view;
    UIButton *layerToTop = [UIButton buttonWithType:UIButtonTypeCustom];
    [layerToTop addTarget:self action:@selector(ToTop) forControlEvents:UIControlEventTouchUpInside];
    [layerToTop setBackgroundImage:[UIImage imageNamed:@"icon_pull_share_black@2x"] forState:UIControlStateNormal];
    layerToTop.frame = CGRectMake(kMainBoundsW-55, kMainBoundsH-150, 30, 30);
    layerToTop.layer.cornerRadius = 10;
    layerToTop.clipsToBounds = YES;
    [layerToTop setBackgroundColor:[UIColor yellowColor]];
    [self.view addSubview:layerToTop];
}
//跳往首部
- (void)ToTop {
    [UIView animateWithDuration:0.5 animations:^{
        mainScreenScroll.contentOffset = CGPointMake(0, -64);
    } completion:^(BOOL finished) {
        
    }];
    
}
- (void)messag {
    NSLog(@"消息");
}
- (void)Categor {
    NSLog(@"分类");
}
- (void)createTopScrollView {
    [CHTTPAsk netHTTPForMainTopScrollArray:^(NSArray *arr) {
        UIScrollView *headerScrollView = [[UIScrollView alloc]init];
        headerScrollView.frame = CGRectMake(0, 0, kMainBoundsW, 250);

        for (int i = 0; i<arr.count; i++) {
            CMainHeaderModel *model = arr[i];
            UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(kMainBoundsW*i, 0, kMainBoundsW, 250)];
            [image sd_setImageWithURL:[NSURL URLWithString:model.picUrl]];
            [headerScrollView addSubview:image];
        }
        headerScrollView.pagingEnabled = YES;
        headerScrollView.contentSize = CGSizeMake(kMainBoundsW*(arr.count), 250);
        headerScrollView.delegate = self;
        headerScrollView.tag = headerScrellViewTag;
        [mainScreenScroll addSubview:headerScrollView];
    }];
    _colHeight[0] += 250;
    _colHeight[1] += 250;
}

- (void)createTimeLimit {
    //NSLog(@"%f",_colHeight[0]);
    [CHTTPAsk netHttpForMAINTimeLimted:^(NSArray *arr) {
        for (int i = 0; i<arr.count; i++) {
            UIImageView *timeLimtImageView = [[UIImageView alloc]initWithFrame:CGRectMake(10+((kMainBoundsW-30)/2+10)*i, 260, (kMainBoundsW-30)/2, 250)];
            [timeLimtImageView sd_setImageWithURL:arr[i]];
            [mainScreenScroll addSubview:timeLimtImageView];
        }
    }];
    _colHeight[0] += 260;
    _colHeight[1] += 260;
}

- (void)createInternationView {
    NSArray *arr = [CHTTPAsk GetUrl];
    CGFloat ALLHeight = arr.count*kMainBoundsH;
    
    for (int i = 0; i<arr.count; i++) {
      [CHTTPAsk netHTTPForMainInternationWithUrl:arr[i] :^(NSMutableArray *arr) {
          MainInternationView *view = [[MainInternationView alloc]initWithFrame:CGRectMake(0, 520+i*kMainBoundsH, kMainBoundsW, kMainBoundsH)];
          [view createAllInternationViewWithArray:arr AndWithHeightFrom:520+i*kMainBoundsH];
          [mainScreenScroll addSubview:view]; 
      }];  
    }
    _colHeight[0] += ALLHeight;
    _colHeight[1] += ALLHeight;
    
    NewHeight = 520+ALLHeight;
}

- (void)getWaterFallDataWith:(NSInteger)number {
    
    [CHTTPAsk netHTTPForFootTableViewWithChoose:number FallBackArr:^(NSMutableArray *arr) {
        //数据初始化
        [self.dataArray removeAllObjects];
        [self.indexArray[0] removeAllObjects];
        [self.indexArray[1] removeAllObjects];
        _colHeight[0] = NewHeight;
        _colHeight[1] = NewHeight;
        
        [self.dataArray addObjectsFromArray:arr];
        //NSLog(@"%ld",self.dataArray.count);
        if (self.dataArray.count == 0) {
            return;
        }
        for (int i = 0; i<self.dataArray.count; i++) {
            NSInteger index = _colHeight[0]<=_colHeight[1]?0:1;
            CMainWaterFallModel *model =self.dataArray[i];
            //记录最新高度
            _colHeight[index] += model.cellHeight + 50;
            //把i存入到index数组
            [self.indexArray[index] addObject:@(i)];
        }
        
        mainScreenScroll.contentSize = CGSizeMake(kMainBoundsW, MAX(_colHeight[0], _colHeight[1]));
        
        //刷新表
        for (int i=0; i<2; i++) {
            UITableView *table = (UITableView *)[mainScreenScroll viewWithTag:TableViewLeft + i];
            [table reloadData];
        }
    }];
}

- (void)createTableViewFall {
    NSArray *arr = @[@"今日上新",@"上装",@"裙装",@"裤装"];
    buttonView = [UIView new];
    buttonView.frame = CGRectMake(0, NewHeight, kMainBoundsW, 50);
    buttonView.backgroundColor = [UIColor whiteColor];
    [mainScreenScroll addSubview:buttonView];
    for (int i = 0; i<4; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
        button.frame = CGRectMake(kMainBoundsW/4*i, 0, kMainBoundsW/4, 45);
        [button setTitle:arr[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        button.tag = i+buttonTag;
        [button addTarget:self action:@selector(chooseColoseSys:) forControlEvents:UIControlEventTouchUpInside];
        [buttonView addSubview:button];
    }
    labe = [[UILabel alloc]initWithFrame:CGRectMake(0, 45, kMainBoundsW/4, 3)];
    labe.backgroundColor = [UIColor redColor];
    [buttonView addSubview:labe];
    for (int i=0; i<2; i++) {
        UITableView *table = [[UITableView alloc]initWithFrame:CGRectMake(i*(kMainBoundsW/2), NewHeight+55+64, kMainBoundsW/2, kMainBoundsH-55-64) style:UITableViewStylePlain];
        table.backgroundColor = [UIColor redColor];
        table.delegate = self;
        table.dataSource = self;
        table.tag = i+TableViewLeft;
        //scroll的滑动属性
        table.scrollEnabled = NO;
        
        [mainScreenScroll addSubview:table];
        //去掉莫名其妙的cell
        table.tableFooterView = [UIView new];
        [table registerClass:[MainFootTableViewCell class] forCellReuseIdentifier:@"cell"];
    }
}
//button点击事件
- (void)chooseColoseSys :(UIButton *)sender {
    UITableView *left = (UITableView *)[mainScreenScroll viewWithTag:TableViewLeft];
    UITableView *right = (UITableView *)[mainScreenScroll viewWithTag:TableViewRight];
    left.contentOffset = CGPointMake(0, -50);
    right.contentOffset = CGPointMake(0, -50);
    mainScreenScroll.contentOffset = CGPointMake(0, NewHeight-50);
    [UIView animateWithDuration:0.3 animations:^{
    labe.center = CGPointMake(sender.center.x, 46);
    } completion:^(BOOL finished) {
        [self getWaterFallDataWith:sender.tag-buttonTag];
    }];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger index = tableView.tag-TableViewLeft;
    NSArray *arr = self.indexArray[index];
    if (arr.count!=0) {
        return arr.count;
    }
    return 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger index = tableView.tag-TableViewLeft;
    NSMutableArray *arr = self.indexArray[index];
    if (arr.count!=0) {
        //根据小数组中的index从大数组取出对应的model
        NSNumber *number = arr[indexPath.row];
        CMainWaterFallModel *model = self.dataArray[[number integerValue]];
        if (model.cellHeight > 0) {
            return model.cellHeight+50;
        }
    }
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MainFootTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    //[cell setAllDefault];
    NSMutableArray *arr = self.indexArray[tableView.tag-TableViewLeft];
    if (arr.count != 0) {
        NSNumber *num = arr[indexPath.row];
        CMainWaterFallModel *model = self.dataArray[[num integerValue]];
        cell.model = model;
    }
    return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView.tag == mainScrellViewTag) {
       
        //找两个表
        UITableView *left = (UITableView *)[mainScreenScroll viewWithTag:TableViewLeft];
        UITableView *right = (UITableView *)[mainScreenScroll viewWithTag:TableViewRight];
        if (scrollView.contentOffset.y < NewHeight-59) {
            buttonView.center = CGPointMake(kMainBoundsW/2, NewHeight+25);
            left.frame = CGRectMake(0, NewHeight+55, kMainBoundsW / 2 , kMainBoundsH);
            right.frame = CGRectMake(kMainBoundsW / 2, NewHeight+55, kMainBoundsW / 2 , kMainBoundsH);
            left.contentOffset = CGPointMake(0, 0);
            right.contentOffset = CGPointMake(0, 0);
        }else {
            buttonView.center = CGPointMake(kMainBoundsW/2, scrollView.contentOffset.y+88);
            [mainScreenScroll bringSubviewToFront:buttonView];
            left.center = CGPointMake(left.center.x, scrollView.contentOffset.y+kMainBoundsH/2+55);
            right.center = CGPointMake(right.center.x, scrollView.contentOffset.y+kMainBoundsH/2+55);
            CGPoint offset = scrollView.contentOffset;
            offset.y -= NewHeight;
            left.contentOffset = offset;
            right.contentOffset = offset;
        }
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
