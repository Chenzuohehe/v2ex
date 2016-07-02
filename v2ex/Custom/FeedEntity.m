//
//  FeedEntity.m
//  v2ex
//
//  Created by MAC on 16/7/1.
//  Copyright © 2016年 chenzuo. All rights reserved.
//

#import "FeedEntity.h"
#import "CommonUtil.h"

@implementation FeedEntity



- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    /**
     @property (copy , nonatomic) NSString * identifier;
     
     @property (copy , nonatomic) NSString * content;
     @property (copy , nonatomic) NSString * content_rendered;
     @property (assign , nonatomic) NSNumber * created;
     @property (assign , nonatomic) NSNumber * postsId;
     @property (assign , nonatomic) NSNumber * last_modified;
     @property (assign , nonatomic) NSNumber * last_touched;
     @property (copy , nonatomic) NSDictionary * member;
     @property (copy , nonatomic) NSDictionary * node;
     @property (assign , nonatomic) NSNumber * replies;
     @property (copy , nonatomic) NSString * title;
     @property (copy , nonatomic) NSString * url;
     */
    self = super.init;
    if (self) {
        _identifier = [self uniqueIdentifier];
        _content = [CommonUtil isEmpty:dictionary[@"content"]]?@"":dictionary[@"content"];
        _title = [CommonUtil isEmpty:dictionary[@"title"]]?@"":dictionary[@"title"];
        _content = [CommonUtil isEmpty:dictionary[@"content"]]?@"":dictionary[@"content"];
        _content_rendered = [CommonUtil isEmpty:dictionary[@"content_rendered"]]?@"":dictionary[@"content"];
        _created = dictionary[@"created"];
        _postsId = dictionary[@"id"];
        _last_modified = dictionary[@"last_modified"];
        _last_touched = dictionary[@"last_touched"];
        _replies = dictionary[@"replies"];
        _title = [CommonUtil isEmpty:dictionary[@"title"]]?@"":dictionary[@"title"];
        _url = [CommonUtil isEmpty:dictionary[@"url"]]?@"":dictionary[@"url"];
        
        if (![CommonUtil dictIsEmpty:dictionary[@"member"]]) {
            self.member = dictionary[@"member"];
        }
        if (![CommonUtil dictIsEmpty:dictionary[@"node"]]) {
            self.node = dictionary[@"node"];
        }
        
    }
    
    return self;
}

- (NSString *)uniqueIdentifier
{
    static NSInteger counter = 0;
    return [NSString stringWithFormat:@"unique-id-%@", @(counter++)];
}

@end
