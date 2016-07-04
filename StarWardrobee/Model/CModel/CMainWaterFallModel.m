//
//  CMainWaterFallModel.m
//  StarWardrobee
//
//  Created by Mac on 16/7/4.
//  Copyright © 2016年 Happy. All rights reserved.
//

#import "CMainWaterFallModel.h"

@implementation CMainWaterFallModel

- (float)cellHeight{
    if (self.width==0||self.height==0) {
        return 0;
    }
    float width = (kMainBoundsW -40)/2;
    float height = self.height*(width/self.width);
    return  height;
}
@end
