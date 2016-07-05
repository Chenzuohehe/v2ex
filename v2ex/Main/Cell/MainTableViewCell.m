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
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}



- (void)setFeedEntity:(FeedEntity *)detail
{
    /**
     *  @property (weak, nonatomic) IBOutlet UIImageView *headImageView;
     @property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
     @property (weak, nonatomic) IBOutlet UILabel *tagLabel;
     @property (weak, nonatomic) IBOutlet UIButton *replyNumberButton;
     @property (weak, nonatomic) IBOutlet UILabel *replyStatusLabel;
     */
    
    if (![CommonUtil dictIsEmpty:detail.member]) {
        NSString * iamgeUrl = [NSString stringWithFormat:@"%@%@",REQUEST_HOST,[CommonUtil isEmpty:detail.member[@"avatar_normal"]]?@"":detail.member[@"avatar_normal"]];
        [self.headImageView sd_setImageWithURL:[NSURL URLWithString:iamgeUrl] placeholderImage:nil];
        self.userNameLabel.text = [CommonUtil isEmpty:detail.member[@"username"]]?@"":detail.member[@"username"];
    }
    
    if (![CommonUtil dictIsEmpty:detail.node]) {
        self.tagLabel.text = [CommonUtil isEmpty:detail.node[@"title"]]?@"":detail.node[@"title"];
        
    }
    
    self.titleLabel.text = [CommonUtil isEmpty:detail.title]?@"":detail.title;
    
    NSString * replyNumberStr = [NSString stringWithFormat:@"%@",detail.replies];
    replyNumberStr = [CommonUtil isEmpty:replyNumberStr]?@"":replyNumberStr;
    [self.replyNumberButton setTitle:replyNumberStr forState:UIControlStateNormal];
    
    
}


@end
