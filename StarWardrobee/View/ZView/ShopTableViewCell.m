//
//  ShopTableViewCell.m
//  StarWardrobee
//
//  Created by Mac on 16/7/3.
//  Copyright © 2016年 Happy. All rights reserved.
//

#import "ShopTableViewCell.h"
#import "ZShopModel.h"
@implementation ShopTableViewCell

- (void)awakeFromNib {
    // Initialization code
}
- (void)setModel:(ZShopModel *)model {
    if (![_model isEqual:model]) {
        _model =model;
        
    }
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
