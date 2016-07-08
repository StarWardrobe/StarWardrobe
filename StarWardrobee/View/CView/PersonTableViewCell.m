//
//  PersonTableViewCell.m
//  StarWardrobee
//
//  Created by Mac on 16/7/6.
//  Copyright © 2016年 Happy. All rights reserved.
//

#import "PersonTableViewCell.h"

@interface PersonTableViewCell ()
{
    UIView *_bgView;
    UILabel *_TitleLabel;
    UILabel *_TimeLabel;
    UILabel *_KindLabel;
    UIImageView *_picImage;
    UILabel *_messLabel;
    UILabel *_seeLabel;
    UILabel *_concernLabel;
}
@end

@implementation PersonTableViewCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createCell];
    }
    return self;
}
- (void)setModel:(PersonModel *)model {
    if (_model != model) {
        _model = model;
        [self setNeedsLayout];
    }
}
- (void)createCell {
    
    _bgView = [UIView new];
    _bgView.frame = self.frame;
    
    _TitleLabel = [[UILabel alloc]init];
    [_bgView addSubview:_TitleLabel];
    
    _TimeLabel = [[UILabel alloc]init];
    [_bgView addSubview:_TimeLabel];
    
    _KindLabel = [[UILabel alloc]init];
    [_bgView addSubview:_KindLabel];
    
    _picImage = [[UIImageView alloc]init];
    [_bgView addSubview:_picImage];
    
        
    _messLabel = [[UILabel alloc]init];
    [_bgView addSubview:_messLabel];
    
    _seeLabel = [[UILabel alloc]init];
    [_bgView addSubview:_seeLabel];
    
    _concernLabel = [[UILabel alloc]init];
    [_bgView addSubview:_concernLabel];

  
    [self.contentView addSubview:_bgView];
}
- (void)layoutSubviews{
    [super layoutSubviews];
    PersonModel *model = self.model;
    
    NSArray *imagArray = @[@"icon_bbs_detail_comment_title_1218@2x",@"icon_bbs_detail_liuliang_1218@2x",@"icon_bbs_like_list@2x"];
    for (int i = 0; i<3; i++) {
        UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(5+(self.frame.size.width-10)/3*i, self.contentView.frame.size.height*4/5+10, 50, 50)];
        image.image = [UIImage imageNamed:imagArray[i]];
        [_bgView addSubview:image];
    }

    
    _TitleLabel.text = model.title;
    _TitleLabel.frame = CGRectMake(5, 5, self.frame.size.width-105, self.frame.size.height/5-50);

    _TimeLabel.frame = CGRectMake(5, self.frame.size.height/5-45, self.frame.size.width-105, 45);
    _TimeLabel.text = model.time;
    
    _KindLabel.center = CGPointMake(self.frame.size.width-45, self.frame.size.height/10);
    _KindLabel.bounds = CGRectMake(0,0,80, 50);
    _KindLabel.text = [NSString stringWithFormat:@"#%@#",model.kind];

    _picImage.frame = CGRectMake(5, self.frame.size.height/5, self.frame.size.width-10, self.frame.size.height*3/5);
    [_picImage sd_setImageWithURL:[NSURL URLWithString:model.picUrl]placeholderImage:[UIImage imageNamed:@"mascot_1"]];

    _messLabel.frame = CGRectMake(55, self.frame.size.height*4/5+10, 50, 50);
    _messLabel.text = [NSString stringWithFormat:@"%ld",model.messageCount];
    
    _seeLabel.frame = CGRectMake(55+(self.frame.size.width-10)/3, self.frame.size.height*4/5+10, 50, 50);
    _seeLabel.text = [NSString stringWithFormat:@"%ld",model.seeCount];
    
    _concernLabel.frame = CGRectMake(55+(self.frame.size.width-10)/3*2, self.frame.size.height*4/5+10, 50, 50);
    _concernLabel.text = [NSString stringWithFormat:@"%ld",model.concernCount];
    
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
