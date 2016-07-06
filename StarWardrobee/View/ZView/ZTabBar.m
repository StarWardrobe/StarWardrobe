//
//  ZTabBar.m
//  StarWardrobee
//
//  Created by Mac on 16/7/4.
//  Copyright © 2016年 Happy. All rights reserved.
//

#import "ZTabBar.h"

#define TBCnter self.frame.size.width/(self.titles.count*2)
#define TBWidth self.frame.size.width/(self.titles.count)

@interface ZTabBar ()
{
    UIView *_view;

}

@end

@implementation ZTabBar

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)initWithFrame:(CGRect)frame andTitles:(NSMutableArray *)titles withBlock:(ButtonClickBlock)myBlock {
    self = [super initWithFrame:frame];
    if (self) {
        self.titles = titles;
        self.clickBlock = myBlock;
        [self createView];
    }
    return self;
}
- (void)createView {
    
    for (int i=0; i<self.titles.count; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.center = CGPointMake(TBCnter+TBWidth*i, self.frame.size.height/2);
       btn.bounds = CGRectMake(0, 0, 50, 30);
        [btn setTitle:self.titles[i] forState:UIControlStateNormal];
        btn.tag =10+i;
        [btn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
    }
    UIView *view = [[UIView alloc]init];
    view.center = CGPointMake(TBCnter,self.frame.size.height-2);
    view.bounds = CGRectMake(0, 0, 50, 4);
    view.backgroundColor = [UIColor redColor];
    [self addSubview:view];
    _view = view;
    
}
- (void)buttonClick:(UIButton *)sender {
    NSInteger index = sender.tag-10;
    self.clickBlock(index);
    [self chageFrameWith:index];

}
- (void)chageFrameWith:(NSInteger)index {
    
    [UIView animateWithDuration:0.3 animations:^(void){
        _view.center = CGPointMake(TBCnter+index*TBWidth, self.frame.size.height-2);
    }];

}
@end
