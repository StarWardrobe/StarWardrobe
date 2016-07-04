//
//  MatchViewController.m
//  StarWardrobee
//
//  Created by Mac on 16/7/3.
//  Copyright © 2016年 Happy. All rights reserved.
//

#import "MatchViewController.h"

typedef enum : NSUInteger {
    headerButtonTag = 10,
    ScrollHeaderViewTag = 20,
} matchVCTags;

@interface MatchViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
{
    UILabel *label;
    UICollectionView * ChooseColleView;
    UIScrollView *SelectElementScrollView;
    BOOL isChoosePersonMatch;
    UILabel *titleLabel;
    UIButton *ChoosePersonbutton;
    
}
@property(retain,nonatomic)NSMutableArray *dataArray;
@property(retain,nonatomic)NSMutableArray *indexArray;
@end

@implementation MatchViewController
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
    [self createTitleButton];
    [self createMatchMainView];
    
}
- (void)beginIndexArray {
    [self.indexArray[1] addObjectsFromArray:self.dataArray];
}
- (void)createTitleButton {
    UIView *bgView = [UIView new];
    bgView.frame = CGRectMake(0, 0, kMainBoundsW/2, 44);
    NSArray *arr = @[@"搭配",@"专题"];
    self.navigationItem.titleView = bgView;
    for (int i = 0; i<2; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
        button.frame = CGRectMake(kMainBoundsW/4*i, 0, kMainBoundsW/4, 40);
        button.tag = headerButtonTag+i;
        [button setTitle:arr[i] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(MatchbuttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [bgView addSubview:button];
    }
    
    label = [[UILabel alloc]initWithFrame:CGRectMake(0, 40, kMainBoundsW/4, 3)];
    label.backgroundColor = [UIColor redColor];
    [bgView addSubview:label];
}
- (void)MatchbuttonClick:(UIButton *)sender {
    [UIView animateWithDuration:0.3 animations:^{
    label.center = CGPointMake(kMainBoundsW/4*(sender.tag-headerButtonTag)+kMainBoundsW/8, 41);
    } completion:^(BOOL finished) {
       //切换视图 
    }];
    
}
- (void)createMatchTopScrollViewWithIndexArryFirstEle:(NSMutableArray *)indexFirst {
    NSMutableArray *TopScrollArray = @[@"最新"].mutableCopy;
    [TopScrollArray addObjectsFromArray:indexFirst];
    
    SelectElementScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(5, 64, kMainBoundsW-55, 50)];
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
    
}
- (void)createMatchMainView {
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
    ChoosePersonbutton.transform = CGAffineTransformMakeRotation(M_PI*isChoosePersonMatch);
    if (isChoosePersonMatch) {
        //跳出选择视图
        [UIView animateWithDuration:0.2 animations:^{
            SelectElementScrollView.hidden = YES;
            titleLabel.hidden = NO;
            ChooseColleView.hidden = NO;
            ChooseColleView.frame = CGRectMake(0, 64+50, kMainBoundsW, kMainBoundsH-64);
        } completion:^(BOOL finished) {
            
        }];

    }else {
        [UIView animateWithDuration:0.2 animations:^{
            SelectElementScrollView.hidden = NO;
            titleLabel.hidden = YES;
            ChooseColleView.hidden = YES;
            ChooseColleView.frame = CGRectMake(0, 64, kMainBoundsW,50);
        } completion:^(BOOL finished) {
            [self createMatchTopScrollViewWithIndexArryFirstEle:self.indexArray[0]]; 
        }];
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
