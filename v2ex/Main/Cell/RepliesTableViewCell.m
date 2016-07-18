//
//  RepliesTableViewCell.m
//  v2ex
//
//  Created by MAC on 16/7/8.
//  Copyright © 2016年 chenzuo. All rights reserved.
//

#import "RepliesTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "CommonUtil.h"
#import "Consts.h"

@implementation RepliesTableViewCell

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
    NSString * iamgeUrl = [NSString stringWithFormat:@"https:%@",[CommonUtil isEmpty:detail.member.avatar_large]?@"":detail.member.avatar_large];
    [self.headImageView sd_setImageWithURL:[NSURL URLWithString:iamgeUrl] placeholderImage:nil];
    self.nameLabel.text = [CommonUtil isEmpty:detail.member.username]?@"":detail.member.username;
    
    NSString * lastTouchString = [CommonUtil dateStringTime:detail.last_modified];
    self.repliesTimeLabel.text = [NSString stringWithFormat:@"%@前",lastTouchString];
    
    self.contentLabel.text = detail.content;
    
}


@end
