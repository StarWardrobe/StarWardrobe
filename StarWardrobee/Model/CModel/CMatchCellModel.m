//
//  CMatchCellModel.m
//  StarWardrobee
//
//  Created by Mac on 16/7/5.
//  Copyright © 2016年 Happy. All rights reserved.
//

#import "CMatchCellModel.h"

@implementation CMatchCellModel

- (float)cellHeight{
    if (self.width==0||self.height==0) {
        return 0;
    }
    float width = (kMainBoundsW -40)/2;
    float height = self.height*(width/self.width);
    return  height;
}

@end
