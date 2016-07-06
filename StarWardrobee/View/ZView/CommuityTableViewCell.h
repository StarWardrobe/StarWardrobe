//
//  CommuityTableViewCell.h
//  StarWardrobee
//
//  Created by Mac on 16/7/4.
//  Copyright © 2016年 Happy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZCompontentModel.h"
@interface CommuityTableViewCell : UITableViewCell
@property (strong, nonatomic)ZCompontentModel *model;
- (void)deleteAllSubviews;
@end
