//
//  ContentTableViewCell.h
//  v2ex
//
//  Created by ChenZuo on 16/7/11.
//  Copyright © 2016年 chenzuo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FeedEntity.h"
@interface ContentTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *repliceTimeLabel;

@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

- (void)setFeedEntity:(FeedEntity *)detail;

@end
