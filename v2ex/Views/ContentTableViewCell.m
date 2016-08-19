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

- (void)setDetail:(DetailModel *)detail
{
    /**
     *  
     @property (weak, nonatomic) IBOutlet UILabel *titleLabel;
     @property (weak, nonatomic) IBOutlet UIImageView *headImageView;
     @property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
     @property (weak, nonatomic) IBOutlet UILabel *repliceTimeLabel;
     
     @property (weak, nonatomic) IBOutlet UILabel *contentLabel;
     @property (weak, nonatomic) IBOutlet UILabel *tagLabel;
     
     */
    
    NSString * iamgeUrl = [NSString stringWithFormat:@"https:%@",[CommonUtil isEmpty:detail.headImageUrl]?@"":detail.headImageUrl];
    [self.headImageView sd_setImageWithURL:[NSURL URLWithString:iamgeUrl] placeholderImage:nil];
    self.userNameLabel.text = [CommonUtil isEmpty:detail.userName]?@"":detail.userName;
    
    self.titleLabel.text = [CommonUtil isEmpty:detail.title]?@"":detail.title;
    self.repliceTimeLabel.text = [CommonUtil isEmpty:detail.repilesStatus]?@"":detail.repilesStatus;
    self.contentLabel.text = [CommonUtil isEmpty:detail.content]?@"":detail.content;
}



@end
