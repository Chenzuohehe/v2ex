//
//  FeedEntity.h
//  v2ex
//
//  Created by MAC on 16/7/1.
//  Copyright © 2016年 chenzuo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FeedEntity : NSObject

- (instancetype)initWithDictionary:(NSDictionary * )dictionary;

@property (copy , nonatomic  ) NSString     * identifier;
@property (copy , nonatomic  ) NSString     * content;
@property (copy , nonatomic  ) NSString     * content_rendered;
@property (assign , nonatomic) NSNumber     * created;
@property (assign , nonatomic) NSNumber     * postsId;

@property (copy , nonatomic  ) NSDictionary * member;
@property (copy , nonatomic  ) NSDictionary * node;
@property (assign , nonatomic) NSNumber     * replies;
@property (copy , nonatomic  ) NSString     * title;
@property (copy , nonatomic  ) NSString     * url;

@property (assign , nonatomic) NSNumber     * last_modified;
@property (assign , nonatomic) NSNumber     * last_touched;

@end
