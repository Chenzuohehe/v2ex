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
    self = super.init;
    if (self) {
        _identifier       = [NSString stringWithFormat:@"%lld",[dictionary[@"id"] longLongValue]];
        _created          = [NSString stringWithFormat:@"%lld",[dictionary[@"created"] longLongValue]];
        _last_modified    = [NSString stringWithFormat:@"%lld",[dictionary[@"last_modified"] longLongValue]];
        _last_touched     = [NSString stringWithFormat:@"%lld",[dictionary[@"last_touched"] longLongValue]];
        _replies          = [NSString stringWithFormat:@"%lld",[dictionary[@"replies"] longLongValue]];
        
        _content          = [CommonUtil isEmpty:dictionary[@"content"]]?@"":dictionary[@"content"];
        _title            = [CommonUtil isEmpty:dictionary[@"title"]]?@"":dictionary[@"title"];
        _content          = [CommonUtil isEmpty:dictionary[@"content"]]?@"":dictionary[@"content"];
        _content_rendered = [CommonUtil isEmpty:dictionary[@"content_rendered"]]?@"":dictionary[@"content"];
        _title            = [CommonUtil isEmpty:dictionary[@"title"]]?@"":dictionary[@"title"];
        _url              = [CommonUtil isEmpty:dictionary[@"url"]]?@"":dictionary[@"url"];
        
        if (![CommonUtil dictIsEmpty:dictionary[@"member"]]) {
            self.member = dictionary[@"member"];
        }
        if (![CommonUtil dictIsEmpty:dictionary[@"node"]]) {
            self.node = dictionary[@"node"];
        }
        
    }
    
    return self;
}



@end
