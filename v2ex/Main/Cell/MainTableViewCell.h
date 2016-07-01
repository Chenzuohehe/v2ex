//
//  MainTableViewCell.h
//  v2ex
//
//  Created by ChenZuo on 16/6/30.
//  Copyright © 2016年 chenzuo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainTableViewCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *tagLabel;
@property (weak, nonatomic) IBOutlet UIButton *replyNumberButton;
@property (weak, nonatomic) IBOutlet UILabel *replyStatusLabel;



@end
