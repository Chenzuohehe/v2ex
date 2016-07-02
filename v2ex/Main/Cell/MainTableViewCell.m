//
//  MainTableViewCell.m
//  v2ex
//
//  Created by ChenZuo on 16/6/30.
//  Copyright © 2016年 chenzuo. All rights reserved.
//

#import "MainTableViewCell.h"
#import "UIImageView+WebCache.h"
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
//    NSString * iamgeUrl = [NSString stringWithFormat:@"%@%@",]
//    self.headImageView sd_setImageWithURL:[NSURL URLWithString:] placeholderImage:<#(UIImage *)#>
    
    
}


@end
