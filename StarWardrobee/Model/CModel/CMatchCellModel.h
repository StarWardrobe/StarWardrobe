//
//  CMatchCellModel.h
//  StarWardrobee
//
//  Created by Mac on 16/7/5.
//  Copyright © 2016年 Happy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CMatchCellModel : NSObject
@property(copy,nonatomic)NSString *PicUrl;
@property(copy,nonatomic)NSString *Description;
@property(assign,nonatomic)int itemsCount;
@property(assign,nonatomic)int collectionCount;
@property(assign,nonatomic)float width;
@property(assign,nonatomic)float height;

@property(assign,nonatomic)float cellHeight;
@end
