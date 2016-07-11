//
//  DetailViewController.h
//  v2ex
//
//  Created by MAC on 16/7/7.
//  Copyright © 2016年 chenzuo. All rights reserved.
//

#import "BaseViewController.h"
#import "FeedEntity.h"

@interface DetailViewController : BaseViewController

@property (strong , nonatomic) FeedEntity * detail;
@property (copy , nonatomic) NSString * htmlString;
@property (copy , nonatomic) NSString * identifier;
@property (strong , nonatomic) NSDictionary * detailDic;
@end
