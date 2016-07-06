//
//  ShopTableViewCell.h
//  StarWardrobee
//
//  Created by Mac on 16/7/3.
//  Copyright © 2016年 Happy. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZShopModel;
@interface ShopTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIButton *circleBtn;

@property (weak, nonatomic) IBOutlet UIImageView *picture;
@property (weak, nonatomic) IBOutlet UILabel *descLabel;
@property (weak, nonatomic) IBOutlet UILabel *ZcolrLabel;

@property (weak, nonatomic) IBOutlet UILabel *ZSizeLabel;
@property (weak, nonatomic) IBOutlet UILabel *ZPriceLabel;
@property (strong, nonatomic)ZShopModel *model;
@end
