//
//  RefreshTool.h
//  StarWardrobee
//
//  Created by Mac on 16/7/5.
//  Copyright © 2016年 Happy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RefreshTool : NSObject

+ (void)refreshWithImages:(NSArray *)images andViewController:(UIViewController *)vc andTableView:(UITableView *)scroll;

@end
