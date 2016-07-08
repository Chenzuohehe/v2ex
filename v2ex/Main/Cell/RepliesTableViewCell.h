//
//  RepliesTableViewCell.h
//  v2ex
//
//  Created by MAC on 16/7/8.
//  Copyright © 2016年 chenzuo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FeedEntity.h"

@interface RepliesTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *repliesTimeLabel;
@property (weak, nonatomic) IBOutlet UIWebView *repliesWebView;


- (void)setFeedEntity:(FeedEntity *)detail;
@end
