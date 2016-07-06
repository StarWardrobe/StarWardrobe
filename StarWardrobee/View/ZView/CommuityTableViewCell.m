//
//  CommuityTableViewCell.m
//  StarWardrobee
//
//  Created by Mac on 16/7/4.
//  Copyright © 2016年 Happy. All rights reserved.
//

#import "CommuityTableViewCell.h"
#define CellWidth self.frame.size.width
#define CellHeight self.frame.size.height
@interface CommuityTableViewCell ()
{
    UIScrollView *_picScrollView;
    UILabel *_contentLabel;
    UILabel *_linkLabel;
    UILabel *_tagsLabel;
    UILabel *_commentLabel;
    
    UIButton *_commentBtn;
    UIButton *_shareBtn;

}
@end

@implementation CommuityTableViewCell

- (void)awakeFromNib {
    // Initialization code
}
- (void)setModel:(ZCompontentModel *)model {
    if (_model != model) {
        _model =model;
        [self createView];
    }
}
- (void)createView {
    _picScrollView = [[UIScrollView alloc]init];
    [self.contentView addSubview:_picScrollView];
    
    _contentLabel = [[UILabel alloc]init];
    _contentLabel.numberOfLines =0;
    _contentLabel.font = [UIFont systemFontOfSize:12];
    [self.contentView addSubview:_contentLabel];
    
    _linkLabel = [[UILabel alloc]init];
    _linkLabel.font = [UIFont systemFontOfSize:12];
    [self.contentView addSubview:_linkLabel];
    
    _tagsLabel =[[UILabel alloc]init];
    _tagsLabel.font = [UIFont systemFontOfSize:12];
    _tagsLabel.textColor =[UIColor purpleColor];
    [self.contentView addSubview:_tagsLabel];
    
    _commentLabel = [[UILabel alloc]init];
   _commentLabel.font = [UIFont systemFontOfSize:12];
    [self.contentView addSubview:_commentLabel];
    
    _commentBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    _commentBtn.backgroundColor = [UIColor grayColor];
    [self.contentView addSubview:_commentBtn];
    
    _shareBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    _shareBtn.backgroundColor = [UIColor grayColor];
    [_shareBtn setTitle:@"分享" forState:UIControlStateNormal];
    [self.contentView addSubview:_shareBtn];

}
- (void)deleteAllSubviews {
    for (UIView *view in [self.contentView subviews]) {
        [view removeFromSuperview];
    }
}
- (void)layoutSubviews {
    [super layoutSubviews];
    
    ZCompontentModel *model = self.model;
   
    if (model.pics) {
         NSMutableArray *picArr =model.pics;
        _picScrollView.frame = CGRectMake(0, 0, CellWidth, 200);
        _picScrollView.contentSize = CGSizeMake(kMainBoundsW*picArr.count, 200);
        
        for (int i=0; i<picArr.count; i++) {
            UIImageView *imageView =[[UIImageView alloc]initWithFrame:CGRectMake(CellWidth*i, 0, CellWidth, 200)];
            [imageView sd_setImageWithURL:[NSURL URLWithString:picArr[i]]];
            [_picScrollView addSubview:imageView];
        }

    }
    //topScrollView
    if (model.content) {
        _contentLabel.frame = CGRectMake(0, 200, CellWidth, 60);
        _contentLabel.text = model.content;
         _linkLabel.frame = CGRectMake(0, 260, CellWidth, 15);
        _linkLabel.text = model.content;
    }
    if (model.tags) {
        NSMutableArray *tags = model.tags;
        NSString *str =nil;
        for (int i=0; i<tags.count; i++) {
            NSDictionary *temp = tags[i];
            NSString *category = temp[@"category"];
            if (0==i) {
                str =[NSString stringWithFormat:@"#%@",category];
            }else {
                str = [NSString stringWithFormat:@"%@ #%@",str,category];
            }
        }
        
        _tagsLabel.frame=CGRectMake(39, 275, kMainBoundsW, 20);
        _tagsLabel.text =str;
    }
    
    if (model.comments) {
        NSMutableArray *commentArr = model.comments;
        _commentLabel.frame =CGRectMake(0, 295, kMainBoundsW, 40);

        for (int i=0; i<commentArr.count; i++) {
            ZCommentsModel *comModel = commentArr[i];
            if (0==i) {
                _commentLabel.text = [NSString stringWithFormat:@"%@:%@",comModel.username,comModel.content];
            }else {
                _commentLabel.text = [NSString stringWithFormat:@"%@\n%@:%@",_commentLabel.text,comModel.username,comModel.content];
            }
        }

    }
    
    _commentBtn.frame = CGRectMake(0, 335,CellWidth/2, 30);
    [_commentBtn setTitle:[NSString stringWithFormat:@"评论：%ld",model.commentCount] forState:UIControlStateNormal];
    _shareBtn.frame = CGRectMake(CellWidth/2, 335, CellWidth/2, 30);
   
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
