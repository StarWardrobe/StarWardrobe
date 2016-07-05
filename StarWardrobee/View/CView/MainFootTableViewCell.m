//
//  MainFootTableViewCell.m
//  StarWardrobee
//
//  Created by Mac on 16/7/3.
//  Copyright © 2016年 Happy. All rights reserved.
//

#import "MainFootTableViewCell.h"


@interface MainFootTableViewCell ()
{
    UIView *_bgView;
    
    UIImageView *_imageView;
    UIImageView *_countryImage;
    UILabel *_countryLabel;
    UILabel *_oldPriceLabel;
    UILabel *_newPriceLabel;
    UILabel *_title;
}


@end

@implementation MainFootTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self createView];
    }
    return self;
}

#pragma mark----创建视图
- (void)createView{
    _bgView = [[UIView alloc]initWithFrame:CGRectZero];
    [self.contentView addSubview:_bgView];
    _countryImage = [[UIImageView alloc]initWithFrame:CGRectZero];
    [_bgView addSubview:_countryImage];
    
    _imageView = [[UIImageView alloc]initWithFrame:CGRectZero];
    [_bgView addSubview:_imageView];
    
    _countryLabel = [[UILabel alloc]initWithFrame:CGRectZero];
    _countryLabel.text = @"";
    [_bgView addSubview:_countryLabel];
    
    _oldPriceLabel = [[UILabel alloc]initWithFrame:CGRectZero];
    _oldPriceLabel.text = @"";
    [_bgView addSubview:_oldPriceLabel];
    
    _newPriceLabel = [[UILabel alloc]initWithFrame:CGRectZero];
    _newPriceLabel.text = @"";
    [_bgView addSubview:_newPriceLabel];

    _title = [[UILabel alloc]initWithFrame:CGRectZero];
    _title.text = @"";
    [_bgView addSubview:_title];
    
    
}
- (void)setModel:(CMainWaterFallModel *)model {
    if (_model != model) {
        _model = model;
        //间接调用layoutSubviews方法。
        [self setNeedsLayout];
    }
}

//布局改变（位置改变的时候）的时候就会调用
- (void)layoutSubviews{
    [super layoutSubviews];
    CMainWaterFallModel *model = self.model;
    
        if (model.picUrl) {
            _imageView.frame = CGRectMake(5, 5, kMainBoundsW/2-10, model.cellHeight);
            [_imageView sd_setImageWithURL:[NSURL URLWithString:model.picUrl]];
        }
        if (model.title) {
            _title.frame = CGRectMake(5, model.cellHeight+15,kMainBoundsW/2-10, 10);
            _title.text = model.title;
            _title.font = [UIFont systemFontOfSize:10];
        }
        if (model.countryName) {
            _countryLabel.frame = CGRectMake(15, model.cellHeight+5, 20, 10);
            _countryLabel.text = model.countryName;
            _countryLabel.font = [UIFont systemFontOfSize:8];
        }
        if (model.countryPicUrl) {
            _countryImage.frame = CGRectMake(5, model.cellHeight+5, 10, 10);
            [_countryImage sd_setImageWithURL:[NSURL URLWithString:model.countryPicUrl]];
        }
        if (model.OldPrice) {
            _oldPriceLabel.frame = CGRectMake(110, model.cellHeight+25, 100, 20);
            _oldPriceLabel.font = [UIFont systemFontOfSize:10];
            _oldPriceLabel.text = [NSString stringWithFormat:@"原价：%.2f",model.OldPrice];
            
        }
        if (model.NewPrice) {
            _newPriceLabel.frame = CGRectMake(10, model.cellHeight+25, 100, 20);
            _newPriceLabel.text = [NSString stringWithFormat:@"现价：%.2f",model.NewPrice];
            _newPriceLabel.textColor = [UIColor redColor];
            _newPriceLabel.font = [UIFont systemFontOfSize:15];
        }
        _bgView.frame = self.contentView.bounds;
    
}


//- (void)setAllDefault {
//    [_bgView removeFromSuperview];
//    _bgView = nil;
//    [self createView];
//}

@end
