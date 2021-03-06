//
//  FeedEntity.h
//  v2ex
//
//  Created by MAC on 16/7/1.
//  Copyright © 2016年 chenzuo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MemberModel.h"
#import "NodeModel.h"

@interface FeedEntity : NSObject

- (instancetype)initWithDictionary:(NSDictionary * )dictionary;

@property (copy , nonatomic  ) NSString * identifier;
@property (copy , nonatomic  ) NSString * content;
@property (copy , nonatomic  ) NSString * content_rendered;
@property (copy , nonatomic  ) NSString * created;
@property (copy , nonatomic  ) NSString * replies;
@property (copy , nonatomic  ) NSString * title;
@property (copy , nonatomic  ) NSString * url;
@property (copy , nonatomic  ) NSString * last_modified;
@property (copy , nonatomic  ) NSString * last_touched;
@property (copy , nonatomic  ) NSString * lastReply;

@property (copy , nonatomic  ) NSString * replyStatus;

@property (strong , nonatomic  ) MemberModel * member;
@property (strong , nonatomic  ) NodeModel * node;
@end
