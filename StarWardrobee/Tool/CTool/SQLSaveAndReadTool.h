//
//  SQLSaveAndReadTool.h
//  StarWardrobee
//
//  Created by Mac on 16/7/6.
//  Copyright © 2016年 Happy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SQLSaveAndReadTool : NSObject
+ (void)createSQLSave;
+ (void)createTableWithTableName:(NSString *)name AndArray:(NSMutableArray *)arr;
+ (NSMutableArray *)QuaryTAbleWithName:(NSString *)name;


@end
