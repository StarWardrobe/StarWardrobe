//
//  CMainWaterFallModel.h
//  StarWardrobee
//
//  Created by Mac on 16/7/4.
//  Copyright © 2016年 Happy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CMainWaterFallModel : NSObject
@property(copy,nonatomic)NSString *title;
@property(copy,nonatomic)NSString *countryName;
@property(copy,nonatomic)NSString *countryPicUrl;
@property(assign,nonatomic)float OldPrice;
@property(assign,nonatomic)float NewPrice;
@property(assign,nonatomic)float width;
@property(assign,nonatomic)float height;
@property(copy,nonatomic)NSString *picUrl;

@property(assign,nonatomic)float cellHeight;
@end
