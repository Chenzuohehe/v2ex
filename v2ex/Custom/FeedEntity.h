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

@property (copy , nonatomic  ) NSString     * identifier;
@property (copy , nonatomic  ) NSString     * content;
@property (copy , nonatomic  ) NSString     * content_rendered;
@property (assign , nonatomic) NSString     * created;
@property (assign , nonatomic) NSString     * replies;
@property (copy , nonatomic  ) NSString     * title;
@property (copy , nonatomic  ) NSString     * url;
@property (assign , nonatomic) NSString     * last_modified;
@property (assign , nonatomic) NSString     * last_touched;
@property (copy , nonatomic  ) NSString     * lastReply;

@property (strong , nonatomic  ) MemberModel * member;
@property (strong , nonatomic  ) NodeModel * node;
@end
