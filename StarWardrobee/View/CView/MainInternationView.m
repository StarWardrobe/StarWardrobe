//
//  MainInternationView.m
//  StarWardrobee
//
//  Created by Mac on 16/7/3.
//  Copyright © 2016年 Happy. All rights reserved.
//

#import "MainInternationView.h"

@implementation MainInternationView
- (void)createAllInternationViewWithArray:(NSMutableArray *)dataArray AndWithHeightFrom:(CGFloat)height {

        UIImageView *headerImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, -25, kMainBoundsW, kMainBoundsH/12+35)];
        [headerImageView sd_setImageWithURL:dataArray[0]];
        [self addSubview:headerImageView];
        for (int j =0; j<3; j++) {
            UIScrollView *scrollView = [[UIScrollView alloc]init];
            NSMutableArray *scrollArray = dataArray[j+1];
            if (j==0) {
                scrollView.frame = CGRectMake(0, kMainBoundsH/12, kMainBoundsW, kMainBoundsH/12+15);
                for (int k=0; k<scrollArray.count; k++) {
                    UIImageView *imageAD = [[UIImageView alloc]initWithFrame:CGRectMake(kMainBoundsW/5*k, 0, kMainBoundsW/5, scrollView.frame.size.height)];
                    [imageAD sd_setImageWithURL:[NSURL URLWithString:scrollArray[k]]];
                    [scrollView addSubview:imageAD];
                    scrollView.contentSize = CGSizeMake(imageAD.frame.size.width*(scrollArray.count), imageAD.frame.size.height);
                }
            }else if (j==1){
                scrollView.frame = CGRectMake(0, kMainBoundsH/6+15, kMainBoundsW, kMainBoundsH/2-15);
                for (int k=0; k<scrollArray.count; k++) {
                    UIImageView *imageAD = [[UIImageView alloc]initWithFrame:CGRectMake(kMainBoundsW*k, 0, kMainBoundsW, scrollView.frame.size.height)];
                    [imageAD sd_setImageWithURL:[NSURL URLWithString:scrollArray[k]]];
                    [scrollView addSubview:imageAD];
                    scrollView.contentSize = CGSizeMake(imageAD.frame.size.width*(scrollArray.count), imageAD.frame.size.height);
                    scrollView.pagingEnabled = YES;
                }
            }else if (j==2){
                scrollView.frame = CGRectMake(0, kMainBoundsH*2/3, kMainBoundsW, kMainBoundsW/3-5);
                for (int k=0; k<scrollArray.count; k++) {
                    CMainInternationModel *model = scrollArray[k];
                    UIView *ViewAD = [[UIView alloc]initWithFrame:CGRectMake(kMainBoundsW/5*k, 0, kMainBoundsW/5, scrollView.frame.size.height)];
                    UIImageView *imageAD = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, ViewAD.size.width, ViewAD.size.height/2)];
                    [imageAD sd_setImageWithURL:[NSURL URLWithString:model.picUrl]];
                    [ViewAD addSubview:imageAD];
                    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, ViewAD.size.height/2, ViewAD.size.width, ViewAD.size.height/8)];
                    titleLabel.textAlignment = NSTextAlignmentCenter;
                    titleLabel.text = model.title;
                    titleLabel.font = [UIFont systemFontOfSize:8];
                    [ViewAD addSubview:titleLabel];
                    UILabel *nowPriceLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, ViewAD.size.height*5/8, ViewAD.size.width, ViewAD.size.height/4)];
                    nowPriceLabel.textAlignment = NSTextAlignmentCenter;
                    nowPriceLabel.text = [NSString stringWithFormat:@"现价：%.0f",model.newPrice];
                    nowPriceLabel.font = [UIFont systemFontOfSize:12];
                    nowPriceLabel.textColor = [UIColor redColor];
                    [ViewAD addSubview:nowPriceLabel];
                    UILabel *oldPriceLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, ViewAD.size.height*7/8, ViewAD.size.width, ViewAD.size.height/8)];
                    oldPriceLabel.textAlignment = NSTextAlignmentCenter;
                    oldPriceLabel.text = [NSString stringWithFormat:@"原价：%.0f",model.OldPrice];
                    oldPriceLabel.font = [UIFont systemFontOfSize:8];
                    [ViewAD addSubview:oldPriceLabel];
                    
                    [scrollView addSubview:ViewAD];
                  scrollView.contentSize = CGSizeMake(imageAD.frame.size.width*(scrollArray.count), imageAD.frame.size.height);  
                 }
            }
            [self addSubview:scrollView];
        }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
