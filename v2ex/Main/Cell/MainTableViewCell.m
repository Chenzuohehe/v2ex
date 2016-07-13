//
//  MainTableViewCell.m
//  v2ex
//
//  Created by ChenZuo on 16/6/30.
//  Copyright © 2016年 chenzuo. All rights reserved.
//

#import "MainTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "CommonUtil.h"
#import "Consts.h"

@implementation MainTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [CommonUtil addViewAttr:self.tagLabel borderWidth:1 borderColor:[UIColor whiteColor] cornerRadius:5];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}



- (void)setFeedEntity:(FeedEntity *)detail
{
    
    NSString * iamgeUrl = [NSString stringWithFormat:@"https:%@",[CommonUtil isEmpty:detail.member.avatar_large]?@"":detail.member.avatar_large];
    [self.headImageView sd_setImageWithURL:[NSURL URLWithString:iamgeUrl] placeholderImage:nil];
    self.userNameLabel.text = [CommonUtil isEmpty:detail.member.username]?@"":detail.member.username;
    
    NSString * tagString = [CommonUtil isEmpty:detail.node.title]?@"":detail.node.title;
    self.tagLabel.text = tagString;
    self.tagLabelWidth.constant = [CommonUtil sizeWithString:tagString fontSize:13 sizewidth:0 sizeheight:20].width + 8;
    
    
    self.titleLabel.text = [CommonUtil isEmpty:detail.title]?@"":detail.title;
    
//    NSString * replyNumberStr = [NSString stringWithFormat:@"%@",detail.replies];
    NSString * replyNumberStr = [CommonUtil isEmpty:detail.replies]?@"0":detail.replies;
    [self.replyNumberButton setTitle:replyNumberStr forState:UIControlStateNormal];
    
//    NSString * lastTouchString = [CommonUtil dateStringTime:detail.last_touched];
//    self.replyStatusLabel.text = [CommonUtil isEmpty:detail.last_touched]?@" ":detail.last_touched;
    
}


@end
