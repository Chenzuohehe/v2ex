//
//  MainTableViewCell.h
//  v2ex
//
//  Created by ChenZuo on 16/6/30.
//  Copyright © 2016年 chenzuo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FeedEntity.h"

@interface MainTableViewCell : UITableViewCell

@property (strong , nonatomic) FeedEntity * detail;

@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *tagLabel;
@property (weak, nonatomic) IBOutlet UIButton *replyNumberButton;
@property (weak, nonatomic) IBOutlet UILabel *replyStatusLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tagLabelWidth;


- (void)setFeedEntity:(FeedEntity *)detail;

@end
