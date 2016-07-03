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

//枚举tag值
typedef enum : NSUInteger {
    mainScrellViewTag = 100,
    headerScrellViewTag,
    footScrellViewTag,
    TableViewLeft,
    TableViewRight,
} mainVCTags;

@interface MainViewController ()<UIScrollViewDelegate,UITableViewDataSource,UITableViewDelegate>
{
    CGFloat _colHeight[2];
    UIScrollView *mainScreenScroll;
}
@property(retain,nonatomic)NSMutableArray *dataArray;
@property(retain,nonatomic)NSMutableArray *indexArray;
@property(retain,nonatomic)NSMutableArray *footDTArray;

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
- (NSMutableArray *)footDTArray {
    if (!_footDTArray) {
        _footDTArray = @[].mutableCopy;
    }
    return _footDTArray;
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
    [self.view addSubview:mainScreenScroll];
    [self createTopScrollView];
    [self createTimeLimit];
    [self createInternationView];
    
    
    mainScreenScroll.contentSize = CGSizeMake(kMainBoundsW, MAX(_colHeight[0], _colHeight[1]));
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
//        NSLog(@"??????????????%f",_colHeight[0]);
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
