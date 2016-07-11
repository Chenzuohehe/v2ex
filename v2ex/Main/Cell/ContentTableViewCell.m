//
//  ContentTableViewCell.m
//  v2ex
//
//  Created by ChenZuo on 16/7/11.
//  Copyright © 2016年 chenzuo. All rights reserved.
//

#import "ContentTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "CommonUtil.h"
#import "Consts.h"

@implementation ContentTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
    
    
}

- (void)setFeedEntity:(FeedEntity *)detail
{
    
    if (![CommonUtil dictIsEmpty:detail.member]) {
        NSString * iamgeUrl = [NSString stringWithFormat:@"https:%@",[CommonUtil isEmpty:detail.member[@"avatar_large"]]?@"":detail.member[@"avatar_large"]];
        [self.headImageView sd_setImageWithURL:[NSURL URLWithString:iamgeUrl] placeholderImage:nil];
        self.userNameLabel.text = [CommonUtil isEmpty:detail.member[@"username"]]?@"":detail.member[@"username"];
    }
//
//    
    self.titleLabel.text = [CommonUtil isEmpty:detail.title]?@"":detail.title;
//
    NSString * lastTouchString = [CommonUtil dateStringTime:detail.last_touched];
    self.repliceTimeLabel.text = [NSString stringWithFormat:@"%@前",lastTouchString];
    self.contentLabel.text = detail.content;
}



@end
