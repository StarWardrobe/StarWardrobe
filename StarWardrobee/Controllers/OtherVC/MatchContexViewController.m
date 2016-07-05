//
//  MatchContexViewController.m
//  StarWardrobee
//
//  Created by Mac on 16/7/5.
//  Copyright © 2016年 Happy. All rights reserved.
//

#import "MatchContexViewController.h"
#import "CHTTPAsk.h"
#import "MatchTableViewCell.h"
#import "CMatchCellModel.h"

typedef enum : NSUInteger {
    
    ScrollHeaderViewTag = 20,
    ChooseCollectionTag = 100,
    CellScrollTag = 150,
    
    WatherFallTableLeft = 1000,
    WatherFallTableRight,
    WatherFallScroll,
    mainScrollViewTag,
} matchVCTags;

@interface MatchContexViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UITableViewDataSource,UITableViewDelegate>
{
   
    UICollectionView * ChooseColleView;
    UIScrollView *SelectElementScrollView;
    BOOL isChoosePersonMatch;
    UILabel *titleLabel;
    UIButton *ChoosePersonbutton;
    NSMutableArray *TopScrollArray;
    UIScrollView *mainScrollView;
    CGFloat _colHeight[2];
    UIScrollView *CellScrollView;
    //UIScrollView *mainScrollView;
}
@property(retain,nonatomic)NSMutableArray *dataArray;
@property(retain,nonatomic)NSMutableArray *indexArray;

@property(retain,nonatomic)NSMutableArray *dataTableArray;
@property(retain,nonatomic)NSMutableArray *indexTableArray;//index数据源

@end

@implementation MatchContexViewController
- (NSMutableArray *)dataTableArray {
    if (!_dataTableArray) {
        _dataTableArray = [NSMutableArray array];
    }
    return _dataTableArray;
}
- (NSMutableArray *)indexTableArray {
    if (!_indexTableArray) {
        _indexTableArray = @[@[].mutableCopy,@[].mutableCopy].mutableCopy;
    }
    return _indexTableArray;
}

- (NSMutableArray *)indexArray {
    if (!_indexArray) {
        _indexArray = @[@[].mutableCopy,@[].mutableCopy].mutableCopy;
    }
    return _indexArray;
}
- (NSMutableArray *)dataArray {
    return [NSMutableArray arrayWithObjects:@"娇小",@"甜美",@"街头",@"闺蜜",@"运动",@"本土",@"逛街",@"OL",@"休闲",@"高挑",@"优选",@"欧美",@"摩登",@"约会",@"轻熟",@"清新",@"丰满",@"典礼",@"热门",@"复古",@"型男",@"混搭",@"派对",@"出游",@"日韩", nil];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor cyanColor];
    [self beginIndexArray];
    [self createMatchMainView];
    
}
- (void)beginIndexArray {
    [self.indexArray[1] addObjectsFromArray:self.dataArray];
}
- (void)createMatchTopScrollViewWithIndexArryFirstEle:(NSMutableArray *)indexFirstArr {
    [TopScrollArray removeAllObjects];
    TopScrollArray = @[@"最新"].mutableCopy;
    [TopScrollArray addObjectsFromArray:indexFirstArr];
    
    static dispatch_once_t hanwanjie;
    //只执行一次
    dispatch_once(&hanwanjie, ^{
        [CHTTPAsk netHTTPForMatchScrollViewCellWith:TopScrollArray[0] GetArray:^(NSMutableArray *arr) {
            
            [self createMatchCellScrollViewFallWith:arr];
            //[mainScrollView addSubview:CellScroll];
        }];
        mainScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, -14, kMainBoundsW, kMainBoundsH+64)];
    });
    
    mainScrollView.contentSize = CGSizeMake(kMainBoundsW*TopScrollArray.count, 0);
    mainScrollView.tag = mainScrollViewTag;
    mainScrollView.pagingEnabled = YES;
    [self.view addSubview:mainScrollView];
    
    for (UIButton *button in [SelectElementScrollView subviews]) {
        [button removeFromSuperview];
    }
    
    for (int i = 0; i<TopScrollArray.count; i++) {
        UIButton *butto = [UIButton buttonWithType:UIButtonTypeSystem];
        butto.frame = CGRectMake(80*i, 0, 80, 50);
        [butto setTitle:TopScrollArray[i] forState:UIControlStateNormal];
        butto.tag = ScrollHeaderViewTag+i;
        [butto addTarget:self action:@selector(ChooseKindOfFashion:) forControlEvents:UIControlEventTouchUpInside];
        [SelectElementScrollView addSubview:butto];
    }
    
    SelectElementScrollView.contentSize = CGSizeMake(80*TopScrollArray.count, 0);
    [self.view addSubview:SelectElementScrollView];
    
}
- (void)ChooseKindOfFashion:(UIButton *)sender {
    
    NSLog(@"%@",TopScrollArray[sender.tag-ScrollHeaderViewTag]);
    //也可以在这里把小scrollView的东西移除
    NSArray *arr = [mainScrollView subviews];
    for (UIScrollView *oldScroll in arr) {
        [oldScroll removeFromSuperview];
    }
    [CHTTPAsk netHTTPForMatchScrollViewCellWith:TopScrollArray[sender.tag-ScrollHeaderViewTag] GetArray:^(NSMutableArray *arr) {
        //        [UIView animateWithDuration:0.3 animations:^{
        //            CellScrollView.center = CGPointMake(kMainBoundsW/2+kMainBoundsW*(sender.tag-ScrollHeaderViewTag), CellScrollView.center.y);
        //        } completion:^(BOOL finished) {
        [self createMatchCellScrollViewFallWith:arr];
        //        }];
    }];
}

- (void)createMatchMainView {
    SelectElementScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(5, 64, kMainBoundsW-55, 50)];
    [self createMatchTopScrollViewWithIndexArryFirstEle:self.indexArray[0]];
    ChoosePersonbutton = [UIButton buttonWithType:UIButtonTypeSystem];
    ChoosePersonbutton.center = CGPointMake(kMainBoundsW-25, 64+25);
    ChoosePersonbutton.bounds = CGRectMake(0, 0, 20, 20);
    [ChoosePersonbutton setBackgroundImage:[UIImage imageNamed:@"icon_class_open@3x"] forState:UIControlStateNormal];
    [ChoosePersonbutton addTarget:self action:@selector(ChooseElementButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:ChoosePersonbutton];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    ChooseColleView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 64, kMainBoundsW,50) collectionViewLayout:layout];
    ChooseColleView.backgroundColor = [UIColor whiteColor];
    ChooseColleView.delegate = self;
    ChooseColleView.dataSource = self;
    ChooseColleView.hidden = YES;
    ChooseColleView.tag = ChooseCollectionTag;
    [self.view addSubview:ChooseColleView];
    [ChooseColleView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    [ChooseColleView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];
    
    titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 64, kMainBoundsW, 50)];
    titleLabel.text = @"频道定制";
    titleLabel.hidden = YES;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:titleLabel];
    
}
//返回两个区
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 2;
}
//返回每个区有多少个item
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.indexArray[section] count];
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeMake(0, 50);
}
//设置每一个item
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, (kMainBoundsW-50)/4, 25)];
    UILabel *Celllabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, (kMainBoundsW-50)/4, 25)];
    Celllabel.text = self.indexArray[indexPath.section][indexPath.row];
    [view addSubview:Celllabel];
    cell.backgroundView = view;
    return cell;
}
//设个item有多大
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake((kMainBoundsW-50)/4, 25);
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(10, 10, 10, 10);
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    UICollectionReusableView *View = nil;
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        View = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header" forIndexPath:indexPath];
        UILabel *KAINLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, kMainBoundsW/2, 50)];
        [View addSubview:KAINLabel];
        if (indexPath.section == 0) {
            UIButton *Bainjibutton = [UIButton buttonWithType:UIButtonTypeSystem];
            [Bainjibutton setTitle:@"编辑" forState:UIControlStateNormal];
            Bainjibutton.frame = CGRectMake(kMainBoundsW-80, 0, 50, 50);
            [View addSubview:Bainjibutton];
            KAINLabel.text = @"我的分类";
        }else if (indexPath.section == 1) {
            KAINLabel.text = @"点击添加分类";
        }
        
    }
    return View;
}
-  (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger a = (indexPath.section+1)%2;
    
    NSString *contentStr = self.indexArray[indexPath.section][indexPath.row];
    [self.indexArray[indexPath.section] removeObjectAtIndex:indexPath.row];
    [self.indexArray[a] addObject:contentStr];
    
    [collectionView reloadData];
}

- (void)ChooseElementButtonClick:(UIButton *)sender {
    isChoosePersonMatch = !isChoosePersonMatch;
    NSLog(@"%d",isChoosePersonMatch);
    ChoosePersonbutton.transform = CGAffineTransformMakeRotation(M_PI*isChoosePersonMatch);
    if (isChoosePersonMatch) {
        //跳出选择视图
        [UIView animateWithDuration:0.2 animations:^{
            mainScrollView.hidden = YES;
            SelectElementScrollView.hidden = YES;
            titleLabel.hidden = NO;
            ChooseColleView.hidden = NO;
            ChooseColleView.frame = CGRectMake(0, 64+50, kMainBoundsW, kMainBoundsH-64);
        } completion:^(BOOL finished) {
            //            UICollectionView *collect = [self.view viewWithTag:ChooseCollectionTag];
            //            [collect reloadData];
        }];
        
    }else {
        [UIView animateWithDuration:0.2 animations:^{
            mainScrollView.hidden = NO;
            SelectElementScrollView.hidden = NO;
            titleLabel.hidden = YES;
            ChooseColleView.hidden = YES;
            ChooseColleView.frame = CGRectMake(0, 64, kMainBoundsW,50);
        } completion:^(BOOL finished) {
            [self createMatchTopScrollViewWithIndexArryFirstEle:self.indexArray[0]]; 
        }];
    }
}



#pragma mark---小的scrollView以及内部的tableView方法及代理--------
- (void)createMatchCellScrollViewFallWith:(NSMutableArray *)array {
    [self.dataTableArray removeAllObjects];
    [self.indexTableArray[0] removeAllObjects];
    [self.indexTableArray[1] removeAllObjects];
    _colHeight[0] = 0;
    _colHeight[1] = 0;
    [self.dataTableArray addObjectsFromArray:array];
    
    CellScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 55, kMainBoundsW, mainScrollView.frame.size.height-50)];
    CellScrollView.tag = CellScrollTag;
    CellScrollView.delegate = self;
    [mainScrollView addSubview:CellScrollView];
    for (int i=0; i<2; i++) {
        UITableView *table = [[UITableView alloc]initWithFrame:CGRectMake(i*(kMainBoundsW/2), 0, kMainBoundsW/2, kMainBoundsH) style:UITableViewStylePlain];
        table.backgroundColor = [UIColor redColor];
        table.delegate = self;
        table.dataSource = self;
        table.tag = i+WatherFallTableLeft;
        //scroll的滑动属性
        table.scrollEnabled = NO;
        
        [CellScrollView addSubview:table];
        //去掉莫名其妙的cell
        table.tableFooterView = [UIView new];
        [table registerClass:[MatchTableViewCell class] forCellReuseIdentifier:@"cell"];
    }
    //[self addSubview:mainScrollView];
    [self reloadView];
}

- (void)reloadView {
    if (self.dataTableArray.count == 0) {
        return;
    }
    
    //遍历数据源
    for (int i = 0; i<self.dataTableArray.count; i++) {
        //取出最低列数
        NSInteger index = _colHeight[0]<=_colHeight[1]?0:1;
        //取出当前数据
        CMatchCellModel *model =self.dataTableArray[i];
        //记录最新高度
        _colHeight[index] += model.cellHeight + 50;
        //把i存入到index数组
        [self.indexTableArray[index] addObject:@(i)];
    }
    
    CellScrollView.contentSize = CGSizeMake(0, MAX(_colHeight[0], _colHeight[1]));
    //刷新表
    for (int i=0; i<2; i++) {
        UITableView *table = (UITableView *)[CellScrollView viewWithTag:WatherFallTableLeft + i];
        
        [table reloadData];
    }
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger index = tableView.tag-WatherFallTableLeft;
    NSArray *arr = self.indexTableArray[index];
    if (arr.count!=0) {
        return arr.count;
    }
    return 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger index = tableView.tag-WatherFallTableLeft;
    NSMutableArray *arr = self.indexTableArray[index];
    if (arr.count!=0) {
        //根据小数组中的index从大数组取出对应的model
        NSNumber *number = arr[indexPath.row];
        CMatchCellModel *model = self.dataTableArray[[number integerValue]];
        if (model.cellHeight > 0) {
            return model.cellHeight+50;
        }
    }
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MatchTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    NSMutableArray *arr = self.indexTableArray[tableView.tag-WatherFallTableLeft];
    if (arr.count != 0) {
        NSNumber *num = arr[indexPath.row];
        CMatchCellModel *model = self.dataTableArray[[num integerValue]];
        cell.model = model;
    }    
    return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    UITableView *left = (UITableView *)[scrollView viewWithTag:WatherFallTableLeft];
    UITableView *right = (UITableView *)[scrollView viewWithTag:WatherFallTableRight];
    if (scrollView.tag == CellScrollTag) {
        //找两个表
        
        left.center = CGPointMake(left.center.x, scrollView.contentOffset.y+64+(kMainBoundsH-114)/2);
        right.center = CGPointMake(right.center.x, scrollView.contentOffset.y+64+(kMainBoundsH-114)/2);
        left.contentOffset = scrollView.contentOffset;
        right.contentOffset = scrollView.contentOffset;
    }
    if (scrollView.tag == mainScrollViewTag) {
        
        NSInteger index = scrollView.contentOffset.x/kMainBoundsW;
        //左右划，取数据，刷表。
        
        NSArray *arr = [mainScrollView subviews];
        for (UIScrollView *oldScroll in arr) {
            [oldScroll removeFromSuperview];
        }
        [CHTTPAsk netHTTPForMatchScrollViewCellWith:TopScrollArray[index] GetArray:^(NSMutableArray *arr) {
            
            [self createMatchCellScrollViewFallWith:arr];
            
        }];
        CellScrollView.center = CGPointMake(kMainBoundsW/2+kMainBoundsW*index, CellScrollView.center.y);
        
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
