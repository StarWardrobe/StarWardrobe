//
//  MatchTableViewCell.m
//  StarWardrobee
//
//  Created by Mac on 16/7/5.
//  Copyright © 2016年 Happy. All rights reserved.
//

#import "MatchTableViewCell.h"

@interface MatchTableViewCell ()
{
    UIView *_bgView;
    
    UIImageView *_imageView;
    UIImageView *_colloctionImageView;
    UILabel *_itemsLabel;
    UILabel *_collectionLabel;
    UILabel *_titleabel;
    UIImageView *_itemsImageView;
}

@end
@implementation MatchTableViewCell

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
    
    _colloctionImageView = [[UIImageView alloc]initWithFrame:CGRectZero];
    _colloctionImageView.image = [UIImage imageNamed:@"icon_like@2x"];
    [_bgView addSubview:_colloctionImageView];
    
    _imageView = [[UIImageView alloc]initWithFrame:CGRectZero];
    [_bgView addSubview:_imageView];
    
    _titleabel = [[UILabel alloc]initWithFrame:CGRectZero];
    _titleabel.text = @"";
    [_bgView addSubview:_titleabel];
    
    _collectionLabel = [[UILabel alloc]initWithFrame:CGRectZero];
    _collectionLabel.text = @"";
    [_bgView addSubview:_collectionLabel];
    
    _itemsLabel = [[UILabel alloc]initWithFrame:CGRectZero];
    _itemsLabel.text = @"";
    [_bgView addSubview:_itemsLabel];
    
    _itemsImageView = [[UIImageView alloc]initWithFrame:CGRectZero];
    _itemsImageView.image = [UIImage imageNamed:@"icon_link@3x"];
    [_bgView addSubview:_itemsImageView];
    
}
- (void)setModel:(CMatchCellModel *)model {
    if (_model != model) {
        _model = model;
        //间接调用layoutSubviews方法。
        [self setNeedsLayout];
    }
}

//布局改变（位置改变的时候）的时候就会调用
- (void)layoutSubviews{
    [super layoutSubviews];
    CMatchCellModel *model = self.model;
    
    if (model.PicUrl) {
        _imageView.frame = CGRectMake(5, 5, kMainBoundsW/2-10, model.cellHeight);
        [_imageView sd_setImageWithURL:[NSURL URLWithString:model.PicUrl]];
    }
    if (model.Description) {
        _titleabel.frame = CGRectMake(5, model.cellHeight+5,kMainBoundsW/2-10, 20);
        _titleabel.text = model.Description;
        _titleabel.font = [UIFont systemFontOfSize:10];
    }
    _itemsImageView.frame = CGRectMake(5, model.cellHeight+25, (kMainBoundsW-10)/8, 25);
    if (model.itemsCount) {
        _itemsLabel.frame = CGRectMake(5+(kMainBoundsW-10)/8, model.cellHeight+25, (kMainBoundsW-10)/8,25);
        _itemsLabel.text = [NSString stringWithFormat:@"%d",model.itemsCount];
    }
    _colloctionImageView.frame = CGRectMake((kMainBoundsW-10)/4+5, model.cellHeight+25, (kMainBoundsW-10)/8, 25);
    if (model.collectionCount) {
        _collectionLabel.frame = CGRectMake(5+(kMainBoundsW-10)*3/8, model.cellHeight+25, (kMainBoundsW-10)/8, 25);
        _collectionLabel.text = [NSString stringWithFormat:@"%d",model.collectionCount];
    }
  _bgView.frame = self.contentView.bounds;
    
}







- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
