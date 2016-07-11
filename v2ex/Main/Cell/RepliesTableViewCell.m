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
        self.nameLabel.text = [CommonUtil isEmpty:detail.member[@"username"]]?@"":detail.member[@"username"];
    }
    NSString * lastTouchString = [CommonUtil dateStringTime:detail.last_touched];
    self.repliesTimeLabel.text = [NSString stringWithFormat:@"%@前",lastTouchString];

    
//    NSString * htmlStr = [NSString stringWithFormat:@"<html> \n"
//                          "<head> \n"
//                          "<style type=\"text/css\"> \n"
//                          "body { font-family: \"%@\";}\n"
//                          "</style> \n"
//                          "</head> \n"
//                          "<body>%@</body> \n"
//                          "</html>", @"Lucida Grande", detail.content_rendered];
//    self.contentLabel.text = htmlStr;
    
    self.contentLabel.text = detail.content;
//    [self.repliesWebView loadHTMLString:htmlStr baseURL:nil];
}


@end
